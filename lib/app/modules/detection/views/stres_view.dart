import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/modules/detection/controllers/detection_controller.dart';
import 'package:mobile_app/constants/colors.dart';
import '../../../data/model/move.dart';
import 'detail_view.dart';

class StresView extends GetView<DetectionController> {
  const StresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MoveData> stresList = [
      MoveData(
        moveType: 'stress_relief',
        label: 'Bridge Pose',
        description:
        'Pose ini membantu membuka dada dan memperkuat punggung bawah serta meredakan stres.',
        steps: [
          'Berbaring telentang dengan lutut ditekuk dan kaki rata di lantai.',
          'Letakkan tangan di samping tubuh dengan telapak tangan menghadap ke bawah.',
          'Dorong pinggul ke atas sambil menekan kaki ke lantai.',
          'Tahan posisi ini selama 30 detik hingga 1 menit sambil bernapas dalam.',
          'Turunkan pinggul perlahan dan rileks.',
        ],
      ),
      MoveData(
        moveType: 'stress_relief',
        label: 'Child_s Pose',
        description:
        'Pose istirahat ini membantu menenangkan sistem saraf dan melepaskan ketegangan di punggung dan pinggul.',
        steps: [
          'Mulailah dalam posisi berlutut dengan jari-jari kaki menyentuh dan lutut terpisah.',
          'Turunkan tubuh ke depan hingga dahi menyentuh lantai.',
          'Rentangkan lengan ke depan atau di samping tubuh.',
          'Bernapaslah perlahan dan dalam selama 1-3 menit.',
        ],
      ),
      MoveData(
        moveType: 'stress_relief',
        label: 'Extended Triangle Pose',
        description:
        'Pose ini membantu membuka dada dan pinggul, merangsang aliran energi dan mengurangi stres.',
        steps: [
          'Berdiri dengan kaki terbuka lebar.',
          'Putar kaki kanan ke luar dan kaki kiri sedikit ke dalam.',
          'Rentangkan tangan sejajar bahu, lalu condongkan badan ke arah kanan.',
          'Letakkan tangan kanan di tulang kering atau lantai, tangan kiri ke atas.',
          'Tahan selama 30 detik hingga 1 menit, lalu ganti sisi.',
        ],
      ),
      MoveData(
        moveType: 'stress_relief',
        label: 'Seated Forward Bend',
        description:
        'Pose ini memberikan peregangan mendalam pada punggung dan membantu menenangkan pikiran.',
        steps: [
          'Duduklah dengan kaki lurus ke depan.',
          'Tarik napas dan angkat lengan ke atas.',
          'Buang napas dan bungkukkan tubuh ke depan dari pinggul.',
          'Pegang kaki atau tulang kering sesuai kemampuan.',
          'Tahan posisi selama 1 menit sambil bernapas tenang.',
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        title: const Text(
          'Stress Relief',
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
              'Bagaimana Yoga Meringankan Stres?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yoga membantu menenangkan pikiran dan tubuh dengan mengaktifkan sistem saraf parasimpatis, yang berperan dalam menciptakan rasa rileks. '
                  'Saat berlatih yoga, pernapasan yang melambat membantu menurunkan tekanan darah dan detak jantung. '
                  'Hal ini efektif dalam mengurangi stres, menenangkan pikiran, serta meredakan rasa cemas dan tegang.',
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
