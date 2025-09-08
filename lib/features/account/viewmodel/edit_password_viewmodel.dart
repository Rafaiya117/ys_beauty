import 'package:flutter/material.dart';
import '../model/edit_password_model.dart';
import '../repository/account_repository.dart';
import '../../../core/router.dart';

class EditPasswordViewModel extends ChangeNotifier {
  late EditPasswordModel _editPasswordModel;
  final AccountRepository _accountRepository = AccountRepository();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Constructor - initialize data immediately
  EditPasswordViewModel() {
    _initializeData();
  }

  // Getters
  EditPasswordModel get editPasswordModel => _editPasswordModel;
  bool get isLoading => _editPasswordModel.isLoading;
  String? get errorMessage => _editPasswordModel.errorMessage;
  String? get successMessage => _editPasswordModel.successMessage;
  TextEditingController get currentPasswordController => _currentPasswordController;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;

  void _initializeData() {
    _editPasswordModel = const EditPasswordModel();
    notifyListeners();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Toggle password visibility
  void toggleCurrentPasswordVisibility() {
    _editPasswordModel = _editPasswordModel.copyWith(
      isCurrentPasswordVisible: !_editPasswordModel.isCurrentPasswordVisible,
    );
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _editPasswordModel = _editPasswordModel.copyWith(
      isNewPasswordVisible: !_editPasswordModel.isNewPasswordVisible,
    );
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _editPasswordModel = _editPasswordModel.copyWith(
      isConfirmPasswordVisible: !_editPasswordModel.isConfirmPasswordVisible,
    );
    notifyListeners();
  }

  // Validate password
  bool _validatePassword(String password) {
    return password.length >= 8;
  }

  // Update password
  Future<void> updatePassword() async {
    // Validate inputs
    if (_currentPasswordController.text.trim().isEmpty) {
      _editPasswordModel = _editPasswordModel.copyWith(
        errorMessage: 'Please enter your current password',
      );
      notifyListeners();
      return;
    }

    if (_newPasswordController.text.trim().isEmpty) {
      _editPasswordModel = _editPasswordModel.copyWith(
        errorMessage: 'Please enter a new password',
      );
      notifyListeners();
      return;
    }

    if (!_validatePassword(_newPasswordController.text.trim())) {
      _editPasswordModel = _editPasswordModel.copyWith(
        errorMessage: 'New password must be at least 8 characters long',
      );
      notifyListeners();
      return;
    }

    if (_confirmPasswordController.text.trim().isEmpty) {
      _editPasswordModel = _editPasswordModel.copyWith(
        errorMessage: 'Please confirm your new password',
      );
      notifyListeners();
      return;
    }

    if (_newPasswordController.text.trim() != _confirmPasswordController.text.trim()) {
      _editPasswordModel = _editPasswordModel.copyWith(
        errorMessage: 'New passwords do not match',
      );
      notifyListeners();
      return;
    }

    _editPasswordModel = _editPasswordModel.copyWith(isLoading: true);
    notifyListeners();

    try {
      final success = await _accountRepository.changePassword(
        currentPassword: _currentPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );
      
      if (success) {
        _editPasswordModel = _editPasswordModel.copyWith(
          isLoading: false,
          successMessage: 'Password updated successfully!',
        );
        
        // Clear form
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
        
        // Navigate back after success
        Future.delayed(const Duration(seconds: 2), () {
          AppRouter.goBack();
        });
      } else {
        _editPasswordModel = _editPasswordModel.copyWith(
          isLoading: false,
          errorMessage: 'Failed to update password. Please try again.',
        );
      }
    } catch (e) {
      _editPasswordModel = _editPasswordModel.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    if (_editPasswordModel.errorMessage != null) {
      _editPasswordModel = _editPasswordModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_editPasswordModel.successMessage != null) {
      _editPasswordModel = _editPasswordModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }
}
