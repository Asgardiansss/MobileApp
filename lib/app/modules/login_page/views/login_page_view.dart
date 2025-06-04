import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../routes/app_pages.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginPageController());

    // Variabel untuk toggle obscureText
    final obscurePassword = true.obs;

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 207),
            SizedBox(
              height: 140,
              width: 142,
              child: Image.asset('assets/logo/logo.png'),
            ),
            const SizedBox(height: 120),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColorsDark.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF575757),
                    offset: Offset(-2, -2),
                    blurRadius: 1,
                  ),
                  BoxShadow(
                    color: Color(0xFF000000),
                    offset: Offset(2, 2),
                    blurRadius: 1,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, right: 5, left: 5, bottom: 0),
                      child: CustomTextField(
                        key: const Key("email"),
                        hintText: 'Email',
                        leadingIconPath: 'assets/icons/mail.png',
                        controller: controller.emailController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 5, left: 5, bottom: 0),
                      child: Obx(() => CustomTextField(
                        key: const Key("lock"),
                        hintText: 'Password',
                        leadingIconPath: 'assets/icons/lock.png',
                        controller: controller.passwordController,
                        obscureText: obscurePassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey, // Match den
                            size: 20,// gan leading icon
                          ),
                          onPressed: () {
                            obscurePassword.toggle(); // Toggle hide/show password
                          },
                        ),
                      )),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 360,
                      height: 55,
                      child: InkWell(
                        key: const Key("btn_login"),
                        onTap: () {
                          controller.login();
                        },
                        child: Obx(() => Container(
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
                              )
                            ],
                          ),
                          child: Center(
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : Text(
                              "Sign In",
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun?',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.REGISTER_PAGE);
                          },
                          child: Text(
                            'daftar',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppColorsDark.third,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 102),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}