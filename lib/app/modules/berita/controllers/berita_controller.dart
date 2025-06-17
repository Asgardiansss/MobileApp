import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../data/model/berita_model.dart';

class BeritaController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://scraping-lac.vercel.app/berita'));
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
