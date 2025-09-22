import '../../../shared/constants/app_constants.dart';
import '../../../api/auth_api_service.dart';
import '../../../core/token_storage.dart';

class AuthRepository {
  String getLogoPath() {
    return AppConstants.appLogo;
  }

  String getBackgroundImagePath() {
    return AppConstants.backgroundImagePath;
  }

  // Simulate login API call
  Future<bool> login() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Simulate successful login
    return true;
  }

  // Simulate signup API call
  Future<bool> signUp() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Simulate successful signup
    return true;
  }

  // Login with email and password
  Future<Map<String, dynamic>> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    print('Calling AuthApiService.loginUser...');
    print('Login attempt with email: $email');
    final authApiService = AuthApiService();

    try {
      final result = await authApiService.loginUser(email, password);

      if (result != null && result['success'] == true) {
        // Save tokens to storage
        await TokenStorage.saveTokens(
          accessToken: result['access_token'],
          refreshToken: result['refresh_token'],
        );
        print('Login successful, tokens saved');
        return {'success': true};
      } else {
        final errorMessage = result?['error'] ?? 'Unknown error';
        print('Login failed: $errorMessage');
        return {'success': false, 'error': errorMessage};
      }
    } catch (e) {
      print('Login error: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  // Google login
  Future<bool> googleLogin() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate Google authentication
    // In a real app, this would integrate with Google Sign-In
    return true;
  }

  // Sign up with email and password
  Future<bool> signUpWithEmailAndPassword(
    String name,
    String phone,
    String email,
    String password,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate sign up logic
    // In a real app, this would make an API call to your backend
    if (name.isNotEmpty &&
        phone.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      // Simulate successful sign up
      print('Calling AuthApiService.registerUser...');
      final authApiService = AuthApiService();
      print('About to send request with first_name: $name');
      print('DEBUG: Repository sending field as first_name (not name)');
      final success = await authApiService.registerUser({
        'first_name': name,
        'phone': phone,
        'email': email,
        'password': password,
      });
      print('AuthApiService.registerUser returned: $success');
      return success;
    }

    return false;
  }

  // Logout user
  Future<void> logout() async {
    await TokenStorage.clearTokens();
    print('User logged out successfully');
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    return await TokenStorage.isLoggedIn();
  }

  // Get stored reset token for password reset
  Future<String?> getResetToken() async {
    return await TokenStorage.getResetToken();
  }

  // Get stored reset email
  Future<String?> getResetEmail() async {
    return await TokenStorage.getResetEmail();
  }
}
