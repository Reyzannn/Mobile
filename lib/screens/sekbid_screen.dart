import 'package:flutter/material.dart';
import '../models/sekbid_model.dart';
import '../utils/colors.dart';
import '../widgets/sidebar_widget.dart';
import 'sekbid_detail_screen.dart'; // IMPORT SCREEN DETAIL

class SekbidScreen extends StatefulWidget {
  const SekbidScreen({super.key});

  @override
  State<SekbidScreen> createState() => _SekbidScreenState();
}

class _SekbidScreenState extends State<SekbidScreen> {
  List<Sekbid> sekbidList = [];

  @override
  void initState() {
    super.initState();
    sekbidList = Sekbid.getSampleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'DAFTAR SEKBID OSIS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: SidebarWidget(
        activeMenu: 'sekbid',
        parentContext: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSekbidGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Teknisi 1: 10 Bidang OSIS ying kendeli',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(left: 52),
            child: Text(
              'Daftar 10 Bidang OSIS',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSekbidGrid() {
    // Bagi list menjadi chunks/pairs untuk 2 kolom
    List<List<Sekbid>> chunkedList = [];
    for (int i = 0; i < sekbidList.length; i += 2) {
      int end = (i + 2 < sekbidList.length) ? i + 2 : sekbidList.length;
      chunkedList.add(sekbidList.sublist(i, end));
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: chunkedList.length,
      itemBuilder: (context, rowIndex) {
        return _buildRow(chunkedList[rowIndex]);
      },
    );
  }

  Widget _buildRow(List<Sekbid> rowItems) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Sekbid pertama di baris
          Expanded(
            child: _buildSekbidCard(rowItems[0]),
          ),

          const SizedBox(width: 12),

          // Sekbid kedua di baris (jika ada)
          if (rowItems.length > 1)
            Expanded(
              child: _buildSekbidCard(rowItems[1]),
            )
          else
            const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildSekbidCard(Sekbid sekbid) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nomor dan judul sekbid
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      sekbid.id.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Seksidi ${sekbid.id}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sekbid.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Program Kerja
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Programı Kolja:",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sekbid.programKerjaCount.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: sekbid.programKerjaCount > 0
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Rencana Kegiatan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sekbid.jenisRencanaKegiatan,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sekbid.rencanaKegiatanCount.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: sekbid.rencanaKegiatanCount > 0
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // TOMBOL LIHAT DETAIL
            _buildDetailButton(sekbid),
          ],
        ),
      ),
    );
  }

  // TOMBOL LIHAT DETAIL - MENUJU SCREEN DETAIL
  Widget _buildDetailButton(Sekbid sekbid) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // NAVIGASI KE SCREEN DETAIL
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SekbidDetailScreen(sekbid: sekbid),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          foregroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Lihat Detail'),
            SizedBox(width: 6),
            Icon(Icons.arrow_forward_ios, size: 12),
          ],
        ),
      ),
    );
  }
}
