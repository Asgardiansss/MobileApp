import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:mobile_app/app/routes/app_pages.dart';
import '../controllers/profile_page_controller.dart';
import 'login_history_page.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfilePageController());

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        return SafeArea(
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
                            Text(
                              controller.username.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              controller.email.value,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: controller.imageUrl.value.isEmpty
                            ? const CircleAvatar(
                          key: ValueKey("empty"),
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white, size: 40),
                        )
                            : CircleAvatar(
                          key: ValueKey("loaded"),
                          radius: 50,
                          backgroundImage: NetworkImage(controller.imageUrl.value),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // Card Grafik Bar
              // GANTI DENGAN:
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                child: Column(
                  children: [
                    _buildProfileButton(
                      icon: Icons.edit,
                      title: 'Edit Profile',
                      onTap: () {
                        Get.toNamed(Routes.EDIT_PROFILE_PAGE);
                      },
                    ),
                    _buildProfileButton(
                      icon: Icons.info_outline,
                      title: 'About',
                      onTap: () {
                        // Tambahkan route atau dialog tentang aplikasi
                        Get.snackbar('About', 'Yoga App versi 1.0');
                      },
                    ),
                    _buildProfileButton(
                      icon: Icons.history,
                      title: 'Login History',
                      onTap: () {
                        Get.to(() => LoginHistoryPage());
                      },
                    ),
                    _buildProfileButton(
                      icon: Icons.access_time,
                      title: 'Detect History',
                      onTap: () {
                        // Tambahkan route ke deteksi history
                        Get.snackbar('Detect History', 'Fitur detect history coming soon');
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Tombol Logout
              // Tambahkan di dalam Column button profile, setelah _buildProfileButton lain:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                child: Container(
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
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.redAccent),
                    onTap: _confirmLogout,
                  ),
                ),
              ),


            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14), // 🔥 Jarak antar button
      child: Container(
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
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
          onTap: onTap,
        ),
      ),
    );
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: Get.context!,
      builder: (context) => Dialog(
        backgroundColor: AppColorsDark.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColorsDark.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Color(0xFF575757), offset: Offset(-2, -2), blurRadius: 1),
              BoxShadow(color: Color(0xFF000000), offset: Offset(2, 2), blurRadius: 1),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColorsDark.teksPrimary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Apakah kamu yakin ingin logout?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColorsDark.teksPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(false),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColorsDark.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Color(0xFF575757), offset: Offset(-2, -2), blurRadius: 1),
                          BoxShadow(color: Color(0xFF000000), offset: Offset(2, 2), blurRadius: 1),
                        ],
                      ),
                      child: const Text(
                        "Batal",
                        style: TextStyle(
                          color: AppColorsDark.teksPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(true),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColorsDark.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Color(0xFF575757), offset: Offset(-2, -2), blurRadius: 1),
                          BoxShadow(color: Color(0xFF000000), offset: Offset(2, 2), blurRadius: 1),
                        ],
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (shouldLogout ?? false) {
      await controller.authService.logout();
      Get.offAllNamed(Routes.LOGIN_PAGE);
    }
  }




}
