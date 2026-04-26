import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/colors.dart';
import '../utils/user_session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _login() async {
    setState(() => _loading = true);
    try {
      // 1. Auth Login
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );

      if (res.user != null) {
        // 2. Fetch Profile and Role
        final userData = await Supabase.instance.client
            .from('profiles')
            .select('role, nama, username')
            .eq('id', res.user!.id)
            .single();

        // 3. Save to Session
        UserSession.role = userData['role'];
        UserSession.nama = userData['nama'];
        UserSession.username = userData['username'];
      }

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard');
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.danger),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Subtlest Warm Ambient Glow
          Positioned(
            top: -100, right: -50,
            child: Container(
              width: 400, height: 400,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withValues(alpha: 0.05)),
            ),
          ),
          Positioned(
            bottom: -150, left: -100,
            child: Container(
              width: 350, height: 350,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withValues(alpha: 0.03)),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
              child: Container(color: Colors.transparent),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Elegant Modern Logo
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(color: AppColors.primary.withValues(alpha: 0.05), blurRadius: 40, offset: const Offset(0, 20))
                        ],
                      ),
                      child: const Icon(Icons.hub_rounded, size: 48, color: AppColors.primary),
                    ),
                    const SizedBox(height: 32),
                    Text('SI OSIS', style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 4)),
                    Text('MODERN PLATFORM', style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w700, letterSpacing: 8)),
                    const SizedBox(height: 56),

                    // Frost Modern Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceGlass,
                            borderRadius: BorderRadius.circular(36),
                            border: Border.all(color: AppColors.border),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 40, offset: const Offset(0, 20))
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Welcome', style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                              const SizedBox(height: 6),
                              Text('Sign in to your account', style: GoogleFonts.outfit(fontSize: 14, color: AppColors.textSecondary)),
                              const SizedBox(height: 40),

                              _buildField('Email', _emailCtrl, Icons.alternate_email_rounded),
                              const SizedBox(height: 24),
                              _buildField('Password', _passwordCtrl, Icons.lock_outline_rounded, obscure: _obscure, toggle: () => setState(() => _obscure = !_obscure)),
                              
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text('Forgot Password?', style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
                              ),
                              const SizedBox(height: 40),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _loading ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    elevation: 10,
                                    shadowColor: AppColors.primary.withValues(alpha: 0.3),
                                  ),
                                  child: _loading 
                                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                    : const Text('Sign In', style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("New member? ", style: GoogleFonts.outfit(color: AppColors.textSecondary)),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/register'),
                          child: Text("Register Here", style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.w800)),
                        ),
                      ],
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

  Widget _buildField(String label, TextEditingController ctrl, IconData icon, {bool obscure = false, VoidCallback? toggle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600, letterSpacing: 1)),
        const SizedBox(height: 12),
        TextField(
          controller: ctrl,
          obscureText: obscure,
          style: GoogleFonts.outfit(color: AppColors.textPrimary, fontSize: 15),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary.withValues(alpha: 0.6), size: 20),
            suffixIcon: toggle != null ? IconButton(icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textMuted, size: 20), onPressed: toggle) : null,
            hintText: label,
            hintStyle: TextStyle(color: AppColors.textMuted.withValues(alpha: 0.5)),
          ),
        ),
      ],
    );
  }
}
