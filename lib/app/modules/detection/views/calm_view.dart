import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/modules/detection/controllers/detection_controller.dart';
import '../../../../constants/colors.dart';
import '../../../data/model/move.dart';
import 'detail_view.dart';

class CalmView extends GetView<DetectionController> {
  const CalmView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MoveData> calmList = [
      MoveData(
        moveType: 'calm',
        label: 'Child_s Pose',
        description:
        'Pose sederhana untuk menenangkan tubuh dan pikiran, sering digunakan untuk beristirahat dan memulihkan energi.',
        steps: [
          'Mulai dari posisi merangkak di matras.',
          'Turunkan pinggul ke arah tumit sambil merentangkan tangan ke depan.',
          'Letakkan dahi di matras dan relaksasikan bahu.',
          'Bernapaslah perlahan dan dalam selama 1-2 menit.',
        ],
      ),
      MoveData(
        moveType: 'calm',
        label: 'Corpse Pose',
        description:
        'Pose relaksasi penuh, membantu menenangkan sistem saraf dan menurunkan ketegangan.',
        steps: [
          'Berbaring telentang dengan tangan di samping tubuh.',
          'Biarkan telapak tangan menghadap ke atas, kaki terbuka selebar matras.',
          'Tutup mata dan fokus pada napas.',
          'Tetap dalam posisi ini selama 5-10 menit untuk relaksasi penuh.',
        ],
      ),
      MoveData(
        moveType: 'calm',
        label: 'Easy Pose',
        description:
        'Posisi duduk bersila yang menenangkan, ideal untuk meditasi dan pernapasan dalam.',
        steps: [
          'Duduk bersila di lantai dengan punggung tegak.',
          'Letakkan tangan di lutut dengan telapak tangan menghadap ke atas atau bawah.',
          'Tutup mata dan tarik napas dalam-dalam.',
          'Fokus pada napas selama 3-5 menit.',
        ],
      ),
      MoveData(
        moveType: 'calm',
        label: 'Head-to-Knee',
        description:
        'Regangan lembut yang membantu menenangkan pikiran dan meregangkan punggung dengan lembut.',
        steps: [
          'Duduk dengan satu kaki lurus dan satu kaki dilipat ke dalam.',
          'Tarik napas, lalu buang napas sambil membungkuk ke arah kaki yang lurus.',
          'Raih jari kaki jika memungkinkan, tanpa memaksakan.',
          'Tahan posisi ini selama 30-60 detik lalu ganti sisi.',
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        title: const Text(
          'Calm',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColorsDark.primary,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bagaimana Yoga membuat ketenangan?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yoga dalam kondisi tenang membantu mempertahankan keseimbangan emosi dan ketenangan batin. '
                  'Latihan yang lembut dan penuh kesadaran dapat memperdalam koneksi antara tubuh dan pikiran, menjaga fokus, serta meningkatkan kualitas tidur. '
                  'Yoga juga membantu memperkuat kemampuan untuk tetap hadir dan damai dalam berbagai situasi.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Relaxing Moves',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: calmList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final data = calmList[index];
                  return Card(
                    color: AppColorsDark.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
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
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Get.put(DetectionController());
                          Get.to(() => DetailView(data: data));
                        },


                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/im_detail.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  data.label.replaceAll('_', ' '),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
