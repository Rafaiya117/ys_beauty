import 'package:flutter/material.dart';
import '../model/signup_model.dart';
import '../repository/auth_repository.dart';
import '../../../core/router.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  
  late SignUpModel _signUpModel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Constructor - initialize data immediately
  SignUpViewModel() {
    _initializeData();
  }

  // Getters
  SignUpModel get signUpModel => _signUpModel;
  bool get isLoading => _signUpModel.isLoading;
  bool get isEmailSignUpLoading => _signUpModel.isEmailSignUpLoading;
  bool get isGoogleSignUpLoading => _signUpModel.isGoogleSignUpLoading;
  bool get isPasswordVisible => _signUpModel.isPasswordVisible;
  bool get isRememberMe => _signUpModel.isRememberMe;
  String? get errorMessage => _signUpModel.errorMessage;
  TextEditingController get nameController => _nameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  void _initializeData() {
    _signUpModel = SignUpModel(
      isEmailSignUpLoading: false,
      isGoogleSignUpLoading: false,
      isPasswordVisible: false,
      isRememberMe: false,
      errorMessage: null,
    );
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _signUpModel = _signUpModel.copyWith(
      isPasswordVisible: !_signUpModel.isPasswordVisible,
    );
    notifyListeners();
  }

  void toggleRememberMe() {
    _signUpModel = _signUpModel.copyWith(
      isRememberMe: !_signUpModel.isRememberMe,
    );
    notifyListeners();
  }

  Future<void> signUp() async {
    // Validate inputs
    if (_nameController.text.trim().isEmpty) {
      _signUpModel = _signUpModel.copyWith(
        errorMessage: 'Please enter your name',
      );
      notifyListeners();
      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      _signUpModel = _signUpModel.copyWith(
        errorMessage: 'Please enter your phone number',
      );
      notifyListeners();
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      _signUpModel = _signUpModel.copyWith(
        errorMessage: 'Please enter your email address',
      );
      notifyListeners();
      return;
    }

    if (_passwordController.text.trim().isEmpty) {
      _signUpModel = _signUpModel.copyWith(
        errorMessage: 'Please enter your password',
      );
      notifyListeners();
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      _signUpModel = _signUpModel.copyWith(
        errorMessage: 'Please enter a valid email address',
      );
      notifyListeners();
      return;
    }

    if (!_isValidPhone(_phoneController.text.trim())) {
      _signUpModel = _signUpModel.copyWith(
        errorMessage: 'Please enter a valid phone number',
      );
      notifyListeners();
      return;
    }

    _signUpModel = _signUpModel.copyWith(isEmailSignUpLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final success = await _repository.signUpWithEmailAndPassword(
        _nameController.text.trim(),
        _phoneController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      
      if (success) {
        // Navigate to main screen or dashboard
        AppRouter.navigateToMain();
      } else {
        _signUpModel = _signUpModel.copyWith(
          isEmailSignUpLoading: false,
          errorMessage: 'Sign up failed. Please try again.',
        );
        notifyListeners();
      }
    } catch (e) {
      _signUpModel = _signUpModel.copyWith(
        isEmailSignUpLoading: false,
        errorMessage: 'An error occurred. Please try again.',
      );
      notifyListeners();
    }
  }

  Future<void> googleSignUp() async {
    _signUpModel = _signUpModel.copyWith(isGoogleSignUpLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final success = await _repository.googleSignUp();
      
      if (success) {
        // Navigate to main screen or dashboard
        AppRouter.navigateToMain();
      } else {
        _signUpModel = _signUpModel.copyWith(
          isGoogleSignUpLoading: false,
          errorMessage: 'Google sign up failed. Please try again.',
        );
        notifyListeners();
      }
    } catch (e) {
      _signUpModel = _signUpModel.copyWith(
        isGoogleSignUpLoading: false,
        errorMessage: 'An error occurred during Google sign up. Please try again.',
      );
      notifyListeners();
    }
  }

  void navigateToLogin() {
    AppRouter.navigateToLogin();
  }

  void clearError() {
    _signUpModel = _signUpModel.copyWith(errorMessage: null);
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    // Basic phone validation - can be customized based on requirements
    return RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
