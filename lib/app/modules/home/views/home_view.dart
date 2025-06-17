import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/colors.dart';
import '../../anxiety_page/views/anxiety_page_view.dart';
import '../../berita/controllers/berita_controller.dart';
import '../../detail_berita/views/detail_berita_view.dart';
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
                              : const AssetImage('assets/images/avatar.png') as ImageProvider,
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
                      const SizedBox(width: 150),
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
                        fontWeight: FontWeight.bold
                    )
                ),
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
                          onTap = () => Get.to(() => const StressReliefPageView());
                          break;
                        case 1:
                          categoryName = 'Anxiety';
                          imagePath = 'assets/icons/category_2.png';
                          onTap = () => Get.to(() => const AnxietyPageView());
                          break;
                        case 2:
                          categoryName = 'Calm';
                          imagePath = 'assets/icons/category_3.png';
                          onTap = () => Get.to(() => const StressReliefPageView());
                          break;
                        case 3:
                          categoryName = 'Depression';
                          imagePath = 'assets/icons/category_4.png';
                          onTap = () => Get.to(() => const AnxietyPageView());
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

                const Text('Popular Process',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      String imagePath;
                      String title;

                      switch (index) {
                        case 0:
                          imagePath = 'assets/images/im_popular1.png';
                          title = 'Morning Flow';
                          break;
                        case 1:
                          imagePath = 'assets/images/im_popular2.png';
                          title = 'Stretch & Breathe';
                          break;
                        case 2:
                          imagePath = 'assets/images/im_popular3.png';
                          title = 'Evening Relax';
                          break;
                        case 3:
                          imagePath = 'assets/images/im_popular4.png';
                          title = 'Core Strength';
                          break;
                        default:
                          imagePath = 'assets/images/default.png';
                          title = 'Yoga Practice';
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Container(
                                width: 160,
                                height: 120,
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Container(
                                width: 160,
                                height: 120,
                                color: Colors.black.withOpacity(0.3),
                              ),

                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                                  color: Colors.black.withOpacity(0.5),
                                  child: Text(
                                    title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 44),

                const Text('Our Latest Blogs',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Obx(() {
                  if (beritaController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (beritaController.articles.isEmpty) {
                    return const Text('No articles found', style: TextStyle(color: Colors.white70));
                  }

                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: beritaController.articles.length,
                      itemBuilder: (context, index) {
                        final article = beritaController.articles[index];
                        final isFirst = index == 0;

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => DetailBeritaView(article: article));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: isFirst ? 6 : 0,
                              right: 16,
                              top: 8,
                              bottom: 8,
                            ),
                            width: 200,
                            decoration: BoxDecoration(
                              color: AppColorsDark.primary,
                              borderRadius: BorderRadius.circular(16),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    article.gambar,
                                    height: 140,
                                    width: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 140,
                                        width: 200,
                                        color: Colors.grey,
                                        child: const Icon(Icons.broken_image, size: 50),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.judul,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        article.isi,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
