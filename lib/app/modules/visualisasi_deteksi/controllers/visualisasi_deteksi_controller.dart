import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisualisasiDeteksiController extends GetxController {
  RxList<String> detectionResults = <String>[].obs;

  // Load detection results from SharedPreferences
  Future<void> loadDetectionResults() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedResults = prefs.getStringList('detection_results');
    if (savedResults != null) {
      detectionResults.value = savedResults;
    }
  }

  // Get the frequency of each movement
  Map<String, int> getFrequencyMap() {
    final Map<String, int> freqMap = {};
    for (final result in detectionResults) {
      freqMap[result] = (freqMap[result] ?? 0) + 1;
    }
    return freqMap;
  }
}
