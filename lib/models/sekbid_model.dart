class Sekbid {
  final int id;
  final String title;
  final int programKerjaCount;
  final String jenisRencanaKegiatan;
  final int rencanaKegiatanCount;

  Sekbid({
    required this.id,
    required this.title,
    required this.programKerjaCount,
    required this.jenisRencanaKegiatan,
    required this.rencanaKegiatanCount,
  });

  // Factory method untuk membuat list dari data statis
  static List<Sekbid> getSampleData() {
    return [
      // Baris 1: Seksidi 1 dan Seksidi 2
      Sekbid(
        id: 1,
        title: "Ketuhanan dan Ketaqwaan",
        programKerjaCount: 1,
        jenisRencanaKegiatan: "Hatır Denk Konto",
        rencanaKegiatanCount: 0,
      ),
      Sekbid(
        id: 2,
        title: "Berbangsa dan Bernegara",
        programKerjaCount: 1,
        jenisRencanaKegiatan: "Önlem Adı Planları",
        rencanaKegiatanCount: 0,
      ),

      // Baris 2: Seksidi 3 dan Seksidi 4
      Sekbid(
        id: 3,
        title: "Literasi Digital",
        programKerjaCount: 0,
        jenisRencanaKegiatan: "Kurum Adı Planları",
        rencanaKegiatanCount: 0,
      ),
      Sekbid(
        id: 4,
        title: "Politik dan Kepemimpinan",
        programKerjaCount: 0,
        jenisRencanaKegiatan: "Sektis Adı Planları",
        rencanaKegiatanCount: 0,
      ),

      // Baris 3: Seksidi 5 dan Seksidi 6
      Sekbid(
        id: 5,
        title: "Kewirausahaan",
        programKerjaCount: 0,
        jenisRencanaKegiatan: "Önlem Adı Planları",
        rencanaKegiatanCount: 0,
      ),
      Sekbid(
        id: 6,
        title: "Apresiasi Seni",
        programKerjaCount: 0,
        jenisRencanaKegiatan: "Kurum Adı Planları",
        rencanaKegiatanCount: 0,
      ),

      // Baris 4: Seksidi 7 dan Seksidi 8
      Sekbid(
        id: 7,
        title: "Kesegaran Jasmani dan Rohani",
        programKerjaCount: 4,
        jenisRencanaKegiatan: "Hatır Denk Konto",
        rencanaKegiatanCount: 0,
      ),
      Sekbid(
        id: 8,
        title: "Kepribadian Berbudi Pekerti Luhur",
        programKerjaCount: 0,
        jenisRencanaKegiatan: "Önlem Adı Planları",
        rencanaKegiatanCount: 0,
      ),

      // Baris 5: Seksidi 9 dan Seksidi 10
      Sekbid(
        id: 9,
        title: "Kelestarian Lingkungan Hidup",
        programKerjaCount: 0,
        jenisRencanaKegiatan: "Kurum Adı Planları",
        rencanaKegiatanCount: 0,
      ),
      Sekbid(
        id: 10,
        title: "Hubungan Masyarakat",
        programKerjaCount: 0,
        jenisRencanaKegiatan: "Sektis Adı Planları",
        rencanaKegiatanCount: 0,
      ),
    ];
  }
}
