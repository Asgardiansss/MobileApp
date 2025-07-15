import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../../../../constants/colors.dart';
import '../controllers/detection_controller.dart';

class DetectionView extends StatefulWidget {
  const DetectionView({super.key});

  @override
  State<DetectionView> createState() => _DetectionViewState();
}

class _DetectionViewState extends State<DetectionView> {
  final controller = Get.put(DetectionController());

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      controller.setDetectionParams(
        expectedPose: args['expectedPose'],
        movementType: args['movementType'],
      );
    }

    controller.startCamera();
  }


  @override
  void dispose() {
    controller.stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        backgroundColor: AppColorsDark.primary,
        title: const Text('Detection Camera'),
        centerTitle: true,
        elevation: 2,
        foregroundColor: AppColorsDark.teksPrimary,
      ),
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        return Stack(
          children: [
            Positioned.fill(
              child: CameraPreview(controller.cameraController!),
            ),

            Positioned.fill(
              child: CustomPaint(
                painter: PosePainter(controller.currentPoseLandmarks),
              ),
            ),

            // Bagian bawah UI
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                decoration: const BoxDecoration(
                  color: AppColorsDark.primary,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Text(
                      controller.predictedLabel.value != 'no pose detected'
                          ? 'Detected: ${controller.predictedLabel.value}'
                          : 'No pose detected',
                      style: const TextStyle(
                        color: AppColorsDark.third,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: controller.switchCamera,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                        decoration: BoxDecoration(
                          color: AppColorsDark.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF575757),
                              offset: Offset(-2, -2),
                              blurRadius: 1,
                            ),
                            BoxShadow(
                              color: Color(0xFF000000),
                              offset: Offset(2, 2),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.flip_camera_android, color: AppColorsDark.teksPrimary),
                            SizedBox(width: 8),
                            Text(
                              'Switch Camera',
                              style: TextStyle(
                                color: AppColorsDark.teksPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class PosePainter extends CustomPainter {
  final List<PoseLandmark>? landmarks;

  PosePainter(this.landmarks);

  @override
  void paint(Canvas canvas, Size size) {
    if (landmarks == null || landmarks!.isEmpty) return;

    final paint = Paint()
      ..color = AppColorsDark.aksen
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    for (var lm in landmarks!) {
      canvas.drawCircle(Offset(lm.x * size.width, lm.y * size.height), 6, paint);
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.landmarks != landmarks;
  }
}
