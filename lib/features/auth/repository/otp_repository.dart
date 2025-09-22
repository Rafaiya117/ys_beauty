import '../model/otp_model.dart';
import '../../../api/auth_api_service.dart';
import '../../../core/token_storage.dart';

class OtpRepository {
  // Verify OTP via API
  Future<OtpModel> verifyOtp(String email, String otpCode) async {
    try {
      // Validate OTP format
      if (otpCode.isEmpty) {
        throw Exception('Please enter the OTP code');
      }

      if (otpCode.length != 4) {
        throw Exception('Please enter a valid 4-digit OTP code');
      }

      print('Calling AuthApiService.verifyOtp...');
      final authApiService = AuthApiService();

      final result = await authApiService.verifyOtp(email, otpCode);

      if (result != null && result['success'] == true) {
        // Save reset token for password reset
        await TokenStorage.saveResetToken(
          resetToken: result['reset_token'],
          email: email,
        );

        print(
          'OTP verification success, reset token saved: ${result['reset_token']}',
        );
        return OtpModel(
          email: email,
          otpCode: otpCode,
          isOtpVerified: true,
          successMessage:
              result['message'] ??
              'OTP verified successfully! You can now reset your password.',
        );
      } else {
        print(
          'OTP verification failed: ${result?['error'] ?? 'Unknown error'}',
        );
        return OtpModel(
          email: email,
          otpCode: otpCode,
          errorMessage:
              result?['error'] ?? 'Invalid OTP code. Please try again.',
        );
      }
    } catch (e) {
      print('OTP verification error: $e');
      return OtpModel(
        email: email,
        otpCode: otpCode,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  // Resend OTP via API (using forgot password endpoint)
  Future<OtpModel> resendOtp(String email) async {
    try {
      // Validate email format
      if (email.isEmpty) {
        throw Exception('Email address is required');
      }

      if (!_isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }

      print('Calling AuthApiService.forgotPassword for resend OTP...');
      final authApiService = AuthApiService();

      final result = await authApiService.forgotPassword(email);

      if (result != null && result['success'] == true) {
        print('OTP resend success: ${result['message']}');
        return OtpModel(
          email: email,
          successMessage:
              result['message'] ?? 'New OTP code sent to your email address.',
        );
      } else {
        print('OTP resend failed: ${result?['error'] ?? 'Unknown error'}');
        return OtpModel(
          email: email,
          errorMessage:
              result?['error'] ?? 'Failed to resend OTP. Please try again.',
        );
      }
    } catch (e) {
      print('OTP resend error: $e');
      return OtpModel(
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
