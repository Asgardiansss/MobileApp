// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
//
// import '../../../../constants/colors.dart';
// import '../../detail_stress_relief/views/detail_stress_relief_view.dart';
// import '../controllers/anxiety_page_controller.dart';
//
// class AnxietyPageView extends GetView<AnxietyPageController> {
//   const AnxietyPageView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColorsDark.primary,
//       appBar: AppBar(
//         backgroundColor: AppColorsDark.primary,
//         foregroundColor: Colors.white,
//         title: const Text('Anxiety'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Bagaimana Yoga Mengatasi Kecemasan',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               'Yoga membantu meredakan kecemasan dengan menghentikan pola pikir negatif lewat gerakan sadar dan napas terkontrol. Latihan ini menenangkan pikiran, menurunkan detak jantung dan tekanan darah, serta mengaktifkan respons saraf yang lebih rileks. Dengan rutin, yoga membangun kesadaran diri dan kemampuan mengelola stres. Yoga idealnya digunakan sebagai pelengkap terapi dan obat.',
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Relaxing Moves',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: [
//                   // Card 1
//                   Card(
//                     color: AppColorsDark.primary,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     elevation: 0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColorsDark.primary,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0xFF575757),
//                             offset: Offset(-2, -2),
//                             blurRadius: 1,
//                           ),
//                           BoxShadow(
//                             color: Color(0xFF000000),
//                             offset: Offset(2, 2),
//                             blurRadius: 1,
//                           ),
//                         ],
//                       ),
//                       child: SizedBox(
//                         height: 100,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.asset(
//                                   'assets/images/card.png',
//                                   width: 60,
//                                   height: 60,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               const Expanded(
//                                 child: Text(
//                                   'Sun Salutation A, variation',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                               const Icon(Icons.arrow_forward_ios, color: Colors.white),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Card 2
//                   Card(
//                     color: AppColorsDark.primary,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     elevation: 0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColorsDark.primary,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0xFF575757),
//                             offset: Offset(-2, -2),
//                             blurRadius: 1,
//                           ),
//                           BoxShadow(
//                             color: Color(0xFF000000),
//                             offset: Offset(2, 2),
//                             blurRadius: 1,
//                           ),
//                         ],
//                       ),
//                       child: SizedBox(
//                         height: 100,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(12),
//                           onTap: () {
//                             Get.to(() => const DetailStressReliefView());
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.asset(
//                                     'assets/images/card.png',
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 const Expanded(
//                                   child: Text(
//                                     'Balasana (Child’s Pose)',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 const Icon(Icons.arrow_forward_ios, color: Colors.white),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Card 3
//                   Card(
//                     color: AppColorsDark.primary,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     elevation: 0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColorsDark.primary,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0xFF575757),
//                             offset: Offset(-2, -2),
//                             blurRadius: 1,
//                           ),
//                           BoxShadow(
//                             color: Color(0xFF000000),
//                             offset: Offset(2, 2),
//                             blurRadius: 1,
//                           ),
//                         ],
//                       ),
//                       child: SizedBox(
//                         height: 100,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(12),
//                           onTap: () {
//                             Get.to(() => const DetailStressReliefView());
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.asset(
//                                     'assets/images/card.png',
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 const Expanded(
//                                   child: Text(
//                                     'Uttanasana (Standing Forward Bend)',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 const Icon(Icons.arrow_forward_ios, color: Colors.white),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Card 4
//                   Card(
//                     color: AppColorsDark.primary,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     elevation: 0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColorsDark.primary,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0xFF575757),
//                             offset: Offset(-2, -2),
//                             blurRadius: 1,
//                           ),
//                           BoxShadow(
//                             color: Color(0xFF000000),
//                             offset: Offset(2, 2),
//                             blurRadius: 1,
//                           ),
//                         ],
//                       ),
//                       child: SizedBox(
//                         height: 100,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(12),
//                           onTap: () {
//                             Get.to(() => const DetailStressReliefView());
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.asset(
//                                     'assets/images/card.png',
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 const Expanded(
//                                   child: Text(
//                                     'Malasana (Garland Pose)',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 const Icon(Icons.arrow_forward_ios, color: Colors.white),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Container(
//             //   decoration: BoxDecoration(
//             //     color: AppColorsDark.primary,
//             //     borderRadius: BorderRadius.circular(12),
//             //     boxShadow: [
//             //       BoxShadow(
//             //         color: const Color(0xFF575757),
//             //         offset: const Offset(-2, -2),
//             //         blurRadius: 1,
//             //       ),
//             //       BoxShadow(
//             //         color: const Color(0xFF000000),
//             //         offset: const Offset(2, 2),
//             //         blurRadius: 1,
//             //       ),
//             //     ],
//             //   ),
//             //   child: SizedBox(
//             //     width: double.infinity,
//             //     child: ElevatedButton(
//             //       style: ElevatedButton.styleFrom(
//             //         elevation: 0, // Hindari shadow default ElevatedButton
//             //         backgroundColor: Colors.transparent, // transparan agar pakai warna Container
//             //         foregroundColor: AppColorsDark.teksPrimary,
//             //         shadowColor: Colors.transparent,
//             //         shape: RoundedRectangleBorder(
//             //           borderRadius: BorderRadius.circular(12),
//             //         ),
//             //       ),
//             //       onPressed: () {
//
//             //       },
//             //       child: const Padding(
//             //         padding: EdgeInsets.symmetric(vertical: 16),
//             //         child: Text('Start Yoga'),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
