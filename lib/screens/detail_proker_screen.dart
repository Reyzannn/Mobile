import 'package:flutter/material.dart';
import '../models/sekbid_model.dart';
import '../models/sekbid_detail_model.dart';
import '../widgets/sidebar_widget.dart';
import 'kelola_proker_screen.dart';

class DetailProkerScreen extends StatelessWidget {
  final ProgramKerja programKerja;
  final Sekbid sekbid;
  final SekbidDetail sekbidDetail;

  const DetailProkerScreen({
    super.key,
    required this.programKerja,
    required this.sekbid,
    required this.sekbidDetail,
  });


  // WARNA MERAH OSIS
  static const Color merahOsis = Color(0xFFD32F2F);
  static const Color merahMuda = Color(0xFFFFEBEE);

  // Helper untuk status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Colors.green;
      case 'berjalan':
        return Colors.orange;
      case 'rencana':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return '✅';
      case 'berjalan':
        return '🔄';
      case 'rencana':
        return '📅';
      default:
        return '📌';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(programKerja.status);
    final progressValue = programKerja.progress / 100;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'DETAIL PROGRAM KERJA',
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => KelolaProkerScreen(initialProker: programKerja),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Share detail proker
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(Icons.archive, size: 18),
                    SizedBox(width: 8),
                    Text('Arsipkan'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 18, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Hapus', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: SidebarWidget(
        activeMenu: 'proker',
        parentContext: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER CARD DENGAN INFO SEKBID
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: merahMuda,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Program Kerja
                  Text(
                    programKerja.nama,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: merahOsis,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Info Sekbid dan Status
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      // Badge Sekbid
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.folder,
                              size: 16,
                              color: merahOsis,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              sekbid.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: merahOsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Badge Status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _getStatusIcon(programKerja.status),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              programKerja.status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Deskripsi Sekbid
                  Text(
                    sekbidDetail.deskripsi,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SECTION: INFORMASI UMUM PROKER
                  _buildSectionHeader(
                    icon: Icons.info_outline,
                    title: 'Informasi Program Kerja',
                  ),
                  const SizedBox(height: 16),
                  
                  // Card Informasi Detail
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            icon: Icons.calendar_today,
                            iconColor: merahOsis,
                            label: 'Tanggal',
                            value: '${_formatDate(programKerja.tanggalMulai)} - ${_formatDate(programKerja.tanggalSelesai)}',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(height: 1),
                          ),
                          
                          // Ketua Sekbid (Penanggung Jawab)
                          _buildInfoRow(
                            icon: Icons.person,
                            iconColor: merahOsis,
                            label: 'Penanggung Jawab',
                            value: sekbidDetail.ketua,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(height: 1),
                          ),
                          
                          // Anggota Count
                          _buildInfoRow(
                            icon: Icons.group,
                            iconColor: merahOsis,
                            label: 'Jumlah Anggota',
                            value: '${sekbidDetail.anggota.length} Orang',
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // SECTION: DESKRIPSI PROKER
                  _buildSectionHeader(
                    icon: Icons.description,
                    title: 'Deskripsi Program Kerja',
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Text(
                      programKerja.deskripsi,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // SECTION: PROGRESS & LAPORAN
                  _buildSectionHeader(
                    icon: Icons.assignment,
                    title: 'Progress & Laporan',
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                programKerja.status.toLowerCase() == 'selesai'
                                    ? Icons.task_alt
                                    : Icons.hourglass_empty,
                                size: 14,
                                color: statusColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Progress: ${programKerja.progress}%',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Progress Bar
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Capaian Program',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  '${programKerja.progress}%',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: progressValue,
                                minHeight: 8,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Rentang Waktu
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${_formatDate(programKerja.tanggalMulai)} - ${_formatDate(programKerja.tanggalSelesai)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Laporan Singkat (Placeholder)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.description_outlined,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _getLaporanPlaceholder(programKerja.status),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Tombol Lihat Laporan Lengkap
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Navigasi ke halaman laporan lengkap
                            },
                            icon: Icon(Icons.assignment, size: 18, color: merahOsis),
                            label: const Text('Lihat Laporan Lengkap'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: merahOsis,
                              side: BorderSide(color: merahOsis),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // SECTION: TIM PELAKSANA
                  _buildSectionHeader(
                    icon: Icons.group,
                    title: 'Tim Pelaksana (${sekbidDetail.anggota.length})',
                    action: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person_add, size: 18, color: merahOsis),
                      label: Text(
                        'Lihat Semua',
                        style: TextStyle(color: merahOsis),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // List Anggota Sekbid
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sekbidDetail.anggota.length > 3 
                          ? 3 
                          : sekbidDetail.anggota.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final anggota = sekbidDetail.anggota[index];
                        final isKetua = anggota.contains('(Ketua)');
                        final namaAnggota = anggota.replaceAll(' (Ketua)', '');
                        
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: isKetua ? merahOsis : merahMuda,
                                radius: 20,
                                child: Text(
                                  namaAnggota[0],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isKetua ? Colors.white : merahOsis,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      namaAnggota,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      isKetua ? 'Ketua Sekbid' : 'Anggota',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isKetua)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: merahMuda,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Ketua',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: merahOsis,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  
                  if (sekbidDetail.anggota.length > 3) ...[
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Navigasi ke halaman detail sekbid
                        },
                        child: Text(
                          '+${sekbidDetail.anggota.length - 3} anggota lainnya',
                          style: TextStyle(
                            color: merahOsis,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 24),
                  
                  // SECTION: PROGRAM KERJA LAINNYA DARI SEKBID YANG SAMA
                  if (sekbidDetail.programKerja.length > 1) ...[
                    _buildSectionHeader(
                      icon: Icons.folder,
                      title: 'Program Kerja Lainnya',
                      action: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward, size: 18, color: merahOsis),
                        label: Text(
                          'Lihat Semua',
                          style: TextStyle(color: merahOsis),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // List program kerja lainnya (selain yang sedang dibuka)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sekbidDetail.programKerja
                            .where((p) => p.nama != programKerja.nama)
                            .take(2)
                            .length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final proker = sekbidDetail.programKerja
                              .where((p) => p.nama != programKerja.nama)
                              .toList()[index];
                          final prokerStatusColor = _getStatusColor(proker.status);
                          
                          return ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: merahMuda,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.assignment,
                                color: merahOsis,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              proker.nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: prokerStatusColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      proker.status,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: prokerStatusColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Progress: ${proker.progress}%',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              // Navigasi ke detail program kerja lain
                            },
                          );
                        },
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 30),
                  
                  // BUTTON AKSI
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Kembali'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: merahOsis,
                            side: BorderSide(color: merahOsis),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/proker',
                              arguments: programKerja,
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit Program'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: merahOsis,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    Widget? action,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: merahMuda,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: merahOsis, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        if (action != null) action,
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getLaporanPlaceholder(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return 'Program kerja telah selesai dilaksanakan dengan hasil yang memuaskan.';
      case 'berjalan':
        return 'Program kerja sedang berjalan sesuai dengan rencana.';
      case 'rencana':
        return 'Program kerja masih dalam tahap perencanaan.';
      default:
        return 'Belum ada laporan untuk program kerja ini.';
    }
  }
}