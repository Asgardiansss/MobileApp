// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_app/constants/colors.dart';
//
// import '../../detection/controllers/detection_controller.dart';
// import '../../detection/views/detection_view.dart';
//
// class DetailStressReliefView extends StatefulWidget {
//   const DetailStressReliefView({super.key});
//
//   @override
//   State<DetailStressReliefView> createState() => _DetailStressReliefViewState();
// }
//
// class _DetailStressReliefViewState extends State<DetailStressReliefView> {
//   final controller = Get.put(DetectionController());
//
//   @override
//   void dispose() {
//     controller.stopCamera();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Pose yang diharapkan untuk gerakan ini
//     const expectedLabel = 'Child_s Pose';
//     const modelPath = 'assets/models/stress_relief.tflite';
//     const labelPath = 'assets/labels/label_stress_relief.txt';
//
//     return Scaffold(
//       backgroundColor: AppColorsDark.primary,
//       appBar: AppBar(
//         backgroundColor: AppColorsDark.primary,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Reclined Figure-4 Pose',
//           style: TextStyle(
//             color: AppColorsDark.teksPrimary,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 // IMAGE
//                 SizedBox(
//                   height: 200,
//                   width: double.infinity,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                     child: Image(
//                       image: AssetImage('assets/images/im_detail.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//
//                 // DESCRIPTION
//                 Text(
//                   'Jika kamu mengalami kekakuan otot di bagian bawah tubuh, terutama setelah duduk terlalu lama, cobalah variasi berbaring.',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Gerakan ini dikenal efektif dalam melepaskan ketegangan pada otot gluteus (bokong), pinggul, dan bagian punggung bawah...',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Langkah - langkah',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   '1. Berbaringlah telentang di matras dengan posisi tubuh rileks.\n'
//                       '2. Tekuk lutut kanan, lalu silangkan pergelangan kaki kanan di atas paha kiri.\n'
//                       '3. Pegang bagian belakang paha kiri dengan kedua tangan, lalu tarik perlahan...\n'
//                       '4. Tahan posisi ini selama 30–60 detik sambil bernapas perlahan dan dalam.\n'
//                       '5. Untuk melepaskan ketegangan lebih maksimal, kamu bisa sedikit mengayunkan tubuh ke kiri dan kanan.\n'
//                       '6. Ulangi langkah yang sama untuk sisi sebaliknya.\n'
//                       '7. Gunakan tembok sebagai bantuan jika perlu.',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),
//
//           // BUTTON
//           Positioned(
//             bottom: 22,
//             left: 22,
//             right: 22,
//             child: Obx(() {
//               return SizedBox(
//                 width: double.infinity,
//                 height: 54,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColorsDark.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     shadowColor: Colors.transparent,
//                   ),
//                   onPressed: controller.isLoading.value
//                       ? null
//                       : () async {
//                     controller.isLoading.value = true;
//
//                     controller.expectedPose = expectedLabel;
//                     await controller.loadModelFromCustomConfig(
//                       modelPath: modelPath,
//                       labelPath: labelPath,
//                     );
//
//                     controller.isLoading.value = false;
//
//                     // Arahkan ke halaman kamera
//                     Get.to(() => const DetectionView());
//                   },
//                   child: controller.isLoading.value
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                     'Start Yoga',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
