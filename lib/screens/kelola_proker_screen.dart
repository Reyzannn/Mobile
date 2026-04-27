import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sekbid_model.dart';
import '../models/sekbid_detail_model.dart';
import '../services/image_picker.dart';
import '../utils/colors.dart';
import '../widgets/sidebar_widget.dart';
import 'sekbid_detail_screen.dart';

class KelolaProkerScreen extends StatefulWidget {
  final ProgramKerja? initialProker;
  final int? preSelectedSekbidId;
  const KelolaProkerScreen(
      {super.key, this.initialProker, this.preSelectedSekbidId});

  @override
  State<KelolaProkerScreen> createState() => _KelolaProkerScreenState();
}

class _KelolaProkerScreenState extends State<KelolaProkerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _deskripsiCtrl = TextEditingController();

  List<Sekbid> _sekbidList = [];
  Sekbid? _selectedSekbid;
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedStatus = 'Perencanaan';
  bool _isLoading = false;
  final ImagePickerService _imagePickerService = ImagePickerService();
  Uint8List? _selectedImageData;

  @override
  void initState() {
    super.initState();
    _fetchSekbids();
    if (widget.initialProker != null) {
      final p = widget.initialProker!;
      _namaCtrl.text = p.nama;
      _deskripsiCtrl.text = p.deskripsi;
      _startDate = p.tanggalMulai;
      _endDate = p.tanggalSelesai;
      _selectedStatus = p.status;
    }
  }

  Future<void> _fetchSekbids() async {
    try {
      final data = await Supabase.instance.client
          .from('sekbid')
          .select()
          .order('id', ascending: true);
      setState(() {
        _sekbidList = (data as List).map((e) => Sekbid.fromJson(e)).toList();

        final targetId =
            widget.initialProker?.sekbidId ?? widget.preSelectedSekbidId;
        if (targetId != null) {
          _selectedSekbid = _sekbidList.firstWhere(
            (s) => s.id == targetId,
            orElse: () => _sekbidList.first,
          );
        }
      });
    } catch (e) {
      _err('Gagal mengambil data sekbid: $e');
    }
  }

  @override
  void dispose() {
    for (final c in [
      _namaCtrl,
      _deskripsiCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSekbid == null) {
      _err('Pilih SEKBID terlebih dahulu');
      return;
    }
    if (_startDate == null || _endDate == null) {
      _err('Pilih rentang tanggal pelaksanaan');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final proker = ProgramKerja(
        id: widget.initialProker?.id,
        sekbidId: _selectedSekbid!.id,
        nama: _namaCtrl.text,
        deskripsi: _deskripsiCtrl.text,
        status: _selectedStatus,
        tanggalMulai: _startDate!,
        tanggalSelesai: _endDate!,
        progress: widget.initialProker?.progress ?? 0,
      );

      if (widget.initialProker?.id == null) {
        // Create new
        await Supabase.instance.client
            .from('program_kerja')
            .insert(proker.toJson());
      } else {
        // Update existing
        await Supabase.instance.client
            .from('program_kerja')
            .update(proker.toJson())
            .eq('id', proker.id!);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.initialProker?.id == null
            ? 'Program Kerja Berhasil Ditambahkan! ✨'
            : 'Program Kerja Berhasil Diperbarui! ✨'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ));

      // Jika dibuka dari SekbidDetailScreen (preSelectedSekbidId ada), pop saja biar kembali ke detail
      if (widget.preSelectedSekbidId != null) {
        Navigator.pop(context, true);
      }
      // Jika form add baru (initialProker == null) dan dibuka dari sidebar, arahkan ke detail sekbid yg ditambah
      else if (widget.initialProker == null && _selectedSekbid != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SekbidDetailScreen(sekbid: _selectedSekbid!)),
        );
      }
      // Jika edit, pop biasa
      else {
        Navigator.pop(context, true);
      }
    } catch (e) {
      _err('Gagal menyimpan: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _err(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(msg),
            backgroundColor: AppColors.danger,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
      );

  void _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  void _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  Future<void> _pickPhoto() async {
    final photoData = await _imagePickerService.pickImageFromGallery();
    if (photoData != null) {
      setState(() => _selectedImageData = photoData);
    }
  }

  void _pickSekbid() {
    if (_sekbidList.isEmpty) {
      _fetchSekbids();
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pilih SEKBID',
                style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: _sekbidList
                    .map((s) => ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: _selectedSekbid?.id == s.id
                                    ? AppColors.primary
                                    : AppColors.surfaceVariant,
                                shape: BoxShape.circle),
                            child: Text('${s.id}',
                                style: TextStyle(
                                    color: _selectedSekbid?.id == s.id
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                          title: Text(s.title,
                              style: GoogleFonts.outfit(
                                  color: AppColors.textPrimary,
                                  fontWeight: _selectedSekbid?.id == s.id
                                      ? FontWeight.w700
                                      : FontWeight.w400)),
                          onTap: () {
                            setState(() => _selectedSekbid = s);
                            Navigator.pop(context);
                          },
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.initialProker?.id != null;
    return Scaffold(
      backgroundColor: AppColors.bg,
      drawer: SidebarWidget(activeMenu: 'proker', parentContext: context),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: AppColors.bg.withValues(alpha: 0.5))),
        ),
        title: Text(isEdit ? 'Edit Proker' : 'Tambah Proker',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w800)),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 100,
              right: -100,
              child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.04)))),
          Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                  child: Container(color: Colors.transparent))),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 40,
                              offset: const Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Detail Program Kerja',
                              style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary)),
                          const SizedBox(height: 24),
                          _FieldLabel('Target SEKBID'),
                          _PickerField(
                            label: _selectedSekbid != null
                                ? 'SEKBID ${_selectedSekbid!.id}'
                                : 'Pilih Sekbid',
                            subLabel: _selectedSekbid?.title,
                            filled: _selectedSekbid != null,
                            onTap: _pickSekbid,
                          ),
                          const SizedBox(height: 20),
                          _FieldLabel('Foto Proker'),
                          GestureDetector(
                            onTap: _pickPhoto,
                            child: Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.border),
                                color: AppColors.surfaceVariant,
                              ),
                              child: _selectedImageData == null
                                  ? Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.photo_camera_rounded,
                                              color: Colors.grey, size: 32),
                                          const SizedBox(height: 8),
                                          Text('Pilih foto proker',
                                              style: GoogleFonts.outfit(
                                                  color:
                                                      AppColors.textSecondary)),
                                        ],
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.memory(_selectedImageData!,
                                          fit: BoxFit.cover),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _FieldLabel('Nama Program'),
                          TextFormField(
                            controller: _namaCtrl,
                            decoration: const InputDecoration(
                                hintText: 'Contoh: LDKS 2024'),
                            validator: (v) =>
                                v!.isEmpty ? 'Nama proker wajib diisi' : null,
                          ),
                          const SizedBox(height: 20),
                          _FieldLabel('Deskripsi Program'),
                          TextFormField(
                            controller: _deskripsiCtrl,
                            maxLines: 3,
                            decoration: const InputDecoration(
                                hintText:
                                    'Jelaskan detail program kerja ini...'),
                            validator: (v) =>
                                v!.isEmpty ? 'Deskripsi wajib diisi' : null,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _FieldLabel('Tgl Mulai'),
                                    _PickerField(
                                      label: _startDate != null
                                          ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                                          : 'Pilih Tgl',
                                      filled: _startDate != null,
                                      icon: Icons.calendar_today_rounded,
                                      onTap: _pickStartDate,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _FieldLabel('Tgl Selesai'),
                                    _PickerField(
                                      label: _endDate != null
                                          ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                                          : 'Pilih Tgl',
                                      filled: _endDate != null,
                                      icon: Icons.calendar_today_rounded,
                                      onTap: _pickEndDate,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FieldLabel('Status'),
                              _StatusPicker(
                                current: _selectedStatus,
                                onChanged: (v) =>
                                    setState(() => _selectedStatus = v),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 20)),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(widget.initialProker == null
                                ? 'SIMPAN PROGRAM KERJA'
                                : 'PERBARUI PROGRAM KERJA'),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(text,
          style: GoogleFonts.outfit(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5)),
    );
  }
}

