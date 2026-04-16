import './sekbid_model.dart';

class SekbidDetail {
  final Sekbid sekbid;
  final String deskripsi;
  final List<String> anggota;
  final DateTime tanggalDibentuk;
  final String ketua;
  final List<ProgramKerja> programKerja; // Tambahkan ini

  SekbidDetail({
    required this.sekbid,
    required this.deskripsi,
    required this.anggota,
    required this.tanggalDibentuk,
    required this.ketua,
    required this.programKerja, // Tambahkan ini
  });

  // Factory method untuk data contoh
  static SekbidDetail getSampleDetail(Sekbid sekbid) {
    return SekbidDetail(
      sekbid: sekbid,
      deskripsi: _getDeskripsi(sekbid.id),
      anggota: _getAnggota(sekbid.id),
      tanggalDibentuk: _getTanggalDibentuk(sekbid.id),
      ketua: _getKetua(sekbid.id),
      programKerja: _getProgramKerja(sekbid.id), // Tambahkan ini
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

  // TAMBAHKAN METHOD INI UNTUK PROGRAM KERJA
  static List<ProgramKerja> _getProgramKerja(int id) {
    final programKerjaList = <ProgramKerja>[];
    
    // Program kerja berdasarkan sekbid
    switch (id) {
      case 1: // Sekbid 1 - Keagamaan
        programKerjaList.addAll([
          ProgramKerja(
            nama: 'Pesantren Kilat Ramadhan',
            deskripsi: 'Menyelenggarakan pesantren kilat selama bulan Ramadhan untuk seluruh siswa',
            status: 'Berjalan',
            tanggalMulai: DateTime(2024, 3, 10),
            tanggalSelesai: DateTime(2024, 4, 10),
            progress: 60,
          ),
          ProgramKerja(
            nama: 'Kajian Rutin Mingguan',
            deskripsi: 'Mengadakan kajian keagamaan setiap hari Jumat setelah shalat Jumat',
            status: 'Selesai',
            tanggalMulai: DateTime(2024, 1, 5),
            tanggalSelesai: DateTime(2024, 12, 20),
            progress: 100,
          ),
        ]);
        break;
        
      case 2: // Sekbid 2 - Kedisiplinan
        programKerjaList.addAll([
          ProgramKerja(
            nama: 'Operasi Tertib Seragam',
            deskripsi: 'Melakukan pengecekan kelengkapan seragam sekolah setiap minggu',
            status: 'Berjalan',
            tanggalMulai: DateTime(2024, 1, 8),
            tanggalSelesai: DateTime(2024, 12, 20),
            progress: 40,
          ),
        ]);
        break;
        
      default:
        // Program kerja default untuk sekbid lainnya
        programKerjaList.add(
          ProgramKerja(
            nama: 'Program Kerja Utama Sekbid $id',
            deskripsi: 'Program kerja utama yang dilaksanakan oleh sekbid $id',
            status: 'Berjalan',
            tanggalMulai: DateTime(2024, 1, 1 + id),
            tanggalSelesai: DateTime(2024, 12, 31),
            progress: 30 + (id * 5),
          ),
        );
    }
    
    return programKerjaList;
  }
}

// TAMBAHKAN MODEL PROGRAM KERJA DI FILE YANG SAMA
class ProgramKerja {
  final String nama;
  final String deskripsi;
  final String status; // 'Rencana', 'Berjalan', 'Selesai'
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;
  final int progress; // 0-100

  ProgramKerja({
    required this.nama,
    required this.deskripsi,
    required this.status,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.progress,
  });
}