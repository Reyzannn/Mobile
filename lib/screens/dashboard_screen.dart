import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/user_session.dart';
import '../utils/colors.dart';
import '../widgets/sidebar_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      drawer: SidebarWidget(activeMenu: 'dashboard', parentContext: context),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: AppColors.bg.withValues(alpha: 0.6)),
          ),
        ),
        title: Text('SI OSIS',
            style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications_none_rounded,
                  color: AppColors.textPrimary),
              onPressed: () {}),
          const SizedBox(width: 12),
        ],
      ),
      body: Stack(
        children: [
          // Elegant Sand Glows
          Positioned(
            top: 0,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.04)),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
              child: Container(color: Colors.transparent),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Hero Banner (Warm Sand Style) ────────────────
                  Container(
                    width: double.infinity,
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dashboard',
                                  style: GoogleFonts.outfit(
                                      color:
                                          Colors.white.withValues(alpha: 0.8),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1)),
                              const SizedBox(height: 6),
                              Text(
                                  'Welcome, ${UserSession.username ?? 'User'} ✨',
                                  style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800)),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Colors.white
                                            .withValues(alpha: 0.1))),
                                child: Text('12 Active Programs',
                                    style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2))),
                          child: const Icon(Icons.auto_awesome_mosaic_rounded,
                              color: Colors.white, size: 36),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ── Overview ────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quick Overview',
                          style: GoogleFonts.outfit(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('2024 Period',
                            style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textSecondary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.4,
                    children: [
                      _StatGlassCard(
                          title: 'Total Sekbid',
                          value: '10',
                          icon: Icons.hub_rounded,
                          width: 0),
                      _StatGlassCard(
                          title: 'Active Proker',
                          value: '5',
                          icon: Icons.rocket_launch_rounded,
                          width: 0),
                      _StatGlassCard(
                          title: 'Feedbacks',
                          value: '3',
                          icon: Icons.forum_rounded,
                          width: 0),
                      _StatGlassCard(
                          title: 'Completed',
                          value: '24',
                          icon: Icons.verified_rounded,
                          width: 0),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // ── Recent Activity ────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Programs',
                          style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary)),
                      Text('View All',
                          style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondary)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _ActivityTile(
                      title: 'Ngaji Bersama',
                      subtitle: 'Sekbid 1 • 21 Jan',
                      status: 'Ongoing',
                      color: AppColors.warning),
                  _ActivityTile(
                      title: 'Classmeet E-Sport',
                      subtitle: 'Sekbid 7 • 14 Jan',
                      status: 'Completed',
                      color: AppColors.success),
                  _ActivityTile(
                      title: 'Pelatihan Jurnalistik',
                      subtitle: 'Sekbid 9 • 05 Jan',
                      status: 'Completed',
                      color: AppColors.success),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calcWidth(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    if (w > 600) return (w - 40 - 48) / 4; // Web/Tablet: 4 columns
    return (w - 40 - 16) / 2; // Mobile: 2 columns
  }
}

class _StatGlassCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final double width;
  const _StatGlassCard(
      {required this.title,
      required this.value,
      required this.icon,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: GoogleFonts.outfit(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1)),
              const SizedBox(height: 4),
              Text(title,
                  style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String title, subtitle, status;
  final Color color;
  const _ActivityTile(
      {required this.title,
      required this.subtitle,
      required this.status,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 15,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(Icons.rocket_launch_rounded, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: GoogleFonts.outfit(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withValues(alpha: 0.3))),
            child: Text(status,
                style: GoogleFonts.outfit(
                    fontSize: 11, fontWeight: FontWeight.w700, color: color)),
          ),
        ],
      ),
    );
  }
}
