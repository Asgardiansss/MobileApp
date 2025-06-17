import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/constants/colors.dart';
import '../controllers/detail_stress_relief_controller.dart';

class DetailStressReliefView extends GetView<DetailStressReliefController> {
  const DetailStressReliefView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        backgroundColor: AppColorsDark.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reclined Figure-4 Pose',
          style: TextStyle(
            color: AppColorsDark.teksPrimary,
            fontSize: 18,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF575757),
                        offset: Offset(-3, -3),
                        blurRadius: 3,
                      ),
                      BoxShadow(
                        color: Color(0xFF000000),
                        offset: Offset(3, 3),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/im_detail.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Jika kamu mengalami kekakuan otot di bagian bawah tubuh, terutama setelah duduk terlalu lama, cobalah variasi berbaring.',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Gerakan ini dikenal efektif dalam melepaskan ketegangan pada otot gluteus (bokong), pinggul, dan bagian punggung bawah. Dengan posisi tubuh yang lebih santai dibanding versi standar, pose ini membantu tubuh rileks sambil tetap memberi peregangan yang dalam dan bermanfaat.',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Langkah - langkah',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  '1. Berbaringlah telentang di matras dengan posisi tubuh rileks.',
                  '2. Tekuk lutut kanan, lalu silangkan pergelangan kaki kanan di atas paha kiri.',
                  '3. Pegang bagian belakang paha kiri dengan kedua tangan, lalu tarik perlahan ke arah dada hingga terasa peregangan pada bokong kanan.',
                  '4. Tahan posisi ini selama 30–60 detik sambil bernapas perlahan dan dalam.',
                  '5. Untuk melepaskan ketegangan secara lebih maksimal, kamu bisa sedikit mengayunkan tubuh ke kiri dan kanan.',
                  '6. Ulangi langkah yang sama untuk sisi sebaliknya.',
                  '7. Jika memerlukan dukungan tambahan, kamu bisa menekan telapak kaki kiri ke tembok untuk stabilitas ekstra.',
                ].map((step) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    step,
                    style: const TextStyle(color: Colors.white70),
                  ),
                )),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Positioned(
            bottom: 22,
            left: 22,
            right: 22,
            child: Container(
              decoration: BoxDecoration(
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
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorsDark.primary,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Aksi saat tombol diklik
                  },
                  child: const Text(
                    'Start Yoga',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
