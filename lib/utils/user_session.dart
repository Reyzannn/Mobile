class UserSession {
  static String? role; // 'admin' atau 'user'
  static String? nama;
  static String? username;
  
  static bool get isAdmin => role == 'admin';
}
