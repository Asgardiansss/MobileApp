import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart'; // Import package fl_chart
import '../controllers/visualisasi_deteksi_controller.dart';

class VisualisasiDeteksiView extends GetView<VisualisasiDeteksiController> {
  const VisualisasiDeteksiView({super.key});

  @override
  Widget build(BuildContext context) {
    // Panggil load data saat build pertama kali
    controller.loadDetectionResults();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualisasi Hasil Deteksi'),
        centerTitle: true,
      ),
      body: Obx(() {
        // Kalau data masih kosong
        if (controller.detectionResults.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada data deteksi',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        // Ambil frekuensi data (map label -> count)
        final freqMap = controller.getFrequencyMap();

        // Data untuk Pie Chart
        final List<PieChartSectionData> pieSections = [];
        freqMap.forEach((key, value) {
          pieSections.add(PieChartSectionData(
            color: _getColorForLabel(key), // Custom color for each pose
            value: value.toDouble(),
            radius: 50,
            title: '',
            showTitle: false,  // No title inside the pie chart
          ));
        });

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ringkasan Deteksi:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Pie Chart untuk frekuensi tiap label
              Expanded(
                child: PieChart(
                  PieChartData(
                    sections: pieSections,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                  ),
                ),
              ),

              // Label Teks di bawah Chart
              const SizedBox(height: 20),
              const Text(
                'Jenis Gerakan Deteksi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Tampilkan label dengan frekuensi di bawah pie chart
              for (var entry in freqMap.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: _getColorForLabel(entry.key),
                      ),
                      const SizedBox(width: 10),
                      Text('${entry.key}: ${entry.value} kali'),
                    ],
                  ),
                ),
              const Divider(),

              const Text(
                'Detail Semua Deteksi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // Tampilkan list hasil deteksi secara detail
              Expanded(
                child: ListView.builder(
                  itemCount: controller.detectionResults.length,
                  itemBuilder: (context, index) {
                    final result = controller.detectionResults[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(result),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Function to return a color for each detected movement
  Color _getColorForLabel(String label) {
    switch (label) {
      case 'Big Toe Pose':
        return Colors.blue;
      case 'Bound Angle Pose':
        return Colors.green;
      case 'Bow Pose':
        return Colors.red;
      case 'Bridge Pose':
        return Colors.orange;
      case 'Cat Pose':
        return Colors.purple;
      case 'Child_s Pose':
        return Colors.yellow;
      case 'Corpse Pose':
        return Colors.cyan;
      case 'Downward-Facing Dog Pose':
        return Colors.teal;
      case 'Easy Pose':
        return Colors.pink;
      case 'Extended Triangle Pose':
        return Colors.indigo;
      case 'Head-to-Knee Pose':
        return Colors.brown;
      case 'Revolved Head-to-Knee Pose':
        return Colors.lime;
      case 'Seated Forward Bend':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
}
