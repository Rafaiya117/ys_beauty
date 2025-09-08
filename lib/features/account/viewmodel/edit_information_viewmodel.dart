import 'package:flutter/material.dart';
import '../model/edit_information_model.dart';
import '../repository/edit_information_repository.dart';
import '../../../core/router.dart';

class EditInformationViewModel extends ChangeNotifier {
  late EditInformationModel _editInformationModel;
  final EditInformationRepository _editInformationRepository = EditInformationRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  // Constructor - initialize data immediately
  EditInformationViewModel({
    String? name,
    String? email,
    String? birthDate,
    String? city,
  }) {
    _initializeData(
      name: name,
      email: email,
      birthDate: birthDate,
      city: city,
    );
  }

  // Getters
  EditInformationModel get editInformationModel => _editInformationModel;
  bool get isLoading => _editInformationModel.isLoading;
  String? get errorMessage => _editInformationModel.errorMessage;
  String? get successMessage => _editInformationModel.successMessage;
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get birthDateController => _birthDateController;
  TextEditingController get cityController => _cityController;

  void _initializeData({
    String? name,
    String? email,
    String? birthDate,
    String? city,
  }) {
    _editInformationModel = EditInformationModel(
      name: name ?? 'Nicolas Smith',
      email: email ?? 'nicolassmith1234@gmail.com',
      birthDate: birthDate ?? 'Mar 11, 1993',
      city: city ?? 'Colorado',
    );
    _nameController.text = _editInformationModel.name;
    _emailController.text = _editInformationModel.email;
    _birthDateController.text = _editInformationModel.birthDate;
    _cityController.text = _editInformationModel.city;
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  // Save changes
  Future<void> saveChanges() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _birthDateController.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty) {
      _editInformationModel = _editInformationModel.copyWith(
        errorMessage: 'Please fill in all fields',
      );
      notifyListeners();
      return;
    }

    _editInformationModel = _editInformationModel.copyWith(isLoading: true);
    notifyListeners();

    try {
      // Validate email format
      final isEmailValid = await _editInformationRepository.validateEmail(_emailController.text.trim());
      if (!isEmailValid) {
        _editInformationModel = _editInformationModel.copyWith(
          isLoading: false,
          errorMessage: 'Please enter a valid email address',
        );
        notifyListeners();
        return;
      }

      // Check if email is available
      final isEmailAvailable = await _editInformationRepository.isEmailAvailable(_emailController.text.trim());
      if (!isEmailAvailable) {
        _editInformationModel = _editInformationModel.copyWith(
          isLoading: false,
          errorMessage: 'This email address is already taken',
        );
        notifyListeners();
        return;
      }

      // Update user information
      final updatedInfo = await _editInformationRepository.updateUserInformation(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        birthDate: _birthDateController.text.trim(),
        city: _cityController.text.trim(),
        profileImagePath: _editInformationModel.profileImagePath,
      );
      
      _editInformationModel = updatedInfo.copyWith(
        isLoading: false,
        successMessage: 'Information updated successfully!',
      );
    } catch (e) {
      _editInformationModel = _editInformationModel.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
    notifyListeners();

    // Navigate back after success
    if (_editInformationModel.successMessage != null) {
      Future.delayed(const Duration(seconds: 1), () {
        AppRouter.goBack();
      });
    }
  }

  // Cancel changes
  void cancelChanges() {
    AppRouter.goBack();
  }

  // Change profile picture
  Future<void> changeProfilePicture() async {
    _editInformationModel = _editInformationModel.copyWith(isLoading: true);
    notifyListeners();

    try {
      // In a real app, you would get the image path from image picker
      const mockImagePath = 'assets/profile_images/user_profile.jpg';
      final imageUrl = await _editInformationRepository.updateProfilePicture(mockImagePath);
      
      _editInformationModel = _editInformationModel.copyWith(
        profileImagePath: imageUrl,
        isLoading: false,
        successMessage: 'Profile picture updated successfully!',
      );
    } catch (e) {
      _editInformationModel = _editInformationModel.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
    notifyListeners();
    
    // Clear message after 3 seconds
    if (_editInformationModel.successMessage != null) {
      Future.delayed(const Duration(seconds: 3), () {
        clearSuccess();
      });
    }
  }

  // Update profile picture with selected image
  Future<void> updateProfilePicture(String imagePath) async {
    _editInformationModel = _editInformationModel.copyWith(isLoading: true);
    notifyListeners();

    try {
      // First, store the local file path to show the image immediately
      _editInformationModel = _editInformationModel.copyWith(
        profileImagePath: imagePath,
        isLoading: false,
        successMessage: 'Profile picture updated successfully!',
      );
      notifyListeners();
      
      // Then upload to server (simulated)
      final imageUrl = await _editInformationRepository.updateProfilePicture(imagePath);
      
      // Update with server URL if needed (for future use)
      _editInformationModel = _editInformationModel.copyWith(
        profileImagePath: imagePath, // Keep local path for display
      );
    } catch (e) {
      _editInformationModel = _editInformationModel.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
    notifyListeners();
    
    // Clear message after 3 seconds
    if (_editInformationModel.successMessage != null) {
      Future.delayed(const Duration(seconds: 3), () {
        clearSuccess();
      });
    }
  }

  // Clear error message
  void clearError() {
    if (_editInformationModel.errorMessage != null) {
      _editInformationModel = _editInformationModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_editInformationModel.successMessage != null) {
      _editInformationModel = _editInformationModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }
}
