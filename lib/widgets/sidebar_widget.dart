import 'package:flutter/material.dart';
import '../utils/colors.dart';

class SidebarWidget extends StatelessWidget {
  final String activeMenu; // Menu yang sedang aktif
  final BuildContext parentContext;

  const SidebarWidget({
    super.key,
    required this.activeMenu,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header Sidebar dengan tanggal
          _buildHeader(),

          // Menu Dashboard
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            menuId: 'dashboard',
          ),

          // Menu Sekbid
          _buildDrawerItem(
            icon: Icons.work,
            title: 'Sekbid',
            menuId: 'sekbid',
          ),

          // Menu Kelola Proker
          _buildDrawerItem(
            icon: Icons.group,
            title: 'Kelola Proker',
            menuId: 'proker',
          ),

          // Menu Dokumentasi
          _buildDrawerItem(
            icon: Icons.calendar_month,
            title: 'Dokumentasi',
            menuId: 'dokumentasi',
          ),

          // Menu Kritik & Saran
          _buildDrawerItem(
            icon: Icons.message,
            title: 'Kritik & Saran',
            menuId: 'kritik',
          ),

          const Divider(thickness: 1, height: 20),

          // Menu Keluar
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Keluar',
            menuId: 'logout',
          ),

          // Footer
          _buildFooter(),
        ],
      ),
    );
  }

  // Header dengan profil dan tanggal
  Widget _buildHeader() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: AppColors.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 16, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Admin OSIS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'admin@osis.smktag.sch.id',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _formatDate(DateTime.now()),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Item menu dalam sidebar
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String menuId,
  }) {
    final isActive = activeMenu == menuId;

    return Container(
      color: isActive ? AppColors.primary.withOpacity(0.05) : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? AppColors.primary : Colors.grey[700],
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            fontSize: 15,
          ),
        ),
        trailing: isActive
            ? Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              )
            : null,
        onTap: () => _handleMenuTap(menuId),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        dense: true,
      ),
    );
  }

  // Footer dengan versi aplikasi
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Sistem OSIS SMKTAG v1.0',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Handle ketika menu di-tap
  void _handleMenuTap(String menuId) {
    // Tutup drawer terlebih dahulu
    Navigator.pop(parentContext);

    // Navigasi berdasarkan menu yang dipilih
    switch (menuId) {
      case 'dashboard':
        if (activeMenu != 'dashboard') {
          Navigator.pushReplacementNamed(parentContext, '/dashboard');
        }
        break;
      case 'sekbid':
        if (activeMenu != 'sekbid') {
          Navigator.pushReplacementNamed(parentContext, '/sekbid');
        }
        break;
      case 'proker':
        if (activeMenu != 'proker') {
          // Navigator.pushReplacementNamed(parentContext, '/proker');
          // TODO: Implement halaman Kelola Proker
        }
        break;
      case 'dokumentasi':
        if (activeMenu != 'dokumentasi') {
          // Navigator.pushReplacementNamed(parentContext, '/dokumentasi');
          // TODO: Implement halaman Dokumentasi
        }
        break;
      case 'kritik':
        if (activeMenu != 'kritik') {
          // Navigator.pushReplacementNamed(parentContext, '/kritik');
          // TODO: Implement halaman Kritik & Saran
        }
        break;
      case 'logout':
        Navigator.pushReplacementNamed(parentContext, '/login');
        break;
    }
  }

  // Format tanggal
  String _formatDate(DateTime date) {
    final days = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu'
    ];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];

    final dayName = days[date.weekday % 7];
    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year.toString();

    return '$dayName, $day $month $year';
  }
}
