import 'package:flutter/material.dart';
import '../model/reset_password_model.dart';
import '../repository/reset_password_repository.dart';
import '../../../core/router.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final ResetPasswordRepository _repository = ResetPasswordRepository();
  
  late ResetPasswordModel _resetPasswordModel;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Constructor - initialize data immediately
  ResetPasswordViewModel({required String email}) {
    _initializeData(email);
  }

  // Getters
  ResetPasswordModel get resetPasswordModel => _resetPasswordModel;
  bool get isLoading => _resetPasswordModel.isLoading;
  bool get isPasswordVisible => _resetPasswordModel.isPasswordVisible;
  bool get isConfirmPasswordVisible => _resetPasswordModel.isConfirmPasswordVisible;
  String? get errorMessage => _resetPasswordModel.errorMessage;
  String? get successMessage => _resetPasswordModel.successMessage;
  bool get isPasswordReset => _resetPasswordModel.isPasswordReset;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;

  void _initializeData(String email) {
    _resetPasswordModel = ResetPasswordModel(email: email);
    notifyListeners();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _resetPasswordModel = _resetPasswordModel.copyWith(
      isPasswordVisible: !_resetPasswordModel.isPasswordVisible,
    );
    notifyListeners();
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    _resetPasswordModel = _resetPasswordModel.copyWith(
      isConfirmPasswordVisible: !_resetPasswordModel.isConfirmPasswordVisible,
    );
    notifyListeners();
  }

  // Reset password
  Future<void> resetPassword() async {
    if (isLoading) return;

    // Clear previous messages
    _resetPasswordModel = _resetPasswordModel.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );
    notifyListeners();

    try {
      final result = await _repository.resetPassword(
        _resetPasswordModel.email,
        _newPasswordController.text.trim(),
        _confirmPasswordController.text.trim(),
      );
      _resetPasswordModel = result;
      
      if (result.isPasswordReset) {
        // Navigate to login screen after successful reset
        _navigateToLogin();
      }
    } catch (e) {
      _resetPasswordModel = _resetPasswordModel.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
    notifyListeners();
  }

  // Navigate to login screen
  void _navigateToLogin() {
    AppRouter.navigateToLogin();
  }

  // Navigate back to OTP screen
  void navigateToOtp() {
    AppRouter.goBack();
  }

  // Clear error message
  void clearError() {
    if (_resetPasswordModel.errorMessage != null) {
      _resetPasswordModel = _resetPasswordModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_resetPasswordModel.successMessage != null) {
      _resetPasswordModel = _resetPasswordModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }
}
