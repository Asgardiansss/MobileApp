import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../routes/app_pages.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterPageController());

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      body: Column(
        children: [
          const SizedBox(height: 137),
          const SizedBox(height: 140, width: 142),
          const SizedBox(height: 100),
          Expanded(
            child: Container(
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
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, right: 5, left: 5),
                      child: CustomTextField(
                        key: const Key("username"),
                        hintText: 'Username',
                        controller: controller.usernameController,
                        leadingIconPath: 'assets/icons/account.png',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
                      child: CustomTextField(
                        key: const Key("email"),
                        hintText: 'Email',
                        controller: controller.emailController,
                        leadingIconPath: 'assets/icons/mail.png',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
                      child: CustomTextField(
                        key: const Key("password"),
                        hintText: 'Password',
                        controller: controller.passwordController,
                        obscureText: true,
                        leadingIconPath: 'assets/icons/lock.png',
                      ),
                    ),
                    const SizedBox(height: 50),
                    Obx(() => SizedBox(
                      width: 360,
                      height: 55,
                      child: InkWell(
                        key: const Key("btn_register"),
                        onTap: () {
                          controller.register();
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
                              )
                            ],
                          ),
                          child: Center(
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                              "Sign Up",
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun?',
                          style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.LOGIN_PAGE);
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppColorsDark.third,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 52),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
