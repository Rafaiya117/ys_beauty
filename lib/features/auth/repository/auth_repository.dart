import '../../../shared/constants/app_constants.dart';

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
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate authentication logic
    // In a real app, this would make an API call to your backend
    if (email.isNotEmpty && password.isNotEmpty) {
      // Simulate successful login
      return true;
    }
    
    return false;
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
  Future<bool> signUpWithEmailAndPassword(String name, String phone, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate sign up logic
    // In a real app, this would make an API call to your backend
    if (name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Simulate successful sign up
      return true;
    }
    
    return false;
  }

  // Google sign up
  Future<bool> googleSignUp() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate Google sign up
    // In a real app, this would integrate with Google Sign-In
    return true;
  }
}
