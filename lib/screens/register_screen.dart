import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _kelasCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _loading = false;

  @override
  void dispose() {
    for (final c in [_namaCtrl, _kelasCtrl, _usernameCtrl, _emailCtrl, _passCtrl, _confirmCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passCtrl.text != _confirmCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match'), backgroundColor: AppColors.danger),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final res = await Supabase.instance.client.auth.signUp(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );

      if (res.user != null) {
        await Supabase.instance.client.from('profiles').insert({
          'id': res.user!.id,
          'username': _usernameCtrl.text.trim(),
          'nama': _namaCtrl.text.trim(),
          'kelas': _kelasCtrl.text.trim(),
          'role': 'user',
        });
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created! Please check your email for verification.')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: AppColors.danger),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e'), backgroundColor: AppColors.danger),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create Account', style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -0.5)),
                const SizedBox(height: 8),
                Text('Join the OSIS digital ecosystem', style: GoogleFonts.outfit(fontSize: 15, color: AppColors.textSecondary)),
                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 40, offset: const Offset(0, 10))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Personal Profile', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      const SizedBox(height: 24),
                      _field('Full Name', _namaCtrl, Icons.person_outline_rounded, 'John Doe'),
                      const SizedBox(height: 20),
                      _field('Class', _kelasCtrl, Icons.school_outlined, 'X RPL 1'),
                      
                      const SizedBox(height: 40),
                      Text('Account Security', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      const SizedBox(height: 24),
                      _field('Username', _usernameCtrl, Icons.alternate_email_rounded, 'username'),
                      const SizedBox(height: 20),
                      _field('Email', _emailCtrl, Icons.email_outlined, 'email@example.com', keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 20),
                      _field('Password', _passCtrl, Icons.lock_outline_rounded, '••••••••', obscure: _obscurePass, suffixOnTap: () => setState(() => _obscurePass = !_obscurePass)),
                      const SizedBox(height: 20),
                      _field('Confirm Password', _confirmCtrl, Icons.lock_outline_rounded, '••••••••', obscure: _obscureConfirm, suffixOnTap: () => setState(() => _obscureConfirm = !_obscureConfirm)),
                      
                      const SizedBox(height: 48),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _register,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 8,
                            shadowColor: AppColors.primary.withValues(alpha: 0.2),
                          ),
                          child: _loading 
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                            : const Text('Complete Registration', style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member? ", style: GoogleFonts.outfit(color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                      child: Text("Sign In", style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, IconData icon, String hint, {bool obscure = false, TextInputType keyboardType = TextInputType.text, VoidCallback? suffixOnTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
        const SizedBox(height: 10),
        TextFormField(
          controller: ctrl,
          obscureText: obscure,
          keyboardType: keyboardType,
          style: GoogleFonts.outfit(color: AppColors.textPrimary, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: AppColors.primary.withValues(alpha: 0.6), size: 18),
            suffixIcon: suffixOnTap != null ? IconButton(icon: Icon(obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: AppColors.textMuted, size: 18), onPressed: suffixOnTap) : null,
          ),
        ),
      ],
    );
  }
}
