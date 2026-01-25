import './sekbid_model.dart';

class SekbidDetail {
  final Sekbid sekbid;
  final String deskripsi;
  final List<String> anggota;
  final DateTime tanggalDibentuk;
  final String ketua;

  SekbidDetail({
    required this.sekbid,
    required this.deskripsi,
    required this.anggota,
    required this.tanggalDibentuk,
    required this.ketua,
  });

  // Factory method untuk data contoh
  static SekbidDetail getSampleDetail(Sekbid sekbid) {
    return SekbidDetail(
      sekbid: sekbid,
      deskripsi: _getDeskripsi(sekbid.id),
      anggota: _getAnggota(sekbid.id),
      tanggalDibentuk: _getTanggalDibentuk(sekbid.id),
      ketua: _getKetua(sekbid.id),
    );
  }

  static String _getDeskripsi(int id) {
    switch (id) {
      case 1:
        return "Bertanggung jawab atas kegiatan keagamaan dan spiritual di sekolah";
      case 2:
        return "Menangani masalah kedisiplinan dan tata tertib siswa";
      case 3:
        return "Mengelola kegiatan olahraga dan kesehatan siswa";
      case 4:
        return "Mengembangkan bakat seni dan budaya siswa";
      case 5:
        return "Membina hubungan dengan alumni dan masyarakat";
      case 6:
        return "Mengelola perpustakaan dan literasi siswa";
      case 7:
        return "Menyelenggarakan kegiatan akademik dan kompetisi";
      case 8:
        return "Mengelola media informasi dan publikasi OSIS";
      case 9:
        return "Melakukan pengabdian masyarakat dan lingkungan";
      case 10:
        return "Mengembangkan kewirausahaan dan ekonomi siswa";
      default:
        return "Bidang OSIS yang bertanggung jawab atas kegiatan tertentu";
    }
  }

  static List<String> _getAnggota(int id) {
    return [
      "Anggota 1 (Ketua)",
      "Anggota 2",
      "Anggota 3",
      "Anggota 4",
      "Anggota 5",
    ];
  }

  static DateTime _getTanggalDibentuk(int id) {
    return DateTime(2024, 8, id);
  }

  static String _getKetua(int id) {
    return "Nama Ketua Sekbid $id";
  }
}
