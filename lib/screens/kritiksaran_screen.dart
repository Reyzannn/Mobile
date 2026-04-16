// File: lib/screens/kritik_saran_screen.dart
import 'package:flutter/material.dart';
import '../widgets/sidebar_widget.dart';

class KritikSaranScreen extends StatelessWidget {
  const KritikSaranScreen({super.key});

  // WARNA UTAMA (sesuaikan dengan tema aplikasi Anda)
  static const Color warnaUtama = Color(0xFFD32F2F); // Merah OSIS
  static const Color warnaMuda = Color(0xFFFFEBEE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'KRITIK & SARAN DARI SISWA',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: warnaUtama,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: SidebarWidget(
        activeMenu: 'kritik',
        parentContext: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: warnaMuda,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kritik & Saran Siswa SMKTAG',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: warnaUtama,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Masukan dan feedback dari para siswa untuk kemajuan OSIS',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // LIST HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Semua Kritik & Saran (12 masukan)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // LIST KRITIK & SARAN
              _buildKritikSaranCard(
                nama: "Rayan Az'Ad Setiawan",
                kelas: "X RPL 1",
                tanggal: "21 Jan 2026 11:39",
                sekbid: "Sekbid 1",
                judul: "Mengadakan ngaji bersama",
                kritik: "Kurang maksimal implementasi nya",
                saran: "Lebih di optimalkan lagi",
                balasan: [
                  Balasan(
                    pengirim: "OSIS",
                    tanggal: "21 Jan 2026 11:42",
                    isi:
                        "Terimakasih atas kritik dan sarannya. Kami pastikan kedepannya bakal lebih baik lagi",
                  ),
                  Balasan(
                    pengirim: "OSIS",
                    tanggal: "22 Jan 2026 12:22",
                    isi: "Okee baik, terimakasih",
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildKritikSaranCard(
                nama: "Siti Aminah",
                kelas: "XI TKJ 2",
                tanggal: "20 Jan 2026 14:30",
                sekbid: "Sekbid 3",
                judul: "Perbaikan fasilitas perpustakaan",
                kritik: "AC di perpustakaan sering mati",
                saran: "Perlu maintenance rutin",
                balasan: [
                  Balasan(
                    pengirim: "OSIS",
                    tanggal: "21 Jan 2026 09:15",
                    isi:
                        "Sudah kami laporkan ke pihak sekolah. Terima kasih atas informasinya.",
                  ),
                ],
              ),

              // Tombol Load More
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Muat lebih banyak...',
                    style: TextStyle(
                      color: warnaUtama,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(
      String label, String value, Color warnaUtama, Color warnaMuda) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: warnaMuda,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: warnaUtama,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKritikSaranCard({
    required String nama,
    required String kelas,
    required String tanggal,
    required String sekbid,
    required String judul,
    required String kritik,
    required String saran,
    required List<Balasan> balasan,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER - Info Pengirim
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: warnaMuda,
                  child: Icon(Icons.person, color: warnaUtama),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: warnaUtama,
                        ),
                      ),
                      Text(
                        kelas,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Tanggal & Sekbid
            Row(
              children: [
                Text(
                  tanggal,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: warnaMuda,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    sekbid,
                    style: TextStyle(
                      color: warnaUtama,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Judul
            Text(
              judul,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 12),

            // Kritik
            const Text(
              "Kritik:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(kritik),
            const SizedBox(height: 8),

            // Saran
            const Text(
              "Saran:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(saran),
            const SizedBox(height: 16),

            // Balasan
            if (balasan.isNotEmpty) ...[
              const Divider(),
              const Text(
                "Balasan dari Pengurus OSIS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              ...balasan.map((balasan) => Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              balasan.pengirim,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                balasan.tanggal,
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 11),
                              ),
                              const SizedBox(height: 4),
                              Text(balasan.isi),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],

            // Input Balasan
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Tulis balasan...",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                  Icon(Icons.send, color: warnaUtama),
                ],
              ),
            ),

            // Tombol Aksi
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Tandai Selesai',
                      style: TextStyle(
                        color: warnaUtama,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: warnaUtama,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Balas',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Model untuk balasan (letakkan di file terpisah atau di bawah class)
class Balasan {
  final String pengirim;
  final String tanggal;
  final String isi;

  Balasan({
    required this.pengirim,
    required this.tanggal,
    required this.isi,
  });
}