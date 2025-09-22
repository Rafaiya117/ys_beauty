import 'package:flutter/material.dart';
import '../model/account_model.dart';
import '../repository/account_repository.dart';

class AccountViewModel extends ChangeNotifier {
  late AccountModel _accountModel;
  final AccountRepository _accountRepository = AccountRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Constructor - initialize data immediately
  AccountViewModel() {
    _initializeData();
  }

  // Getters
  AccountModel get accountModel => _accountModel;
  bool get isLoading => _accountModel.isLoading;
  bool get isEditing => _accountModel.isEditing;
  String? get errorMessage => _accountModel.errorMessage;
  String? get successMessage => _accountModel.successMessage;
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get dateOfBirthController => _dateOfBirthController;
  TextEditingController get locationController => _locationController;
  TextEditingController get phoneController => _phoneController;

  void _initializeData() {
    _accountModel = const AccountModel();
    _nameController.text = _accountModel.name;
    _emailController.text = _accountModel.email;
    _dateOfBirthController.text = _accountModel.dateOfBirth;
    _locationController.text = _accountModel.location;
    _phoneController.text = _accountModel.phone ?? '';
    notifyListeners();
  }

  // Fetch account information from repository
  Future<void> fetchAccountInformation() async {
    _accountModel = _accountModel.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final accountData = await _accountRepository.fetchAccountInformation();
      _accountModel = accountData.copyWith(isLoading: false);
      _nameController.text = _accountModel.name;
      _emailController.text = _accountModel.email;
      _dateOfBirthController.text = _accountModel.dateOfBirth;
      _locationController.text = _accountModel.location;
      _phoneController.text = _accountModel.phone ?? '';
      print('Account data loaded successfully');
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      _accountModel = _accountModel.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      );
      print('Account loading error: $errorMessage');
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dateOfBirthController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Toggle edit mode
  void toggleEditMode() {
    _accountModel = _accountModel.copyWith(isEditing: !_accountModel.isEditing);
    notifyListeners();
  }

  // Save changes
  Future<void> saveChanges() async {
    if (!_accountModel.isEditing) return;

    _accountModel = _accountModel.copyWith(isLoading: true);
    notifyListeners();

    try {
      final updatedAccount = await _accountRepository.updateAccountInformation(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        dateOfBirth: _dateOfBirthController.text.trim(),
        location: _locationController.text.trim(),
        phone: _phoneController.text.trim(),
        profileImagePath: _accountModel.profileImagePath,
      );

      _accountModel = updatedAccount.copyWith(
        isLoading: false,
        isEditing: false,
        successMessage: 'Account information updated successfully!',
      );
    } catch (e) {
      _accountModel = _accountModel.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
    notifyListeners();

    // Clear success message after 3 seconds
    if (_accountModel.successMessage != null) {
      Future.delayed(const Duration(seconds: 3), () {
        clearSuccess();
      });
    }
  }

  // Change password
  void changePassword() {
    _accountModel = _accountModel.copyWith(
      successMessage: 'Change password feature coming soon!',
    );
    notifyListeners();

    // Clear message after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      clearSuccess();
    });
  }

  // Change profile picture
  Future<void> changeProfilePicture() async {
    _accountModel = _accountModel.copyWith(isLoading: true);
    notifyListeners();

    try {
      // In a real app, you would get the image path from image picker
      const mockImagePath = 'assets/profile_images/user_profile.jpg';
      final imageUrl = await _accountRepository.updateProfilePicture(
        mockImagePath,
      );

      _accountModel = _accountModel.copyWith(
        profileImagePath: imageUrl,
        isLoading: false,
        successMessage: 'Profile picture updated successfully!',
      );
    } catch (e) {
      _accountModel = _accountModel.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
    notifyListeners();

    // Clear message after 3 seconds
    if (_accountModel.successMessage != null) {
      Future.delayed(const Duration(seconds: 3), () {
        clearSuccess();
      });
    }
  }

  // Clear error message
  void clearError() {
    if (_accountModel.errorMessage != null) {
      _accountModel = _accountModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_accountModel.successMessage != null) {
      _accountModel = _accountModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }
}
