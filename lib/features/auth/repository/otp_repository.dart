import '../model/otp_model.dart';

class OtpRepository {
  // Simulate API call to verify OTP
  Future<OtpModel> verifyOtp(String email, String otpCode) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate OTP validation
      if (otpCode.isEmpty) {
        throw Exception('Please enter the OTP code');
      }
      
      if (otpCode.length != 4) {
        throw Exception('Please enter a valid 4-digit OTP code');
      }
      
      // Simulate OTP verification (in real app, this would be server-side)
      if (otpCode == '1234') {
        return OtpModel(
          email: email,
          otpCode: otpCode,
          isOtpVerified: true,
          successMessage: 'OTP verified successfully! You can now reset your password.',
        );
      } else {
        throw Exception('Invalid OTP code. Please try again.');
      }
    } catch (e) {
      return OtpModel(
        email: email,
        otpCode: otpCode,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
  
  // Simulate API call to resend OTP
  Future<OtpModel> resendOtp(String email) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Simulate email validation
      if (email.isEmpty) {
        throw Exception('Email address is required');
      }
      
      if (!_isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }
      
      // Simulate successful OTP resend
      return OtpModel(
        email: email,
        successMessage: 'New OTP code sent to your email address.',
      );
    } catch (e) {
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
