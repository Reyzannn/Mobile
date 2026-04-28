import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sekbid_model.dart';
import '../models/sekbid_detail_model.dart';
import '../utils/colors.dart';
import 'kelola_proker_screen.dart';

class SekbidDetailScreen extends StatefulWidget {
  final Sekbid sekbid;
  const SekbidDetailScreen({super.key, required this.sekbid});

  @override
  State<SekbidDetailScreen> createState() => _SekbidDetailScreenState();
}

class _SekbidDetailScreenState extends State<SekbidDetailScreen> {
  late Future<List<ProgramKerja>> _prokerFuture;

  @override
  void initState() {
    super.initState();
    _prokerFuture = _fetchProkers();
  }

  Future<List<ProgramKerja>> _fetchProkers() async {
    final data = await Supabase.instance.client
        .from('program_kerja')
        .select()
        .eq('sekbid_id', widget.sekbid.id)
        .order('id', ascending: true);
    return (data as List).map((json) => ProgramKerja.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPreviousRoute = ModalRoute.of(context)?.canPop ?? false;
    
    return PopScope(
      canPop: hasPreviousRoute,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pushReplacementNamed(context, '/sekbid');
      },
      child: Scaffold(
      backgroundColor: AppColors.bg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: AppColors.bg.withValues(alpha: 0.5))),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            if (hasPreviousRoute) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/sekbid');
            }
          },
        ),
        title: Text('Sekbid ${widget.sekbid.id}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final refresh = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => KelolaProkerScreen(preSelectedSekbidId: widget.sekbid.id),
            ),
          );
          if (refresh == true) {
            setState(() {
              _prokerFuture = _fetchProkers();
            });
          }
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Tambah Proker', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
      ),


      body: Stack(
        children: [
          // Subtlest Warm Ambient Glow
          Positioned(
            top: 0,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.04)),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(color: Colors.transparent),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card (Earthy Premium)
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 40,
                            offset: const Offset(0, 15))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SEKBID ${widget.sekbid.id}',
                            style: GoogleFonts.outfit(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2)),
                        const SizedBox(height: 8),
                        Text(widget.sekbid.title,
                            style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                height: 1.2)),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    shape: BoxShape.circle),
                                child: const Icon(Icons.info_outline_rounded,
                                    color: Colors.white, size: 16)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                widget.sekbid.deskripsi ??
                                    'Belum ada deskripsi untuk sekbid ini.',
                                style: GoogleFonts.outfit(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Dokumentasi: Program Kerja Section
                  // Section ini menampilkan daftar semua program kerja yang terdaftar
                  // di SEKBID ini. Setiap program dapat:
                  // - Diklik untuk melihat detail lengkap (nama, deskripsi, status, tanggal)
                  // - Diubah statusnya (Perencanaan, Berjalan, Selesai)
                  // - Dilacak progress-nya melalui progress bar
                  Text('Programs',
                      style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 16),

                  FutureBuilder<List<ProgramKerja>>(
                    future: _prokerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final prokers = snapshot.data ?? [];

                      if (prokers.isEmpty) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                              color: AppColors.surfaceVariant
                                  .withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.border)),
                          child: Center(
                              child: Text('No Programs Available',
                                  style: GoogleFonts.outfit(
                                      color: AppColors.textMuted,
                                      fontWeight: FontWeight.w500))),
                        );
                      }

                      final mockDetail =
                          SekbidDetail.getSampleDetail(widget.sekbid);

                      return Column(
                        children: prokers
                            .map((p) =>
                                _ProkerCard(p, widget.sekbid, mockDetail))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class _ProkerCard extends StatefulWidget {
  final ProgramKerja p;
  final Sekbid sekbid;
  final SekbidDetail sekbidDetail;
  const _ProkerCard(this.p, this.sekbid, this.sekbidDetail);

  @override
  State<_ProkerCard> createState() => _ProkerCardState();
}

class _ProkerCardState extends State<_ProkerCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get _color => widget.p.status.toLowerCase() == 'selesai'
      ? AppColors.success
      : (widget.p.status.toLowerCase() == 'berjalan' ? AppColors.warning : AppColors.primaryLight);

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 20,
              offset: const Offset(0, 8))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
                if (_isExpanded) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(widget.p.nama,
                                style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary))),
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: _color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(widget.p.status,
                              style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: _color)),
                        ),
                        const SizedBox(width: 12),
                        RotationTransition(
                          turns: Tween(begin: 0.0, end: 0.5).animate(_animationController),
                          child: Icon(
                            Icons.expand_more,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(widget.p.deskripsi,
                        style: GoogleFonts.outfit(
                            fontSize: 14, color: AppColors.textSecondary)),
                    if (widget.p.status.toLowerCase() == 'berjalan' || widget.p.progress > 0) ...[
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                            value: widget.p.progress / 100,
                            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                            color: _color,
                            minHeight: 6),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            // Detail Container (Expandable)
            if (_isExpanded) ...[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Foto Dokumentasi (di atas, full-width) ──────────────
                    if (widget.p.dokumentasi != null && widget.p.dokumentasi!.isNotEmpty) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.p.dokumentasi!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_rounded,
                                  color: AppColors.textMuted,
                                  size: 36,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // ── Tanggal Mulai & Selesai (kiri-kanan) ───────────────
                    Row(
                      children: [
                        // Tanggal Mulai (kiri)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.07),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_rounded,
                                    color: AppColors.primary, size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Mulai',
                                          style: GoogleFonts.outfit(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textMuted)),
                                      Text(_formatDate(widget.p.tanggalMulai),
                                          style: GoogleFonts.outfit(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textPrimary)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Tanggal Selesai (kanan)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: _color.withValues(alpha: 0.07),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.event_available_rounded,
                                    color: _color, size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Selesai',
                                          style: GoogleFonts.outfit(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textMuted)),
                                      Text(_formatDate(widget.p.tanggalSelesai),
                                          style: GoogleFonts.outfit(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textPrimary)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // ── Progress (jika ada) ─────────────────────────────────
                    if (widget.p.progress > 0) ...[
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Progress',
                              style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMuted)),
                          Text('${widget.p.progress}%',
                              style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _color)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                            value: widget.p.progress / 100,
                            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                            color: _color,
                            minHeight: 8),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

