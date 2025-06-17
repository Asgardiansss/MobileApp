// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../model/berita_model.dart';
//
// class BeritaProvider {
//   static const String baseUrl = 'http://10.0.2.2:5000/berita'; // Android emulator
//
//   static Future<List<Berita>> fetchBerita() async {
//     final response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       return jsonData.map((e) => Berita.fromJson(e)).toList();
//     } else {
//       throw Exception('Gagal memuat berita');
//     }
//   }
// }
