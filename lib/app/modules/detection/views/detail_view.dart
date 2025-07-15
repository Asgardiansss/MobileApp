import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/modules/detection/views/detection_view.dart';
import 'package:mobile_app/constants/colors.dart';
import '../../../data/model/move.dart';
import '../controllers/detection_controller.dart';

class DetailView extends StatefulWidget {
  final MoveData data;
  const DetailView({super.key, required this.data});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final controller = Get.find<DetectionController>(); // Ganti Get.put -> Get.find!

  @override
  void initState() {
    super.initState();
    // controller.expectedLabel = widget.data.label;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        backgroundColor: AppColorsDark.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          data.label.replaceAll('_', ' '),
          style: const TextStyle(
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
                // Thumbnail
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
                    child: Image.asset(
                      'assets/images/im_detail.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  data.description,
                  style: const TextStyle(color: Colors.white70),
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
                ..._generateSteps(data.steps),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // Start Yoga Button
          Positioned(
            bottom: 22,
            left: 22,
            right: 22,
            child: Obx(() {
              return Container(
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
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    Get.toNamed('/detection', arguments: {
                      'expectedPose': data.label,
                      'movementType': data.moveType,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorsDark.primary,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Start Yoga',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              );
            }),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateSteps(List<String> steps) {
    final List<String> displayedSteps = steps.isNotEmpty
        ? steps
        : [
      'Mulailah dengan posisi berdiri atau duduk nyaman.',
      'Ikuti gerakan sesuai petunjuk instruktur atau panduan pose.',
      'Fokuskan napas dan rasakan peregangan.',
      'Tahan selama 30-60 detik dan ulangi jika perlu.',
    ];

    return displayedSteps
        .asMap()
        .entries
        .map((entry) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '${entry.key + 1}. ${entry.value}',
        style: const TextStyle(color: Colors.white70),
      ),
    ))
        .toList();
  }

}