class _StatusPicker extends StatelessWidget {
  final String current;
  final ValueChanged<String> onChanged;
  const _StatusPicker({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
          builder: (_) => Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Pilih Status',
                    style: GoogleFonts.outfit(
                        fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 16),
                ...['Perencanaan', 'Berjalan', 'Selesai'].map((s) => ListTile(
                      title: Text(s,
                          style: GoogleFonts.outfit(
                              fontWeight: current == s
                                  ? FontWeight.w700
                                  : FontWeight.w400)),
                      trailing: current == s
                          ? const Icon(Icons.check_circle,
                              color: AppColors.primary)
                          : null,
                      onTap: () {
                        onChanged(s);
                        Navigator.pop(context);
                      },
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
            color: AppColors.surfaceVariant.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            Expanded(
                child: Text(current,
                    style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600))),
            const Icon(Icons.expand_more_rounded,
                color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}

class _PickerField extends StatelessWidget {
  final String label;
  final String? subLabel;
  final bool filled;
  final IconData icon;
  final VoidCallback onTap;
  const _PickerField(
      {required this.label,
      this.subLabel,
      required this.filled,
      required this.onTap,
      this.icon = Icons.expand_more_rounded});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
            color: AppColors.surfaceVariant.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: filled
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                          fontWeight:
                              filled ? FontWeight.w600 : FontWeight.w400)),
                  if (subLabel != null)
                    Text(subLabel!,
                        style: GoogleFonts.outfit(
                            fontSize: 11, color: AppColors.textSecondary),
                        overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(icon, color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}
