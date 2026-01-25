import 'package:flutter/material.dart';

class AppColors {
  // Warna merah gradasi sesuai gambar
  static const Color primary = Color(0xFFD32F2F); // Merah utama
  static const Color primaryLight = Color(0xFFEF5350); // Merah muda
  static const Color primaryDark = Color(0xFFC21807); // Merah tua

  // Gradasi untuk button/login
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFD32F2F), Color(0xFFC21807)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Secondary colors
  static const Color secondary = Color(0xFF1976D2); // Biru untuk aksen
  static const Color accent = Color(0xFFFF9800); // Orange
  static const Color success = Color(0xFF4CAF50); // Hijau

  // Neutral colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color border = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x1A000000);
}
