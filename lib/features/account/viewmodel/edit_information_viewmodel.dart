import 'package:flutter/material.dart';
import '../model/edit_information_model.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';
import '../../../core/router.dart';

class EditInformationViewModel extends ChangeNotifier {
  late EditInformationModel _editInformationModel;
  final ProfileRepository _profileRepository = ProfileRepository();
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
    String? profileImagePath,
  }) {
    _initializeData(
      name: name,
      email: email,
      birthDate: birthDate,
      city: city,
      profileImagePath: profileImagePath,
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
    String? profileImagePath,
  }) {
    _editInformationModel = EditInformationModel(
      name: name ?? 'Nicolas Smith',
      email: email ?? 'nicolassmith1234@gmail.com',
      birthDate: birthDate ?? 'Mar 11, 1993',
      city: city ?? 'Colorado',
      profileImagePath: profileImagePath,
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
        _emailController.text.trim().isEmpty) {
      _editInformationModel = _editInformationModel.copyWith(
        errorMessage: 'Name and Email are required',
      );
      notifyListeners();
      return;
    }

    // Basic email validation
    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_emailController.text.trim())) {
      _editInformationModel = _editInformationModel.copyWith(
        errorMessage: 'Please enter a valid email address',
      );
      notifyListeners();
      return;
    }

    _editInformationModel = _editInformationModel.copyWith(
      isLoading: true,
      errorMessage: null,
    );
    notifyListeners();

    try {
      // Create updated profile model
      final updatedProfile = ProfileModel(
        firstName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        city: _cityController.text.trim().isEmpty
            ? null
            : _cityController.text.trim(),
        dateOfBirth: _birthDateController.text.trim().isEmpty
            ? null
            : _birthDateController.text.trim(),
        profilePhoto: _editInformationModel.profileImagePath,
        phone: null, // Phone is not in edit information form
      );

      // Update profile via API
      final result = await _profileRepository.updateUserProfile(updatedProfile);

      _editInformationModel = EditInformationModel(
        name: result.firstName,
        email: result.email,
        birthDate: result.dateOfBirth ?? '',
        city: result.city ?? '',
        profileImagePath: result.profilePhoto,
        isLoading: false,
        successMessage: 'Information updated successfully!',
      );

      print('Profile updated successfully: $result');
    } catch (e) {
      _editInformationModel = _editInformationModel.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      print('Profile update error: ${e.toString()}');
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

  // Update profile picture with selected image
  Future<void> updateProfilePicture(String imagePath) async {
    _editInformationModel = _editInformationModel.copyWith(
      isLoading: true,
      errorMessage: null,
    );
    notifyListeners();

    try {
      // Upload the image to the API
      final profilePhotoUrl = await _profileRepository.uploadProfilePicture(
        imagePath,
      );

      // Store the uploaded URL from API response
      _editInformationModel = _editInformationModel.copyWith(
        profileImagePath: profilePhotoUrl,
        isLoading: false,
        successMessage: 'Profile picture updated successfully!',
      );
      notifyListeners();

      print('Profile picture uploaded successfully: $profilePhotoUrl');
    } catch (e) {
      // If API upload fails, store the local file path temporarily
      _editInformationModel = _editInformationModel.copyWith(
        profileImagePath: imagePath,
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      print('Profile picture upload failed: ${e.toString()}');
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
      _editInformationModel = _editInformationModel.copyWith(
        errorMessage: null,
      );
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_editInformationModel.successMessage != null) {
      _editInformationModel = _editInformationModel.copyWith(
        successMessage: null,
      );
      notifyListeners();
    }
  }
}
