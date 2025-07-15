import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/colors.dart';
import '../../all_blogs/views/all_blogs_view.dart';
import '../../anxiety_page/views/anxiety_page_view.dart';
import '../../berita/controllers/berita_controller.dart';
import '../../detail_berita/views/detail_berita_view.dart';
import '../../detection/views/anxiety_view.dart';
import '../../detection/views/calm_view.dart';
import '../../detection/views/depression_view.dart';
import '../../detection/views/stres_view.dart';
import '../../profile_page/views/profile_page_view.dart';
import '../../stress_relief_page/views/stress_relief_page_view.dart';
import '../../visualisasi/views/visualisasi_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final beritaController = Get.put(BeritaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ProfilePageView());
                        },
                        child: Obx(() => CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: controller.imageUrl.value.isNotEmpty
                              ? NetworkImage(controller.imageUrl.value)
                              : const AssetImage('assets/images/avatar.png')
                          as ImageProvider,
                        )),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello, Welcome',
                            style: TextStyle(color: Colors.white70),
                          ),
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
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const VisualisasiView());
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.stacked_line_chart_sharp,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 54),

                const Text('Category',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      String categoryName = '';
                      String imagePath = '';
                      VoidCallback? onTap;

                      switch (index) {
                        case 0:
                          categoryName = 'Stress Relief';
                          imagePath = 'assets/icons/category_1.png';
                          onTap = () => Get.to(() => const StresView());
                          break;
                        case 1:
                          categoryName = 'Anxiety';
                          imagePath = 'assets/icons/category_2.png';
                          onTap = () => Get.to(() => const AnxietyView());
                          break;
                        case 2:
                          categoryName = 'Calm';
                          imagePath = 'assets/icons/category_3.png';
                          onTap = () => Get.to(() => const CalmView());
                          break;
                        case 3:
                          categoryName = 'Depression';
                          imagePath = 'assets/icons/category_4.png';
                          onTap = () => Get.to(() => const DepressionView());
                          break;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: onTap,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
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
                                  child: CircleAvatar(
                                    backgroundColor: AppColorsDark.primary,
                                    radius: 40,
                                    child: Image.asset(
                                      imagePath,
                                      width: 48,
                                      height: 48,
                                      color: Colors.cyan,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                categoryName,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 44),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Our Latest Blogs',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => AllBlogsView());
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: AppColorsDark.third,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Obx(() {
                  if (beritaController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (beritaController.articles.isEmpty) {
                    return const Center(
                        child: Text('No articles found.',
                            style: TextStyle(color: Colors.white70)));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: beritaController.articles.length > 4
                          ? 4
                          : beritaController.articles.length,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        final article = beritaController.articles[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => DetailBeritaView(article: article));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: AppColorsDark.primary,
                              boxShadow: [
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
                            margin: const EdgeInsets.symmetric(vertical: 11.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19.0, vertical: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    article.gambar,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 70,
                                        height: 70,
                                        color: Colors.grey,
                                        child: const Icon(Icons.broken_image,
                                            size: 30),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 14.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.judul.split(' ').length > 4
                                            ? '${article.judul.split(' ').sublist(0, 4).join(' ')}...'
                                            : article.judul,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        article.isi.split(' ').length > 10
                                            ? '${article.isi.split(' ').sublist(0, 10).join(' ')}...'
                                            : article.isi,
                                        style: const TextStyle(
                                          fontSize: 9,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Baca selengkapnya >',
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: AppColorsDark.third,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
