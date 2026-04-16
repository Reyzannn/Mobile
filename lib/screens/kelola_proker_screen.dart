// File: lib/screens/kelola_proker_screen.dart

import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/sidebar_widget.dart';

// MODEL SEDERHANA
class ProkerSekbid {
  final int id;
  final String title;

  ProkerSekbid({
    required this.id,
    required this.title,
  });
}

class KelolaProkerScreen extends StatefulWidget {
  const KelolaProkerScreen({super.key});

  @override
  State<KelolaProkerScreen> createState() => _KelolaProkerScreenState();
}

class _KelolaProkerScreenState extends State<KelolaProkerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Controllers
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _tujuanController = TextEditingController();
  final TextEditingController _tempatController = TextEditingController();
  final TextEditingController _dokumentasiDescController = TextEditingController();
  final TextEditingController _laporanController = TextEditingController();
  
  // Data SEKBID
  final List<ProkerSekbid> _sekbidList = [
    ProkerSekbid(id: 1, title: "Ketaqwaan kepada Tuhan YME"),
    ProkerSekbid(id: 2, title: "Kehidupan Berbangsa dan Bernegara"),
    ProkerSekbid(id: 3, title: "Pendidikan Pendahuluan Bela Negara"),
    ProkerSekbid(id: 4, title: "Kepribadian dan Budi Pekerti Luhur"),
    ProkerSekbid(id: 5, title: "Berorganisasi, Pendidikan Politik"),
    ProkerSekbid(id: 6, title: "Keterampilan dan Kewirausahaan"),
    ProkerSekbid(id: 7, title: "Kesegaran Jasmani dan Daya Kreasi"),
    ProkerSekbid(id: 8, title: "Persepsi, Apresiasi dan Kreasi Seni"),
    ProkerSekbid(id: 9, title: "Kependudukan dan Lingkungan Hidup"),
    ProkerSekbid(id: 10, title: "Teknologi dan Informasi"),
  ];

  // Variabel state
  ProkerSekbid? _selectedSekbid;
  DateTime? _selectedDate;
  String _selectedStatus = 'Perencanaan';
  String? _dokumentasiType;
  
  final List<String> _statusOptions = ['Perencanaan', 'Berjalan', 'Selesai', 'Dibatalkan'];

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Fungsi untuk memilih SEKBID
  void _showSekbidSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih SEKBID'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: _sekbidList.length,
            itemBuilder: (context, index) {
              final sekbid = _sekbidList[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        sekbid.id.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    "SEKBID ${sekbid.id}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  subtitle: Text(
                    sekbid.title,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: _selectedSekbid?.id == sekbid.id
                      ? const Icon(Icons.check, color: AppColors.primary, size: 20)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedSekbid = sekbid;
                    });
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('BATAL'),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk memilih Status
void _showStatusSelectionDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Pilih Status'),
      content: SizedBox(
        width: double.maxFinite,
        height: 250,
        child: ListView.builder(
          itemCount: _statusOptions.length,
          itemBuilder: (context, index) {
            final status = _statusOptions[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Icon(
                      _getStatusIcon(status),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                title: Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                trailing: _selectedStatus == status
                    ? const Icon(Icons.check, color: AppColors.primary, size: 20)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedStatus = status;
                  });
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('BATAL'),
        ),
      ],
    ),
  );
}

// Helper untuk icon status
IconData _getStatusIcon(String status) {
  switch (status) {
    case 'Perencanaan':
      return Icons.assignment_outlined;
    case 'Berjalan':
      return Icons.play_arrow_outlined;
    case 'Selesai':
      return Icons.check_circle_outline;
    case 'Dibatalkan':
      return Icons.cancel_outlined;
    default:
      return Icons.help_outline;
  }
}

  // Fungsi untuk submit form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedSekbid == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap pilih SEKBID'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap pilih tanggal pelaksanaan'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Siapkan data proker
      final prokerData = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'nama': _namaController.text,
        'sekbidId': _selectedSekbid!.id,
        'sekbidName': "SEKBID ${_selectedSekbid!.id}",
        'sekbidTitle': _selectedSekbid!.title,
        'deskripsi': _deskripsiController.text,
        'tujuan': _tujuanController.text,
        'tanggal': _selectedDate!,
        'tempat': _tempatController.text,
        'status': _selectedStatus,
        'dokumentasiDesc': _dokumentasiDescController.text,
        'laporan': _laporanController.text,
        'createdAt': DateTime.now(),
      };

      // TODO: Simpan ke database/provider
      print('Proker berhasil ditambahkan: $prokerData');

      // Tampilkan notifikasi sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Program kerja "${_namaController.text}" berhasil ditambahkan'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // Reset form setelah sukses
      Future.delayed(const Duration(milliseconds: 2200), () {
        _resetForm();
      });
    }
  }

  // Fungsi untuk reset form
  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _selectedSekbid = null;
      _selectedDate = null;
      _selectedStatus = 'Perencanaan';
      _dokumentasiType = null;
    });
    _namaController.clear();
    _deskripsiController.clear();
    _tujuanController.clear();
    _tempatController.clear();
    _dokumentasiDescController.clear();
    _laporanController.clear();
  }

  // Format tanggal
  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'KELOLA PROGRAM KERJA',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
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
        activeMenu: 'proker',
       parentContext: context,
       ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Tambah Program Kerja Baru',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 2. SEKBID
                _buildSectionTitle('SEKBID'),
                InkWell(
                  onTap: _showSekbidSelectionDialog,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedSekbid != null
                              ? "SEKBID ${_selectedSekbid!.id}: ${_selectedSekbid!.title}"
                              : '-- Pilih SEKBID --',
                          style: TextStyle(
                            color: _selectedSekbid != null
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                ),

                  const SizedBox(height: 25),

                // 1. Nama Program Kerja
                _buildSectionTitle('Nama Program Kerja'),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama program kerja',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama program kerja harus diisi';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),

                // 4. Tujuan Program Kerja
                _buildSectionTitle('Tujuan Program Kerja'),
                TextFormField(
                  controller: _tujuanController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Apa tujuan dari program kerja ini?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tujuan harus diisi';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),

                // 5. Waktu dan Tempat
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Waktu Pelaksanaan'),
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade50,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedDate != null
                                        ? _formatDate(_selectedDate!)
                                        : 'dd/mm/yyyy',
                                    style: TextStyle(
                                      color: _selectedDate != null
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey.shade600,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Tempat'),
                          TextFormField(
                            controller: _tempatController,
                            decoration: InputDecoration(
                              hintText: 'Tempat pelaksanaan program kerja',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tempat harus diisi';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

              // 6. Status 
              _buildSectionTitle('Status'),
              InkWell(
                onTap: _showStatusSelectionDialog, // Panggil fungsi baru
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedStatus,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ),
                const SizedBox(height: 25),

                // 7. Dokumentasi
                _buildSectionTitle('Dokumentasi'),
                TextFormField(
                  controller: _dokumentasiDescController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Masukkan link atau deskripsi dokumentasi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Format: URL/Link atau deskripsi text',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),

                const SizedBox(height: 25),

                // 9. Tombol Aksi
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Tambah Program Kerja',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _resetForm,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Reset Form',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk judul section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      )
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _tujuanController.dispose();
    _tempatController.dispose();
    _dokumentasiDescController.dispose();
    _laporanController.dispose();
    super.dispose();
  }
}