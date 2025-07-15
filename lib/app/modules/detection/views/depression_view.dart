import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/modules/detection/controllers/detection_controller.dart';

import '../../../../constants/colors.dart';
import '../../../data/model/move.dart';
import 'detail_view.dart';

class DepressionView extends GetView<DetectionController> {
  const DepressionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MoveData> depressionList = [
      MoveData(
        moveType: 'depression',
        label: 'Bridge Pose',
        description:
        'Pose ini membantu membuka dada dan meningkatkan sirkulasi, yang dapat membantu meningkatkan suasana hati dan energi.',
        steps: [
          'Berbaring telentang dengan lutut ditekuk dan kaki di lantai, selebar pinggul.',
          'Letakkan tangan di samping tubuh.',
          'Tekan kaki ke lantai untuk mengangkat pinggul ke atas.',
          'Tahan selama beberapa napas, lalu turunkan perlahan.',
        ],
      ),
      MoveData(
        moveType: 'depression',
        label: 'Cat Pose',
        description:
        'Gerakan lembut yang menghubungkan pernapasan dengan gerakan untuk membantu meredakan ketegangan dan meningkatkan fokus.',
        steps: [
          'Mulai di posisi merangkak dengan pergelangan tangan di bawah bahu.',
          'Tarik napas, lengkungkan punggung ke bawah dan angkat kepala (Cow Pose).',
          'Buang napas, lengkungkan punggung ke atas dan turunkan kepala (Cat Pose).',
          'Ulangi selama 5–10 napas.',
        ],
      ),
      MoveData(
        moveType: 'depression',
        label: 'Child_s Pose',
        description:
        'Pose istirahat yang mendalam, memberikan rasa aman dan kenyamanan saat suasana hati sedang menurun.',
        steps: [
          'Mulai dari posisi merangkak.',
          'Turunkan pinggul ke tumit dan rentangkan lengan ke depan.',
          'Letakkan dahi di lantai dan relaksasikan bahu.',
          'Bernapaslah secara perlahan dan dalam selama 1–2 menit.',
        ],
      ),
      MoveData(
        moveType: 'depression',
        label: 'Downward-Facing Dog Pose',
        description:
        'Membantu meningkatkan aliran darah ke otak, menyegarkan pikiran dan mengurangi kelelahan mental.',
        steps: [
          'Mulai dari posisi merangkak.',
          'Angkat pinggul ke atas dan luruskan kaki membentuk huruf V terbalik.',
          'Jaga tangan selebar bahu dan kaki selebar pinggul.',
          'Tahan posisi ini selama 30–60 detik sambil bernapas dalam.',
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        title: const Text(
          'Depression Relief',
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
              'Bagaimana Yoga Membantu Mengatasi Depresi?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yoga dapat membantu meringankan gejala depresi dengan mengaktifkan sistem saraf parasimpatis dan menyeimbangkan hormon. '
                  'Latihan yang penuh perhatian dan berfokus pada pernapasan membantu mengurangi pikiran negatif dan meningkatkan koneksi dengan diri sendiri. '
                  'Yoga juga membantu meredakan kelelahan emosional dan memberikan rasa damai secara alami.',
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
                itemCount: depressionList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final data = depressionList[index];
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
                              const Icon(Icons.arrow_forward_ios, color: Colors.white),
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
