import 'package:flutter/material.dart';
import '../model/forgot_password_model.dart';
import '../repository/forgot_password_repository.dart';
import '../../../core/router.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final ForgotPasswordRepository _repository = ForgotPasswordRepository();
  final TextEditingController emailController = TextEditingController();
  
  late ForgotPasswordModel _forgotPasswordModel;

  // Constructor - initialize data immediately
  ForgotPasswordViewModel() {
    _initializeData();
  }

  // Getters
  ForgotPasswordModel get forgotPasswordModel => _forgotPasswordModel;
  bool get isLoading => _forgotPasswordModel.isLoading;
  String? get errorMessage => _forgotPasswordModel.errorMessage;
  String? get successMessage => _forgotPasswordModel.successMessage;
  bool get isEmailSent => _forgotPasswordModel.isEmailSent;

  void _initializeData() {
    _forgotPasswordModel = const ForgotPasswordModel();
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // Send reset password email
  Future<void> sendResetPasswordEmail() async {
    if (isLoading) return;

    // Clear previous messages
    _forgotPasswordModel = _forgotPasswordModel.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );
    notifyListeners();

    try {
      final result = await _repository.sendResetPasswordEmail(emailController.text.trim());
      _forgotPasswordModel = result;
       
      if (result.isEmailSent) {
        // Navigate to OTP screen with email
        AppRouter.navigateToOtp(emailController.text.trim());
      }
    } catch (e) {
      _forgotPasswordModel = _forgotPasswordModel.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
    notifyListeners();
  }

  // Navigate back to login
  void navigateToLogin() {
    AppRouter.navigateToLogin();
  }

  // Clear error message
  void clearError() {
    if (_forgotPasswordModel.errorMessage != null) {
      _forgotPasswordModel = _forgotPasswordModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_forgotPasswordModel.successMessage != null) {
      _forgotPasswordModel = _forgotPasswordModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }
}
