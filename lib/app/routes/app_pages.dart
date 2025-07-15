import 'package:get/get.dart';

import '../modules/all_blogs/bindings/all_blogs_binding.dart';
import '../modules/all_blogs/views/all_blogs_view.dart';
import '../modules/anxiety_page/bindings/anxiety_page_binding.dart';
import '../modules/anxiety_page/views/anxiety_page_view.dart';
import '../modules/berita/bindings/berita_binding.dart';
import '../modules/berita/views/berita_view.dart';
import '../modules/detail_stress_relief/bindings/detail_stress_relief_binding.dart';
import '../modules/detail_stress_relief/views/detail_stress_relief_view.dart';
import '../modules/detection/bindings/detection_binding.dart';
import '../modules/detection/views/detection_view.dart';
import '../modules/edit_profile_page/bindings/edit_profile_page_binding.dart';
import '../modules/edit_profile_page/views/edit_profile_page_view.dart';
import '../modules/get_started/bindings/get_started_binding.dart';
import '../modules/get_started/views/get_started_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
import '../modules/register_page/views/register_page_view.dart';
import '../modules/spalsh/bindings/spalsh_binding.dart';
import '../modules/spalsh/views/spalsh_view.dart';
import '../modules/stress_relief_page/bindings/stress_relief_page_binding.dart';
import '../modules/stress_relief_page/views/stress_relief_page_view.dart';
import '../modules/visualisasi/bindings/visualisasi_binding.dart';
import '../modules/visualisasi/views/visualisasi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPALSH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.SPALSH,
      page: () => const SpalshView(),
      binding: SpalshBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_PAGE,
      page: () => const EditProfilePageView(),
      binding: EditProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.GET_STARTED,
      page: () => const GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: _Paths.BERITA,
      page: () => const BeritaView(),
      binding: BeritaBinding(),
    ),
    GetPage(
      name: _Paths.VISUALISASI,
      page: () => const VisualisasiView(),
      binding: VisualisasiBinding(),
    ),
    GetPage(
      name: _Paths.ALL_BLOGS,
      page: () => AllBlogsView(),
      binding: AllBlogsBinding(),
    ),
    GetPage(
      name: _Paths.DETECTION,
      page: () => const DetectionView(),
      binding: DetectionBinding(),
    ),

    //view

  ];
}
