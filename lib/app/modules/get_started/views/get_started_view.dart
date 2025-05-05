import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/app/modules/login_page/views/login_page_view.dart';
import 'package:mobile_app/constants/colors.dart';

import '../controllers/get_started_controller.dart';

class GetStartedView extends GetView<GetStartedController> {
  const GetStartedView({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColorsDark.primary,
            ),
            Positioned(
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/images/container.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 520,
              right: 0,
              left: 0,
              child: Stack(
                children: [
                  Image.asset(
                      'assets/images/ShadowContainer.png'),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, top: 15, right: 24, bottom: 142),
                      child: Column(
                        children: [
                          Text(
                            'Smart Relaxation \nfor Tired Souls.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sora(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: AppColorsDark.teksPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Welcome to ZenPose, an innovative platform \ntwhere technology guides you to achieve \ncalm, relieve stress, and restore balance to  \nyour busy mind.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sora(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xffA2A2A2)),
                          ),
                          const SizedBox(height: 65),
                          SizedBox(
                            width: 330,
                            height: 64,
                            child: InkWell(
                              key: const Key("tombol"),
                              onTap: () {
                                Get.to(() => const LoginPageView());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColorsDark.primary,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFF575757),
                                      offset: Offset(-2, -2),
                                      blurRadius: 1,
                                      // inset: true
                                    ),
                                    BoxShadow(
                                      color: Color(0xFF000000),
                                      offset: Offset(2, 2),
                                      blurRadius: 1,
                                      // inset: true
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    key: const Key("gatel"),
                                    "Get Started",
                                    style: GoogleFonts.sora(
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
                ],
              ),
            ),
          ],
        )
    );
  }
}
