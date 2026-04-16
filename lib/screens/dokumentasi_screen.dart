// File: lib/screens/dokumentasi_screen.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/sidebar_widget.dart';

class DokumentasiScreen extends StatelessWidget {
  const DokumentasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // WARNA MERAH OSIS
    const Color merahOsis = Color(0xFFD32F2F);
    const Color merahMuda = Color(0xFFFFEBEE);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'DOKUMENTASI KEGIATAN OSIS',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: merahOsis, 
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
        activeMenu: 'dokumentasi', 
        parentContext: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER - GANTI WARNA
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: merahMuda, // <-- GANTI JADI MERAH MUDA
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dokumentasi Kegiatan OSIS',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: merahOsis, // <-- GANTI JADI MERAH
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kumpulan dokumentasi dari semua program kerja OSIS',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // FILTER SECTION (tetap sama)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter Dokumentasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Filter Sekibid
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Filter Sekibid',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Semua Sekibid'),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.grey[600]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Filter Status

              // LIST HEADER
              Text(
                'Semua Dokumentasi (2 hasil)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // CARD 1 - GANTI WARNA
              _buildDocumentCard(
                title: 'Mengadakan ngaji bersama',
                sekbid: 'Sekibid 1',
                status: 'ONGOING',
                statusColor: Colors.orange,
                tanggal: '21 Jan 2026',
                deskripsi: 'Ngaji bareng bareng',
                laporan: 'sedang berjalan',
                warnaUtama: merahOsis, // <-- TAMBAH PARAMETER
                warnaMuda: merahMuda,   // <-- TAMBAH PARAMETER
              ),
              const SizedBox(height: 16),

              // CARD 2 - GANTI WARNA
              _buildDocumentCard(
                title: 'Mengadakan Jalan Sehat',
                sekbid: 'Sekibid 7',
                status: 'COMPLETED',
                statusColor: Colors.green,
                tanggal: '17 Aug 2025',
                deskripsi: 'Mengadakan jalan sehat pada acara peringatan 17 Agustus.',
                laporan: 'Proker sudah selesai dan berjalan dengan lancar',
                warnaUtama: merahOsis, // <-- TAMBAH PARAMETER
                warnaMuda: merahMuda,   // <-- TAMBAH PARAMETER
              ),
            ],
          ),
        ),
       ]
      ),
        )
      )
    );
  }

  Widget _buildStatBox(String label, String value, Color warnaUtama, Color warnaMuda) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: warnaMuda, // <-- GANTI
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: warnaUtama, // <-- GANTI
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

  Widget _buildDocumentCard({
    required String title,
    required String sekbid,
    required String status,
    required Color statusColor,
    required String tanggal,
    required String deskripsi,
    required String laporan,
    required Color warnaUtama, // <-- TAMBAH
    required Color warnaMuda,  // <-- TAMBAH
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
            // HEADER - GANTI WARNA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: warnaUtama, // <-- GANTI
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Sekbid Badge - GANTI WARNA
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: warnaMuda, // <-- GANTI
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              sekbid,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: warnaUtama, // <-- GANTI
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Status Badge (tetap sama)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Tanggal
                Text(
                  tanggal,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // IMAGE PLACEHOLDER
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo, size: 40, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text(
                      'Gambar Dokumentasi',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // DESKRIPSI
            Text(
              'Deskripsi Kegiatan:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(deskripsi),
            const SizedBox(height: 12),

            // LAPORAN
            Text(
              'Laporan Kegiatan:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(laporan),
            const SizedBox(height: 16),

            // FOOTER - GANTI WARNA TOMBOL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Dibuat oleh: OSIS',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tombol Lihat Detail - GANTI WARNA
                    SizedBox(
                      width: 140,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Lihat Detail Lengkap',
                          style: TextStyle(
                            color: warnaUtama, // <-- GANTI
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Tombol Edit - GANTI WARNA
                    SizedBox(
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: warnaUtama, // <-- GANTI
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text(
                          'Edit',
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
          ],
        ),
      ),
    );
  }
}