import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class VisualisasiController extends GetxController {
  final topWords = <MapEntry<String, int>>[].obs;
  final sumberCounts = <MapEntry<String, int>>[].obs;

  final stopwords = <String>{
    'dan', 'di', 'yang', 'untuk', 'dari', 'ke', 'pada', 'dengan', 'sebagai',
    'adalah', 'ini', 'atau', 'juga', 'karena', 'oleh', 'saat', 'sudah', 'tidak',
    // tambahkan stopwords lain sesuai kebutuhan
  };

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final db = await Db.create(
        'mongodb+srv://zenpose:capstone12345@capestone.o68xbne.mongodb.net/zenPoseDatabase?retryWrites=true&w=majority',
      );
      await db.open();
      final collection = db.collection('yogaNewsMultiSource');
      final data = await collection.find().toList();
      await db.close();

      if (data.isEmpty) {
        print('No data found');
        return;
      }

      // Hitung jumlah artikel per sumber
      final Map<String, int> sumberMap = {};
      for (var doc in data) {
        final sumber = (doc['sumber'] ?? 'Unknown').toString();
        sumberMap[sumber] = (sumberMap[sumber] ?? 0) + 1;
      }

      // Proses kata dari semua judul
      final allTitles = data.map((e) => e['judul']?.toString() ?? '').join(' ').toLowerCase();

      final words = allTitles
          .replaceAll(RegExp(r'[^a-z\s]'), ' ')
          .split(RegExp(r'\s+'))
          .where((word) => word.isNotEmpty && !stopwords.contains(word))
          .toList();

      final Map<String, int> wordCounts = {};
      for (var word in words) {
        wordCounts[word] = (wordCounts[word] ?? 0) + 1;
      }

      // Ambil Top 20 kata terbanyak
      final sortedWords = wordCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      topWords.assignAll(sortedWords.take(20));

      // Urutkan sumber berdasarkan jumlah artikel
      final sortedSumber = sumberMap.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      sumberCounts.assignAll(sortedSumber);

    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
