import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../widgets/sidebar_widget.dart';

class KritikSaranScreen extends StatefulWidget {
  const KritikSaranScreen({super.key});
  @override
  State<KritikSaranScreen> createState() => _KritikSaranScreenState();
}

class _KritikSaranScreenState extends State<KritikSaranScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _kritikCtrl = TextEditingController();
  String _selectedTarget = 'Sekbid 1';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _kritikCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      drawer: SidebarWidget(activeMenu: 'kritik', parentContext: context),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), child: Container(color: AppColors.bg.withValues(alpha: 0.5))),
        ),
        title: Text('Kritik & Saran', style: GoogleFonts.outfit(fontWeight: FontWeight.w800)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: 'Kirim Masukan'),
            Tab(text: 'Kotak Masuk'),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(top: 200, right: -100, child: Container(width: 400, height: 400, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withValues(alpha: 0.04)))),
          Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120), child: Container(color: Colors.transparent))),

          SafeArea(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUserView(),
                _buildAdminView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: AppColors.border),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 40, offset: const Offset(0, 10))],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Beri Masukan', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  Text('Masukan Anda membantu kami menjadi lebih baik.', style: GoogleFonts.outfit(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 32),

                  Text('Target Masukan', style: _labelStyle()),
                  _buildDropdown(),
                  const SizedBox(height: 20),

                  Text('Isi Kritik & Saran', style: _labelStyle()),
                  TextFormField(
                    controller: _kritikCtrl,
                    maxLines: 5,
                    decoration: const InputDecoration(hintText: 'Tuliskan masukan Anda di sini...'),
                    validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terima kasih! Masukan telah dikirim.')));
                          _kritikCtrl.clear();
                        }
                      },
                      child: const Text('KIRIM MASUKAN'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text('Masukan Saya', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
          const SizedBox(height: 16),
          _KritikCard(
            nama: 'Saya',
            tanggal: 'Hari ini',
            target: 'Sekbid 1',
            isi: 'Mohon untuk dokumentasi proker lebih dipercepat unggahnya.',
            isUserOwn: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAdminView() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(
          children: [
            Text('Semua Masukan', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const Spacer(),
            Icon(Icons.filter_list_rounded, color: AppColors.textSecondary, size: 20),
          ],
        ),
        const SizedBox(height: 20),
        _KritikCard(
          nama: "Rayan Az'Ad",
          tanggal: '21 Jan 2026',
          target: 'Proker LDKS',
          isi: 'Implementasi proker kemarin kurang maksimal di bagian konsumsi.',
          balasan: 'Terima kasih atas masukannya, akan kami evaluasi.',
          isAdmin: true,
        ),
        _KritikCard(
          nama: "Budi Santoso",
          tanggal: '19 Jan 2026',
          target: 'Sekbid 4',
          isi: 'Kapan ada lomba kebersihan kelas lagi?',
          isAdmin: true,
        ),
      ],
    );
  }

  TextStyle _labelStyle() => GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w700, letterSpacing: 0.5);

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: AppColors.surfaceVariant.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedTarget,
          isExpanded: true,
          icon: const Icon(Icons.expand_more_rounded, color: AppColors.textMuted),
          items: ['Sekbid 1', 'Sekbid 2', 'Proker LDKS', 'Proker HUT RI'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.outfit(fontSize: 14, color: AppColors.textPrimary)))).toList(),
          onChanged: (v) => setState(() => _selectedTarget = v!),
        ),
      ),
    );
  }
}

class _KritikCard extends StatelessWidget {
  final String nama, tanggal, target, isi;
  final String? balasan;
  final bool isAdmin, isUserOwn;

  const _KritikCard({required this.nama, required this.tanggal, required this.target, required this.isi, this.balasan, this.isAdmin = false, this.isUserOwn = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
                child: Center(child: Text(nama[0], style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 18))),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nama, style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    Text('$tanggal • Target: $target', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              if (isUserOwn || (isAdmin && balasan != null))
                PopupMenuButton(
                  icon: Icon(Icons.more_vert_rounded, color: AppColors.textMuted, size: 20),
                  itemBuilder: (_) => [
                    PopupMenuItem(child: Row(children: [Icon(Icons.edit_outlined, size: 18, color: AppColors.textSecondary), const SizedBox(width: 10), const Text('Edit')])),
                    PopupMenuItem(child: Row(children: [Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.danger), const SizedBox(width: 10), Text('Delete', style: TextStyle(color: AppColors.danger))])),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(isi, style: GoogleFonts.outfit(fontSize: 14, color: AppColors.textPrimary, height: 1.5)),
          
          if (balasan != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surfaceVariant.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withValues(alpha: 0.5))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.reply_rounded, size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text('Balasan OSIS', style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(balasan!, style: GoogleFonts.outfit(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                ],
              ),
            ),
          ] else if (isAdmin) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.reply_rounded, size: 18),
                label: const Text('BALAS KRITIK'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
