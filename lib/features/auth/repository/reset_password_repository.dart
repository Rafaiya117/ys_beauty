import '../model/reset_password_model.dart';
import '../../../api/auth_api_service.dart';
import '../../../core/token_storage.dart';

class ResetPasswordRepository {
  // Reset password using stored email and reset token
  Future<ResetPasswordModel> resetPassword(
    String email,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      // Get stored reset token and email
      final storedResetToken = await TokenStorage.getResetToken();
      final storedEmail = await TokenStorage.getResetEmail();

      // Validate stored data
      if (storedResetToken == null || storedEmail == null) {
        throw Exception(
          'Reset session expired. Please start the password reset process again.',
        );
      }

      // Validate password inputs
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

      print('Calling AuthApiService.resetPassword...');
      final authApiService = AuthApiService();

      final result = await authApiService.resetPassword(
        email: storedEmail,
        resetToken: storedResetToken,
        password: newPassword,
        retypePassword: confirmPassword,
      );

      if (result != null && result['success'] == true) {
        // Clear reset token after successful password reset
        await TokenStorage.clearResetToken();

        print('Password reset success: ${result['message']}');
        return ResetPasswordModel(
          email: storedEmail,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
          isPasswordReset: true,
          successMessage:
              result['message'] ??
              'Password reset successfully! You can now login with your new password.',
        );
      } else {
        print('Password reset failed: ${result?['error'] ?? 'Unknown error'}');
        return ResetPasswordModel(
          email: storedEmail,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
          errorMessage:
              result?['error'] ?? 'Password reset failed. Please try again.',
        );
      }
    } catch (e) {
      print('Password reset error: $e');
      return ResetPasswordModel(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}
