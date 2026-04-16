import 'package:flutter/material.dart';
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
                  '10 SEKSI BIDANG OSIS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Nomor SEKBID di tengah dengan kotak
            Column(
              children: [
                // Kotak nomor
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      sekbid.id.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Label "SEKBID"
                Text(
                  "SEKBID",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Judul Sekbid TANPA BACKGROUND
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                sekbid.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 16),

            // Container untuk Program Kerja
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.work_outline,
                        size: 16,
                        color: sekbid.programKerjaCount > 0
                            ? AppColors.success
                            : Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "PROGRAM KERJA",
                        style: TextStyle(
                          fontSize: 12,
                          color: sekbid.programKerjaCount > 0
                              ? AppColors.primary
                              : Colors.grey[600],
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sekbid.programKerjaCount.toString(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: sekbid.programKerjaCount > 0
                          ? AppColors.success
                          : Colors.grey[600],
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // TOMBOL LIHAT DETAIL
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SekbidDetailScreen(sekbid: sekbid),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
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
                    Icon(Icons.arrow_forward, size: 14),
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