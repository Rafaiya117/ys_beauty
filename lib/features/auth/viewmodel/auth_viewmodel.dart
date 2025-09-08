import 'package:flutter/material.dart';
import '../model/auth_model.dart';
import '../repository/auth_repository.dart';
import '../../../core/router.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  
  late AuthModel _authModel;

  // Constructor - initialize data immediately
  AuthViewModel() {
    _initializeData();
  }

  // Getters
  AuthModel get authModel => _authModel;
  bool get isLoginLoading => _authModel.isLoginLoading;
  bool get isSignUpLoading => _authModel.isSignUpLoading;
  String? get errorMessage => _authModel.errorMessage;
  String get logoPath => _authModel.logoPath;
  String get backgroundImagePath => _authModel.backgroundImagePath;

  void _initializeData() {
    _authModel = AuthModel(
      isLoginLoading: false,
      isSignUpLoading: false,
      logoPath: _repository.getLogoPath(),
      backgroundImagePath: _repository.getBackgroundImagePath(),
    );
    notifyListeners();
  }

  Future<void> login() async {
    _authModel = _authModel.copyWith(isLoginLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final success = await _repository.login();
      if (success) {
        // Navigate to main screen or dashboard
        AppRouter.navigateToMain();
      } else {
        _authModel = _authModel.copyWith(
          isLoginLoading: false,
          errorMessage: 'Login failed. Please try again.',
        );
        notifyListeners();
      }
    } catch (e) {
      _authModel = _authModel.copyWith(
        isLoginLoading: false,
        errorMessage: 'An error occurred. Please try again.',
      );
      notifyListeners();
    }
  }

  Future<void> signUp() async {
    _authModel = _authModel.copyWith(isSignUpLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final success = await _repository.signUp();
      if (success) {
        // Navigate to main screen or dashboard
        AppRouter.navigateToMain();
      } else {
        _authModel = _authModel.copyWith(
          isSignUpLoading: false,
          errorMessage: 'Sign up failed. Please try again.',
        );
        notifyListeners();
      }
    } catch (e) {
      _authModel = _authModel.copyWith(
        isSignUpLoading: false,
        errorMessage: 'An error occurred. Please try again.',
      );
      notifyListeners();
    }
  }

  void clearError() {
    _authModel = _authModel.copyWith(errorMessage: null);
    notifyListeners();
  }

  void navigateToLogin() {
    AppRouter.navigateToLogin();
  }

  void navigateToSignUp() {
    AppRouter.navigateToSignUp();
  }
}
