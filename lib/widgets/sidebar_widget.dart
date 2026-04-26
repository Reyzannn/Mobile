import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../utils/user_session.dart';

class SidebarWidget extends StatelessWidget {
  final String activeMenu;
  final BuildContext parentContext;

  const SidebarWidget({super.key, required this.activeMenu, required this.parentContext});

  static const _menus = [
    {'id': 'dashboard',   'label': 'Dashboard',       'icon': Icons.dashboard_customize_rounded},
    {'id': 'sekbid',      'label': 'Daftar Sekbid',   'icon': Icons.hub_rounded},
    {'id': 'proker',      'label': 'Kelola Proker',   'icon': Icons.rocket_launch_rounded},
    {'id': 'dokumentasi', 'label': 'Dokumentasi',     'icon': Icons.photo_library_rounded},
    {'id': 'kritik',      'label': 'Kritik & Saran',  'icon': Icons.forum_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // Frost Glass Sidebar
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bg.withValues(alpha: 0.8),
                  border: const Border(right: BorderSide(color: AppColors.border)),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── Modern Profile Header ────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 56, height: 56,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 6))],
                        ),
                        child: const Center(
                          child: Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(UserSession.nama ?? 'User', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                            Text('@${UserSession.username ?? 'user'}', style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w700, letterSpacing: 1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(color: AppColors.border, height: 1),
                ),
                const SizedBox(height: 16),

                // ── Navigation ────────────────────────────────
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      for (final m in _menus)
                        if (m['id'] != 'proker' || UserSession.isAdmin)
                          _NavItem(
                            icon: m['icon'] as IconData,
                            label: m['label'] as String,
                            active: activeMenu == m['id'],
                            onTap: () => _navigate(m['id'] as String),
                          ),
                    ],
                  ),
                ),

                // ── Footer ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: _NavItem(
                    icon: Icons.logout_rounded,
                    label: 'Sign Out',
                    active: false,
                    danger: true,
                    onTap: () => _navigate('logout'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigate(String id) {
    Navigator.pop(parentContext);
    switch (id) {
      case 'dashboard':   if (activeMenu != id) Navigator.pushReplacementNamed(parentContext, '/dashboard'); break;
      case 'sekbid':      if (activeMenu != id) Navigator.pushReplacementNamed(parentContext, '/sekbid'); break;
      case 'proker':      if (activeMenu != id) Navigator.pushReplacementNamed(parentContext, '/proker'); break;
      case 'dokumentasi': if (activeMenu != id) Navigator.pushReplacementNamed(parentContext, '/dokumentasi'); break;
      case 'kritik':      if (activeMenu != id) Navigator.pushReplacementNamed(parentContext, '/kritik'); break;
      case 'logout':      Navigator.pushReplacementNamed(parentContext, '/login'); break;
    }
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final bool danger;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon, required this.label,
    required this.active, required this.onTap,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color fg = danger ? AppColors.danger : (active ? AppColors.primary : AppColors.textSecondary);
    final Color bg = active ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          splashColor: AppColors.primary.withValues(alpha: 0.1),
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: active ? AppColors.primary.withValues(alpha: 0.5) : Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(icon, size: 22, color: fg),
                const SizedBox(width: 16),
                Text(label,
                    style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                        color: fg)),
                if (active) ...[
                  const Spacer(),
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primary, 
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 8)],
                    ),
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
