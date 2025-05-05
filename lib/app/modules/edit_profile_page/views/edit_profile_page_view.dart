import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/colors.dart';
import '../controllers/edit_profile_page_controller.dart';

class EditProfilePageView extends GetView<EditProfilePageController> {
  const EditProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
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
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/images/avatar.png'),
                          ),
                        ),
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
                                onPressed: () {},
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
                                onPressed: () {},
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
                // Card 2 (Username input)
                Container(
                  width: double.infinity,
                  height: 142,
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColorsDark.teksPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColorsDark.primary,
                            hintText: 'Aqnaazmy',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColorsDark.teksThird,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColorsDark.teksThird,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          style: TextStyle(
                            color: AppColorsDark.teksPrimary,
                            fontSize: 16,
                          ),
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                // Card 3 (Gender, Height, Weight, Birthdate inputs)
                Container(
                  width: double.infinity,
                  height: 280,
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
                      children: [
                        // Gender input
                        SizedBox(
                          width: 360,
                          height: 45,
                          child: InkWell(
                            onTap: () {},
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 20,
                                          height: 20,
                                          child: ColorFiltered(
                                            colorFilter: const ColorFilter.mode(
                                              AppColorsLight.teksThird,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'Laki-laki',
                                        style: TextStyle(
                                          color: AppColorsLight.teksThird,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Height input
                        SizedBox(
                          width: 360,
                          height: 45,
                          child: InkWell(
                            onTap: () {},
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 20,
                                          height: 20,
                                          child: ColorFiltered(
                                            colorFilter: const ColorFilter.mode(
                                              AppColorsLight.teksThird,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        '174,0 cm',
                                        style: TextStyle(
                                          color: AppColorsLight.teksThird,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Weight input
                        SizedBox(
                          width: 360,
                          height: 45,
                          child: InkWell(
                            onTap: () {},
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 20,
                                          height: 20,
                                          child: ColorFiltered(
                                            colorFilter: const ColorFilter.mode(
                                              AppColorsLight.teksThird,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        '60 kg',
                                        style: TextStyle(
                                          color: AppColorsLight.teksThird,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Birthdate input
                        SizedBox(
                          width: 360,
                          height: 45,
                          child: InkWell(
                            onTap: () {},
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 20,
                                          height: 20,
                                          child: ColorFiltered(
                                            colorFilter: const ColorFilter.mode(
                                              AppColorsLight.teksThird,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        '12 Desember 1999',
                                        style: TextStyle(
                                          color: AppColorsLight.teksThird,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                // Save Button
                SizedBox(
                  width: 380,
                  height: 55,
                  child: InkWell(
                    onTap: () {},
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
                        child: Text(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
