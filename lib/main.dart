import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/sekbid_screen.dart';
import 'screens/kelola_proker_screen.dart';
import 'screens/dokumentasi_screen.dart';
import 'screens/kritiksaran_screen.dart';
import 'utils/colors.dart';
import 'utils/supabase_config.dart';
import 'models/sekbid_detail_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = GoogleFonts.outfitTextTheme(); // Outfit font for modern tech look
    return MaterialApp(
      title: 'SI OSIS SMKTAG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: base,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          onPrimary: Colors.white,
          onSurface: AppColors.textPrimary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.outfit(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            shadowColor: AppColors.primary.withValues(alpha: 0.4),
            textStyle: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceVariant.withValues(alpha: 0.5),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.border, width: 0.8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
          ),
          hintStyle: GoogleFonts.outfit(color: AppColors.textMuted, fontSize: 14),
        ),
        dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1, space: 1),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/sekbid': (_) => const SekbidScreen(),
        '/proker': (context) => _buildKelolaProker(context),
        '/dokumentasi': (_) => const DokumentasiScreen(),
        '/kritik': (_) => const KritikSaranScreen(),
      },
    );
  }

  Widget _buildKelolaProker(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ProgramKerja) {
      return KelolaProkerScreen(initialProker: args);
    }
    if (args is int) {
      return KelolaProkerScreen(preSelectedSekbidId: args);
    }
    return const KelolaProkerScreen();
  }
}

