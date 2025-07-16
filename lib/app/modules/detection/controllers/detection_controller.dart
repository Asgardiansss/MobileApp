import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class DetectionController extends GetxController {
  Interpreter? interpreter;
  List<String> labels = [];
  CameraController? cameraController;
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;
  RxBool isCameraInitialized = false.obs;

  final poseDetector = PoseDetector(
    options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
  );

  RxString predictedLabel = 'unknown'.obs;
  bool isDetecting = false;
  final isLoading = false.obs;
  final List<List<double>> sequenceBuffer = [];
  final int sequenceLength = 33;

  String? expectedLabel;
  MovementConfig? currentConfig;
  String? movementType;

  RxList<PoseLandmark> currentPoseLandmarks = <PoseLandmark>[].obs;

  final movementConfigs = {
    'anxiety': MovementConfig(
      modelPath: 'assets/models/anxiety.tflite',
      labelPath: 'assets/labels/label_anxiety.txt',
      threshold: 0.5,
    ),
    'calm': MovementConfig(
      modelPath: 'assets/models/calm.tflite',
      labelPath: 'assets/labels/label_calm.txt',
      threshold: 0.5,
    ),
    'depression': MovementConfig(
      modelPath: 'assets/models/depression.tflite',
      labelPath: 'assets/labels/label_depression.txt',
      threshold: 0.5,
    ),
    'stress_relief': MovementConfig(
      modelPath: 'assets/models/stress_relief.tflite',
      labelPath: 'assets/labels/label_stress_relief.txt',
      threshold: 0.5,
    ),
  };

  /// ✅ Dipanggil dari View sebelum startCamera
  Future<void> setDetectionParams({
    required String expectedPose,
    required String movementType,
  }) async {
    expectedLabel = expectedPose;
    this.movementType = movementType;

    final config = movementConfigs[movementType];
    if (config != null) {
      await loadModel(config);
    } else {
      debugPrint("❌ No model config for '$movementType'");
    }
  }

  @override
  void onClose() {
    stopCamera();
    interpreter?.close();
    super.onClose();
  }

  Future<void> loadModel(MovementConfig config) async {
    currentConfig = config;
    interpreter?.close();
    interpreter = await Interpreter.fromAsset(config.modelPath);

    final labelData = await rootBundle.loadString(config.labelPath);
    labels = labelData
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    debugPrint('✅ Loaded model & labels from config');
  }

  Future<void> startCamera() async {
    cameras = await availableCameras();
    await initializeCamera(selectedCameraIndex);
  }

  Future<void> stopCamera() async {
    await cameraController?.stopImageStream();
    await cameraController?.dispose();
    cameraController = null;
    isCameraInitialized.value = false;
    predictedLabel.value = 'unknown';
    sequenceBuffer.clear();
    currentPoseLandmarks.clear();
  }

  Future<void> switchCamera() async {
    if (cameras.isEmpty) {
      cameras = await availableCameras();
    }
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
    await stopCamera();
    await initializeCamera(selectedCameraIndex);
  }

  Future<void> initializeCamera(int cameraIndex) async {
    try {
      final selectedCamera = cameras[cameraIndex];

      cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;

      await Future.delayed(const Duration(milliseconds: 200));
      await cameraController!.startImageStream(processCameraImage);
    } catch (e) {
      debugPrint('❌ Camera init error: $e');
    }
  }

  List<double> softmax(List<double> logits) {
    final expList = logits.map((x) => exp(x)).toList();
    final sumExp = expList.reduce((a, b) => a + b);
    return expList.map((x) => x / sumExp).toList();
  }

  void processCameraImage(CameraImage image) async {
    if (isDetecting) return;
    isDetecting = true;

    try {
      if (interpreter == null || currentConfig == null) {
        debugPrint('⚠️ Interpreter belum diload, frame diabaikan.');
        return;
      }

      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final rotation = InputImageRotationValue.fromRawValue(
        cameraController!.description.sensorOrientation,
      ) ?? InputImageRotation.rotation0deg;

      final format = InputImageFormatValue.fromRawValue(image.format.raw);
      if (format == null) return;

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: format,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final poses = await poseDetector.processImage(inputImage);

      if (poses.isNotEmpty) {
        currentPoseLandmarks.value = poses.first.landmarks.values.toList();

        final keypoints = <double>[];
        for (final type in PoseLandmarkType.values) {
          final lm = poses.first.landmarks[type];
          keypoints.addAll([lm?.x ?? 0.0, lm?.y ?? 0.0, lm?.z ?? 0.0]);
        }

        if (keypoints.length == 99) {
          sequenceBuffer.add(keypoints);

          if (sequenceBuffer.length == sequenceLength) {
            final input = sequenceBuffer;
            final output = List.generate(33, (_) => List.filled(4, 0.0));
            interpreter!.run(input, output);

            final rawOutput = output.last;
            final predictions = softmax(rawOutput);
            final maxValue = predictions.reduce(max);
            final maxIndex = predictions.indexOf(maxValue);

            final result = labels[maxIndex].trim().toLowerCase();
            final expected = (expectedLabel ?? '').trim().toLowerCase();

            debugPrint("✅ Predicted: $result (confidence $maxValue)");
            debugPrint("Expected: $expected");

            predictedLabel.value = result == expected ? 'Benar' : 'Salah';

            // Hanya simpan hasil deteksi jika belum ada sebelumnya
            saveDetectionResult(result);

            sequenceBuffer.removeAt(0);
          }
        }
      } else {
        predictedLabel.value = 'no pose detected';
        currentPoseLandmarks.clear();
      }
    } catch (e) {
      debugPrint("❌ Pose detection error: $e");
    } finally {
      isDetecting = false;
    }
  }


// Tambahkan method untuk simpan hasil prediksi ke SharedPreferences
  Future<void> saveDetectionResult(String result) async {
    final prefs = await SharedPreferences.getInstance();
    // Ambil list lama (jika ada)
    final List<String> oldList = prefs.getStringList('detection_results') ?? [];

    // Cek apakah result sudah ada dalam list atau belum
    if (!oldList.contains(result)) {
      // Tambah hasil deteksi baru
      oldList.add(result);
      // Simpan ulang
      await prefs.setStringList('detection_results', oldList);
      debugPrint("✅ Deteksi '$result' berhasil disimpan.");
    } else {
      debugPrint("❌ Deteksi '$result' sudah ada sebelumnya.");
    }
  }


// Panggil method ini setiap update predictedLabel
  void updatePredictedLabel(String label) {
    predictedLabel.value = label;
    saveDetectionResult(label);
  }



}

class MovementConfig {
  final String modelPath;
  final String labelPath;
  final double threshold;

  MovementConfig({
    required this.modelPath,
    required this.labelPath,
    required this.threshold,
  });
}
