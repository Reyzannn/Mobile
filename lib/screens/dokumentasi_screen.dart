import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../widgets/sidebar_widget.dart';

class _DocItem {
  final String title, sekbid, status, tanggal, deskripsi, laporan;
  const _DocItem({required this.title, required this.sekbid, required this.status, required this.tanggal, required this.deskripsi, required this.laporan});
}

class DokumentasiScreen extends StatelessWidget {
  const DokumentasiScreen({super.key});

  static const _docs = [
    _DocItem(
      title: 'Mengadakan Ngaji Bersama',
      sekbid: 'Sekbid 1', status: 'ONGOING', tanggal: '21 Jan 2026',
      deskripsi: 'Ngaji bersama siswa dan guru untuk memperkuat nilai keagamaan.',
      laporan: 'Sedang berjalan, peserta aktif dan suasana kondusif.',
    ),
    _DocItem(
      title: 'Jalan Sehat Kemerdekaan',
      sekbid: 'Sekbid 7', status: 'SELESAI', tanggal: '17 Agu 2025',
      deskripsi: 'Jalan sehat memperingati hari kemerdekaan.',
      laporan: 'Program selesai dengan antusiasme tinggi.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      drawer: SidebarWidget(activeMenu: 'dokumentasi', parentContext: context),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), child: Container(color: AppColors.bg.withValues(alpha: 0.5))),
        ),
        title: const Text('Dokumentasi'),
      ),
      body: Stack(
        children: [
          Positioned(top: -100, right: -100, child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withValues(alpha: 0.3)))),
          Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: Container(color: Colors.transparent))),

          SafeArea(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _docs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (_, i) => _DocCard(doc: _docs[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocCard extends StatelessWidget {
  final _DocItem doc;
  const _DocCard({required this.doc});

  bool get _isOngoing => doc.status == 'ONGOING';
  Color get _statusColor => _isOngoing ? AppColors.warning : AppColors.success;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo Placeholder
          Container(
            height: 160, width: double.infinity,
            color: Colors.white.withValues(alpha: 0.03),
            child: const Center(child: Icon(Icons.image_rounded, size: 48, color: AppColors.textMuted)),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                      child: Text(doc.sekbid, style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryLight)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: _statusColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                      child: Text(doc.status, style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700, color: _statusColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(doc.title, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 8),
                Text(doc.deskripsi, style: GoogleFonts.outfit(fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 16),
                Divider(color: Colors.white.withValues(alpha: 0.1)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 16, color: AppColors.textMuted),
                    const SizedBox(width: 8),
                    Text(doc.tanggal, style: GoogleFonts.outfit(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Text('View Report', style: GoogleFonts.outfit(fontSize: 14, color: AppColors.secondary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
