import 'package:flutter/material.dart';

class AppColors {
  // ── 10% WARNA AKSEN (Call to Action / Tombol Penting) ──
  static const Color primary = Color(0xFF8B5E3C); // Rich Mocha
  static const Color primaryLight = Color(0xFFA67C52); // Soft Bronze

  // ── 30% WARNA SEKUNDER (Sidebar, Menu, Header) ─────────
  static const Color secondary = Color(0xFFE6E0D4); // Warm Latte
  static const Color secondaryDark = Color(0xFFD6D1C4); 

  // ── 60% WARNA DOMINAN (Background / Area Besar) ────────
  static const Color bg = Color(0xFFFDFCFB); // Warm Snow White
  static const Color surface = Color(0xFFFFFFFF); // Pure White Cards
  static const Color surfaceGlass = Color(0xDDFFFFFF); 
  static const Color surfaceVariant = Color(0xFFF2EEE7); // Slightly more contrast against bg

  // ── Typography Colors ──────────────────────────────────
  static const Color textPrimary = Color(0xFF261D17); // Darker Espresso
  static const Color textSecondary = Color(0xFF4A3F35); // Darkened Earth for contrast
  static const Color textMuted = Color(0xFF7D7267); // Darkened Sand Grey

  // ── Status & Utilities ─────────────────────────────────
  static const Color border = Color(0xFFEBE6DF); 
  static const Color borderGlow = Color(0x308B5E3C); 
  static const Color success = Color(0xFF4A6741); // Sage Green
  static const Color warning = Color(0xFFC9A227); // Muted Gold
  static const Color danger = Color(0xFFB34B4B); // Earthy Red

  // ── Elegant Gradients ──────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B5E3C), Color(0xFF6B482D)], // Mocha Gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFF5F2ED), Color(0xFFFDFCFB)], 
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF5F2ED)], 
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0xE6FFFFFF), Color(0xCCFDFCFB)], 
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
