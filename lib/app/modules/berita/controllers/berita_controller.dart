import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../data/model/berita_model.dart';
import '../../../data/service/session_service.dart'; // tambahkan ini

class BeritaController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = false.obs;

  final _session = SessionService(); // instance SessionService

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles() async {
    isLoading.value = true;
    try {
      final token = await _session.getToken();

      if (token == null) {
        print('Token tidak ditemukan!');
        isLoading.value = false;
        return;
      }

      final response = await http.get(
        Uri.parse('https://backendcapstone.vercel.app/api/berita'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        articles.value = data.map((e) => Article.fromJson(e)).toList();
      } else {
        print('Failed to load articles');
      }
    } catch (e) {
      print('Error fetching articles: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
