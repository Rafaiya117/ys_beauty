import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _resetTokenKey = 'reset_token';
  static const String _resetEmailKey = 'reset_email';

  // Save tokens after successful login
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setBool(_isLoggedInKey, true);
    print('Tokens saved successfully');
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Clear all tokens (logout)
  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.setBool(_isLoggedInKey, false);
    print('Tokens cleared successfully');
  }

  // Get authorization header for API requests
  static Future<Map<String, String>> getAuthHeaders() async {
    final accessToken = await getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
  }

  // Save reset token after successful OTP verification
  static Future<void> saveResetToken({
    required String resetToken,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_resetTokenKey, resetToken);
    await prefs.setString(_resetEmailKey, email);
    print('Reset token saved successfully');
  }

  // Get reset token
  static Future<String?> getResetToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_resetTokenKey);
  }

  // Get reset email
  static Future<String?> getResetEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_resetEmailKey);
  }

  // Clear reset token after password reset
  static Future<void> clearResetToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_resetTokenKey);
    await prefs.remove(_resetEmailKey);
    print('Reset token cleared successfully');
  }
}
