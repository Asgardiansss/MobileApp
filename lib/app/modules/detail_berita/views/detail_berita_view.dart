import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/constants/colors.dart';
import '../../../data/model/berita_model.dart';
import '../controllers/detail_berita_controller.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailBeritaView extends GetView<DetailBeritaController> {
  final Article article;
  const DetailBeritaView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Berita',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColorsDark.primary,
        elevation: 0,
      ),
      backgroundColor: AppColorsDark.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.judul,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColorsDark.teksPrimary,
              ),
            ),
            const SizedBox(height: 5),
            // Gak ada createdAt di model lo, jadi gua kasih placeholder aja
            const Text(
              'Diterbitkan: Hari ini',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
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
                child: Image.network(
                  article.gambar,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 26),
            Html(
              data: article.isi,
              style: {
                "body": Style(
                  fontSize: FontSize(14),
                  color: AppColorsDark.teksPrimary,
                  lineHeight: LineHeight(1.5),
                  textAlign: TextAlign.justify
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
