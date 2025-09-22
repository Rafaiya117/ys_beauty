import '../model/forgot_password_model.dart';
import '../../../api/auth_api_service.dart';

class ForgotPasswordRepository {
  // Send reset password email via API
  Future<ForgotPasswordModel> sendResetPasswordEmail(String email) async {
    try {
      // Validate email format first
      if (email.isEmpty) {
        throw Exception('Please enter your email address');
      }

      if (!_isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }

      print('Calling AuthApiService.forgotPassword...');
      final authApiService = AuthApiService();

      final result = await authApiService.forgotPassword(email);

      if (result != null && result['success'] == true) {
        print('Forgot password success: ${result['message']}');
        return ForgotPasswordModel(
          email: email,
          isEmailSent: true,
          successMessage: result['message'] ?? 'OTP sent to email',
        );
      } else {
        print('Forgot password failed: ${result?['error'] ?? 'Unknown error'}');
        return ForgotPasswordModel(
          email: email,
          errorMessage:
              result?['error'] ?? 'Failed to send OTP. Please try again.',
        );
      }
    } catch (e) {
      print('Forgot password error: $e');
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
