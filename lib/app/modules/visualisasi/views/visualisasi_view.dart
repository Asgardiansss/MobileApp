import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../controllers/visualisasi_controller.dart';

// Ganti ini dengan path yang sesuai di projekmu
import '../../../../constants/colors.dart';

class VisualisasiView extends GetView<VisualisasiController> {
  const VisualisasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VisualisasiController>();

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        backgroundColor: AppColorsDark.primary,
        foregroundColor: Colors.white,
        title: const Text('Visualisasi Yoga'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // === Container untuk Top Words Bar Chart ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColorsDark.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF575757),
                        offset: Offset(-2, -2),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: Color(0xFF000000),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Tren Kata Terbanyak (Top 20)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 170,
                        child: Obx(() {
                          if (controller.topWords.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final barGroups = controller.topWords
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final word = entry.value.key;
                            final freq = entry.value.value.toDouble();

                            return BarChartGroupData(
                              x: index,
                              barsSpace: 6,
                              barRods: [
                                BarChartRodData(
                                  toY: freq,
                                  color: Colors.blueAccent,
                                  width: 18,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ],
                            );
                          }).toList();

                          return BarChart(
                            BarChartData(
                              maxY:
                              controller.topWords.first.value.toDouble() * 1.2,
                              barGroups: barGroups,
                              alignment: BarChartAlignment.spaceBetween,
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() < 0 ||
                                          value.toInt() >=
                                              controller.topWords.length)
                                        return const SizedBox();
                                      final word =
                                          controller.topWords[value.toInt()].key;
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Text(word,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white)),
                                        ),
                                      );
                                    },
                                    reservedSize: 60,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      return Text(value.toInt().toString(),
                                          style:
                                          const TextStyle(color: Colors.white));
                                    },
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              // === Container untuk Sumber Counts Bar Chart ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColorsDark.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF575757),
                        offset: Offset(-2, -2),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: Color(0xFF000000),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Jumlah Artikel per Sumber',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 170,
                        child: Obx(() {
                          if (controller.sumberCounts.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final barGroups = controller.sumberCounts
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final sumber = entry.value.key;
                            final jumlah = entry.value.value.toDouble();

                            return BarChartGroupData(
                              x: index,
                              barsSpace: 6,
                              barRods: [
                                BarChartRodData(
                                  toY: jumlah,
                                  color: Colors.deepOrange,
                                  width: 18,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ],
                            );
                          }).toList();

                          return BarChart(
                            BarChartData(
                              maxY: (controller.sumberCounts.first.value
                                  .toDouble() *
                                  1.2),
                              barGroups: barGroups,
                              alignment: BarChartAlignment.spaceAround,
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() < 0 ||
                                          value.toInt() >=
                                              controller.sumberCounts.length)
                                        return const SizedBox();
                                      final sumber = controller
                                          .sumberCounts[value.toInt()].key;
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Text(
                                            sumber,
                                            style: const TextStyle(
                                                fontSize: 12, color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                    reservedSize: 80,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      return Text(value.toInt().toString(),
                                          style:
                                          const TextStyle(color: Colors.white));
                                    },
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
