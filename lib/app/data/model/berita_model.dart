class Article {
  final String judul;
  final String isi;
  final String gambar;

  Article({
    required this.judul,
    required this.isi,
    required this.gambar,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      judul: json['judul'] ?? '',
      isi: json['isi'] ?? '',
      gambar: json['gambar'] ?? '',
    );
  }
}
