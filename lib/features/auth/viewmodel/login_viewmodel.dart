import 'package:flutter/material.dart';
import '../model/login_model.dart';
import '../repository/auth_repository.dart';
import '../../../core/router.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  
  late LoginModel _loginModel;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Constructor - initialize data immediately
  LoginViewModel() {
    _initializeData();
  }

  // Getters
  LoginModel get loginModel => _loginModel;
  bool get isLoading => _loginModel.isLoading;
  bool get isEmailLoginLoading => _loginModel.isEmailLoginLoading;
  bool get isGoogleLoginLoading => _loginModel.isGoogleLoginLoading;
  bool get isPasswordVisible => _loginModel.isPasswordVisible;
  String? get errorMessage => _loginModel.errorMessage;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  void _initializeData() {
    _loginModel = LoginModel(
      isEmailLoginLoading: false,
      isGoogleLoginLoading: false,
      isPasswordVisible: false,
      errorMessage: null,
    );
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _loginModel = _loginModel.copyWith(
      isPasswordVisible: !_loginModel.isPasswordVisible,
    );
    notifyListeners();
  }

  Future<void> login() async {
    // Validate inputs
    if (_emailController.text.trim().isEmpty) {
      _loginModel = _loginModel.copyWith(
        errorMessage: 'Please enter your email address',
      );
      notifyListeners();
      return;
    }

    if (_passwordController.text.trim().isEmpty) {
      _loginModel = _loginModel.copyWith(
        errorMessage: 'Please enter your password',
      );
      notifyListeners();
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      _loginModel = _loginModel.copyWith(
        errorMessage: 'Please enter a valid email address',
      );
      notifyListeners();
      return;
    }

    _loginModel = _loginModel.copyWith(isEmailLoginLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final success = await _repository.loginWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      
      if (success) {
        // Navigate to main screen or dashboard
        AppRouter.navigateToMain();
      } else {
        _loginModel = _loginModel.copyWith(
          isEmailLoginLoading: false,
          errorMessage: 'Invalid email or password. Please try again.',
        );
        notifyListeners();
      }
    } catch (e) {
      _loginModel = _loginModel.copyWith(
        isEmailLoginLoading: false,
        errorMessage: 'An error occurred. Please try again.',
      );
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {
    _loginModel = _loginModel.copyWith(isGoogleLoginLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final success = await _repository.googleLogin();
      
      if (success) {
        // Navigate to main screen or dashboard
        AppRouter.navigateToMain();
      } else {
        _loginModel = _loginModel.copyWith(
          isGoogleLoginLoading: false,
          errorMessage: 'Google login failed. Please try again.',
        );
        notifyListeners();
      }
    } catch (e) {
      _loginModel = _loginModel.copyWith(
        isGoogleLoginLoading: false,
        errorMessage: 'An error occurred during Google login. Please try again.',
      );
      notifyListeners();
    }
  }

  void forgotPassword() {
    AppRouter.navigateToForgotPassword();
  }

  void navigateToSignUp() {
    AppRouter.navigateToSignUp();
  }

  void clearError() {
    _loginModel = _loginModel.copyWith(errorMessage: null);
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
