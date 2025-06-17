import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/colors.dart';
import '../controllers/edit_profile_page_controller.dart';

class EditProfilePageView extends GetView<EditProfilePageController> {
  const EditProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfilePageController>();

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        backgroundColor: AppColorsDark.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColorsDark.teksPrimary),
          iconSize: 16,
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColorsDark.teksPrimary,
            fontSize: 16,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 26),
          child: Column(
            children: [
              const SizedBox(height: 26),

              // === AVATAR + BUTTONS ===
              Container(
                width: double.infinity,
                height: 220,
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Obx(() {
                        final imageUrl = controller.imageUrl.value;
                        if (imageUrl.isEmpty) {
                          return const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Colors.grey, size: 50),
                          );
                        }
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(imageUrl),
                            onBackgroundImageError: (_, __) {
                              // fallback kalau gagal load dari BE
                              controller.imageUrl.value = '';
                            },
                          ),
                        );
                      }),


                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColorsDark.primary,
                              borderRadius: BorderRadius.circular(8),
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
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                fixedSize: const Size(130, 40),
                              ),
                              onPressed: () {
                                controller.pickImageFromGallery();
                              },
                              child: const Text(
                                'Galeri',
                                style: TextStyle(
                                  color: AppColorsDark.teksPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColorsDark.primary,
                              borderRadius: BorderRadius.circular(8),
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
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                fixedSize: const Size(130, 40),
                              ),
                              onPressed: () {
                                controller.pickImageFromCamera();
                              },
                              child: const Text(
                                'Kamera',
                                style: TextStyle(
                                  color: AppColorsDark.third,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
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

              const SizedBox(height: 26),

              // === FORM ===
              Container(
                width: double.infinity,
                height: 331,
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
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColorsDark.teksPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColorsDark.primary,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF575757),
                              offset: Offset(-2, -2),
                              blurRadius: 1,
                              inset: true,
                            ),
                            BoxShadow(
                              color: Color(0xFF000000),
                              offset: Offset(2, 2),
                              blurRadius: 1,
                              inset: true,
                            )
                          ],
                        ),
                        child: TextField(
                          controller: controller.usernameController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: GoogleFonts.dmSans(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          style: GoogleFonts.dmSans(
                            color: AppColorsDark.teksPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Email',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColorsDark.teksPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColorsDark.primary,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF575757),
                              offset: Offset(-2, -2),
                              blurRadius: 1,
                              inset: true,
                            ),
                            BoxShadow(
                              color: Color(0xFF000000),
                              offset: Offset(2, 2),
                              blurRadius: 1,
                              inset: true,
                            )
                          ],
                        ),
                        child: TextField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: GoogleFonts.dmSans(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          style: GoogleFonts.dmSans(
                            color: AppColorsDark.teksPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Password',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColorsDark.teksPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColorsDark.primary,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF575757),
                              offset: Offset(-2, -2),
                              blurRadius: 1,
                              inset: true,
                            ),
                            BoxShadow(
                              color: Color(0xFF000000),
                              offset: Offset(2, 2),
                              blurRadius: 1,
                              inset: true,
                            )
                          ],
                        ),
                        child: TextField(
                          controller: controller.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '*********',
                            hintStyle: GoogleFonts.dmSans(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          style: GoogleFonts.dmSans(
                            color: AppColorsDark.teksPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // === BUTTON SIMPAN ===
              Obx(() => SizedBox(
                width: 380,
                height: 55,
                child: InkWell(
                  onTap: controller.isLoading.value
                      ? null
                      : () {
                    controller.updateProfile();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColorsDark.primary,
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
                    child: Center(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                          color: AppColorsDark.third)
                          : Text(
                        "Simpan Perubahan",
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColorsDark.third,
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
