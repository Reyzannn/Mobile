import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sekbid_model.dart';
import '../utils/colors.dart';
import '../widgets/sidebar_widget.dart';
import 'sekbid_detail_screen.dart';

class SekbidScreen extends StatefulWidget {
  const SekbidScreen({super.key});
  @override
  State<SekbidScreen> createState() => _SekbidScreenState();
}

class _SekbidScreenState extends State<SekbidScreen> {
  late Future<List<Sekbid>> _sekbidFuture;

  @override
  void initState() {
    super.initState();
    _sekbidFuture = _fetchSekbid();
  }

  Future<List<Sekbid>> _fetchSekbid() async {
    // Menghitung jumlah proker secara otomatis menggunakan rpc atau join
    final data = await Supabase.instance.client
        .from('sekbid')
        .select('*, program_kerja(count)')
        .order('id', ascending: true);

    return (data as List).map((json) => Sekbid.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      drawer: SidebarWidget(activeMenu: 'sekbid', parentContext: context),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: AppColors.bg.withValues(alpha: 0.5)),
          ),
        ),
        title: const Text('Daftar Sekbid'),
      ),
      body: Stack(
        children: [
          // Subtlest Warm Ambient Glow
          Positioned(
            top: 100,
            left: -100,
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
            child: FutureBuilder<List<Sekbid>>(
              future: _sekbidFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final list = snapshot.data ?? [];
                if (list.isEmpty) {
                  return const Center(child: Text('Tidak ada data sekbid'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: list.length,
                  itemBuilder: (ctx, i) => _SekbidTile(sekbid: list[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SekbidTile extends StatelessWidget {
  final Sekbid sekbid;
  const _SekbidTile({required this.sekbid});

  @override
  Widget build(BuildContext context) {
    final hasProker = sekbid.programKerjaCount > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SekbidDetailScreen(sekbid: sekbid))),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Center(
                    child: Text('${sekbid.id}',
                        style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sekbid.title,
                          style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.assignment_rounded,
                              size: 14,
                              color: hasProker
                                  ? AppColors.primary
                                  : AppColors.textMuted),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              hasProker
                                  ? '${sekbid.programKerjaCount} Program Kerja'
                                  : 'No Programs Yet',
                              style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  color: hasProker
                                      ? AppColors.textSecondary
                                      : AppColors.textMuted,
                                  fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_forward_ios_rounded,
                      color: AppColors.textSecondary, size: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
