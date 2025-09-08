import '../model/reset_password_model.dart';

class ResetPasswordRepository {
  // Simulate API call to reset password
  Future<ResetPasswordModel> resetPassword(String email, String newPassword, String confirmPassword) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate password validation
      if (newPassword.isEmpty) {
        throw Exception('Please enter a new password');
      }
      
      if (confirmPassword.isEmpty) {
        throw Exception('Please confirm your password');
      }
      
      if (newPassword != confirmPassword) {
        throw Exception('Passwords do not match');
      }
      
      if (newPassword.length < 6) {
        throw Exception('Password must be at least 6 characters long');
      }
      
      // Simulate successful password reset
      return ResetPasswordModel(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        isPasswordReset: true,
        successMessage: 'Password reset successfully! You can now login with your new password.',
      );
    } catch (e) {
      return ResetPasswordModel(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}
