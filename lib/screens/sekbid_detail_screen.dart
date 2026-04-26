import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sekbid_model.dart';
import '../models/sekbid_detail_model.dart';
import '../utils/colors.dart';
import 'detail_proker_screen.dart';

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
    return Scaffold(
      backgroundColor: AppColors.bg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: AppColors.bg.withValues(alpha: 0.5))),
        ),
        title: Text('Sekbid ${widget.sekbid.id}'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final refresh = await Navigator.pushNamed(
            context,
            '/proker',
            arguments: widget.sekbid.id,
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
    );
  }
}

class _ProkerCard extends StatelessWidget {
  final ProgramKerja p;
  final Sekbid sekbid;
  final SekbidDetail sekbidDetail;
  const _ProkerCard(this.p, this.sekbid, this.sekbidDetail);

  Color get _color => p.status == 'Selesai'
      ? AppColors.success
      : (p.status == 'Berjalan' ? AppColors.warning : AppColors.primaryLight);

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
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailProkerScreen(
                  programKerja: p,
                  sekbid: sekbid,
                  sekbidDetail: sekbidDetail,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(p.nama,
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
                      child: Text(p.status,
                          style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: _color)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(p.deskripsi,
                    style: GoogleFonts.outfit(
                        fontSize: 14, color: AppColors.textSecondary)),
                if (p.status == 'Berjalan' || p.progress > 0) ...[
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                        value: p.progress / 100,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                        color: _color,
                        minHeight: 6),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

