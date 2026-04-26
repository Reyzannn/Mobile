class Sekbid {
  final int id;
  final String title;
  final String? deskripsi;
  final int programKerjaCount;

  Sekbid({
    required this.id,
    required this.title,
    this.deskripsi,
    this.programKerjaCount = 0,
  });

  factory Sekbid.fromJson(Map<String, dynamic> json) {
    return Sekbid(
      id: json['id'],
      title: json['title'],
      deskripsi: json['deskripsi'],
      programKerjaCount: json['program_kerja']?[0]?['count'] ?? 0,
    );
  }
}
