import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/colors.dart';
import '../../../data/model/move.dart';
import '../controllers/detection_controller.dart';
import 'detail_view.dart';

class AnxietyView extends GetView<DetectionController> {
  const AnxietyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MoveData> stresList = [
      MoveData(
        moveType: 'anxiety',
        label: 'Big toe Pose',
        description: 'Membantu menenangkan pikiran dengan melibatkan peregangan intens pada punggung dan kaki, cocok untuk meredakan kegelisahan.',
        steps: [
          'Berdirilah dengan kaki rapat.',
          'Tarik napas dan angkat tangan ke atas.',
          'Buang napas, bungkukkan badan dan raih jempol kaki dengan tangan.',
          'Tahan posisi ini selama 30-60 detik sambil bernapas perlahan.',
          'Kembali ke posisi berdiri perlahan saat selesai.',
        ],
      ),
      MoveData(
        moveType: 'anxiety',
        label: 'Bound Angle Pose',
        description: 'Pose duduk terbuka yang menenangkan sistem saraf dan membantu melawan rasa panik.',
        steps: [
          'Duduklah di lantai, tekuk lutut dan dekatkan telapak kaki satu sama lain.',
          'Pegang kaki dengan kedua tangan.',
          'Jaga agar punggung tetap tegak dan relaks.',
          'Bernapas dalam selama 1-2 menit sambil menahan posisi.',
        ],
      ),
      MoveData(
        moveType: 'anxiety',
        label: 'Bow Pose',
        description: 'Membuka dada dan merangsang sistem saraf pusat untuk meredakan tekanan emosional.',
        steps: [
          'Berbaring tengkurap, tekuk lutut dan pegang pergelangan kaki dengan tangan.',
          'Tarik kaki ke belakang sambil mengangkat dada dari lantai.',
          'Tahan posisi selama 20-30 detik, bernapas dalam.',
          'Lepaskan perlahan dan rileks.',
        ],
      ),
      MoveData(
        moveType: 'anxiety',
        label: 'Revolved Head-to-Knee Pose',
        description: 'Memadukan peregangan dan rotasi tubuh untuk membantu mengurangi ketegangan mental dan fisik.',
        steps: [
          'Duduklah dengan satu kaki diluruskan dan kaki lainnya ditekuk ke dalam.',
          'Putar tubuh ke arah kaki lurus dan raih ujung kaki dengan tangan berlawanan.',
          'Angkat tangan lainnya ke atas dan tekuk ke samping untuk peregangan samping.',
          'Tahan selama 30-60 detik, lalu ganti sisi.',
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        title: const Text(
          'Anxiety Relief',
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
              'Bagaimana Yoga Membantu Meredakan Kecemasan?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yoga dapat membantu meredakan kecemasan dengan menenangkan sistem saraf dan membawa perhatian pada pernapasan serta tubuh. '
                  'Gerakan yang terfokus dan pernapasan terkontrol membantu mengalihkan pikiran dari kekhawatiran, menciptakan rasa aman dan stabil. '
                  'Dengan latihan rutin, yoga bisa mengurangi gejala kecemasan secara signifikan.',
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
                itemCount: stresList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final data = stresList[index];
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
