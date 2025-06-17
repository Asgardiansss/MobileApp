import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/app/modules/edit_profile_page/views/edit_profile_page_view.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfilePageController());

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back(); 
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Profile",
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColorsDark.teksPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Card pertama
                  Container(
                    width: double.infinity,
                    height: 160,
                    margin: const EdgeInsets.only(top: 60),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColorsDark.primary,
                        borderRadius: BorderRadius.circular(16),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 16.0),
                        child: Column(
                          children: [
                            Obx(() => Text(
                              controller.username.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75,
                    right: 30,
                    child: GestureDetector(
                      onTap: () {
                        print("Edit Profile Button Pressed");
                        Get.to(() => const EditProfilePageView());
                      },
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColorsDark.primary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF575757),
                              offset: Offset(-1, -1),
                              blurRadius: 2,
                            ),
                            BoxShadow(
                              color: Color(0xFF000000),
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Text(
                          'Edit',
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                            color: AppColorsDark.teksPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // Card 2 dengan grafik bar
              Container(
                width: double.infinity,
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColorsDark.primary,
                  borderRadius: BorderRadius.circular(16),
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lencana',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColorsDark.teksPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Row(
                          children: [
                            // Info Kalori & Waktu
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Calories',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12)),
                                Text('160,5kcal',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 12),
                                Text('Time',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12)),
                                Text('1:03:03',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(width: 16),
                            // Grafik Bar
                            Expanded(
                              child: BarChart(
                                BarChartData(
                                  barTouchData: BarTouchData(enabled: false),
                                  titlesData: FlTitlesData(
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, _) {
                                          const days = [
                                            'Mon',
                                            'Tue',
                                            'Wed',
                                            'Thu',
                                            'Fri',
                                            'Sat',
                                            'Sun'
                                          ];
                                          return Text(
                                            days[value.toInt()],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          );
                                        },
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                        sideTitles:
                                        SideTitles(showTitles: false)),
                                    topTitles: AxisTitles(
                                        sideTitles:
                                        SideTitles(showTitles: false)),
                                    rightTitles: AxisTitles(
                                        sideTitles:
                                        SideTitles(showTitles: false)),
                                  ),
                                  gridData: FlGridData(show: false),
                                  borderData: FlBorderData(show: false),
                                  barGroups: List.generate(7, (index) {
                                    final heights = [
                                      4.0,
                                      5.5,
                                      5.0,
                                      6.0,
                                      6.5,
                                      4.5,
                                      5.2
                                    ];
                                    return BarChartGroupData(
                                      x: index,
                                      barRods: [
                                        BarChartRodData(
                                          toY: heights[index],
                                          color: Colors.greenAccent,
                                          width: 8,
                                          borderRadius:
                                          BorderRadius.circular(4),
                                          backDrawRodData:
                                          BackgroundBarChartRodData(
                                            show: true,
                                            toY: 7,
                                            color: Colors.white24,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
