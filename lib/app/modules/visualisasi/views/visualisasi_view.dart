import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../constants/colors.dart';
import '../controllers/visualisasi_controller.dart';

class VisualisasiView extends GetView<VisualisasiController> {
  const VisualisasiView({super.key});

  @override
  Widget build(BuildContext context) {
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
              // === Container untuk Column Chart ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Progress Latihan Mingguan',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(height: 170, child: ProgressBarChart()),
                    ],
                  ),
                ),
              ),

              // === Container untuk Pie Chart ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Distribusi Pose Yoga',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(height: 170, child: PosePieChart()),
                    ],
                  ),
                ),
              ),

              // === Container untuk Line Chart ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Kalori Terbakar Harian',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(height: 170, child: CaloriesLineChart()),
                    ],
                  ),
                ),
              ),

              // === Container untuk Bar Chart (Sesi Latihan) ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Jumlah Sesi Latihan Mingguan',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(height: 170, child: SessionsBarChart()),
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

// === Column Chart: Progress Latihan Mingguan ===
class ProgressBarChart extends StatelessWidget {
  const ProgressBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          _barGroup(0, 20),
          _barGroup(1, 15),
          _barGroup(2, 25),
          _barGroup(3, 10),
          _barGroup(4, 30),
          _barGroup(5, 0),
          _barGroup(6, 40),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                const days = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];
                return Text(days[value.toInt()], style: const TextStyle(color: Colors.white));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }

  BarChartGroupData _barGroup(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: y,
        color: Colors.lightBlueAccent,
        width: 18,
        borderRadius: BorderRadius.circular(4),
      ),
    ]);
  }
}

// === Pie Chart: Distribusi Pose Yoga ===
class PosePieChart extends StatelessWidget {
  const PosePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 40, title: 'Warrior\n40%', color: Colors.indigo, radius: 60),
          PieChartSectionData(value: 30, title: 'Tree\n30%', color: Colors.indigoAccent, radius: 60),
          PieChartSectionData(value: 30, title: 'Cobra\n30%', color: Colors.blue, radius: 60),
        ],
        sectionsSpace: 4,
        centerSpaceRadius: 30,
      ),
    );
  }
}

// === Line Chart: Kalori Terbakar Harian ===
class CaloriesLineChart extends StatelessWidget {
  const CaloriesLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 50),
              FlSpot(1, 80),
              FlSpot(2, 65),
              FlSpot(3, 90),
              FlSpot(4, 70),
              FlSpot(5, 100),
              FlSpot(6, 85),
            ],
            isCurved: true,
            color: Colors.orangeAccent,
            barWidth: 4,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString(), style: const TextStyle(color: Colors.white));
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }
}

// === Bar Chart: Jumlah Sesi Latihan Mingguan ===
class SessionsBarChart extends StatelessWidget {
  const SessionsBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          _barGroup(0, 3),
          _barGroup(1, 4),
          _barGroup(2, 2),
          _barGroup(3, 5),
          _barGroup(4, 3),
          _barGroup(5, 0),
          _barGroup(6, 6),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString(), style: const TextStyle(color: Colors.white));
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }

  BarChartGroupData _barGroup(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: y,
        color: Colors.greenAccent,
        width: 18,
        borderRadius: BorderRadius.circular(4),
      ),
    ]);
  }
}
