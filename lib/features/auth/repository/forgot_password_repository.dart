import '../model/forgot_password_model.dart';

class ForgotPasswordRepository {
  // Simulate API call to send reset password email
  Future<ForgotPasswordModel> sendResetPasswordEmail(String email) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate email validation
      if (email.isEmpty) {
        throw Exception('Please enter your email address');
      }
      
      if (!_isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }
      
      // Simulate successful email sending
      return ForgotPasswordModel(
        email: email,
        isEmailSent: true,
        successMessage: 'Reset password email sent successfully! Please check your inbox.',
      );
    } catch (e) {
      return ForgotPasswordModel(
        email: email,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
  
  // Email validation helper
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
