import 'package:flutter/material.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  late ProfileModel _profileModel;
  final ProfileRepository _profileRepository = ProfileRepository();

  // Constructor - initialize with empty data
  ProfileViewModel() {
    _initializeData();
  }

  // Getters
  ProfileModel get profileModel => _profileModel;
  bool get isLoading => _profileModel.isLoading;
  String? get errorMessage => _profileModel.errorMessage;
  String? get successMessage => _profileModel.successMessage;

  void _initializeData() {
    _profileModel = const ProfileModel();
    notifyListeners();
  }

  // Fetch user profile from API
  Future<void> fetchProfile() async {
    _profileModel = _profileModel.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final profile = await _profileRepository.getUserProfile();
      _profileModel = profile.copyWith(isLoading: false);
      print('Profile loaded successfully: ${_profileModel.toString()}');
    } catch (e) {
      _profileModel = _profileModel.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      print('Profile loading error: ${_profileModel.errorMessage}');
    }
    notifyListeners();
  }

  // Update profile data
  Future<void> updateProfile(ProfileModel updatedProfile) async {
    _profileModel = _profileModel.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final profile = await _profileRepository.updateUserProfile(
        updatedProfile,
      );
      _profileModel = profile.copyWith(
        isLoading: false,
        successMessage: 'Profile updated successfully!',
      );
      print('Profile updated successfully: ${_profileModel.toString()}');
    } catch (e) {
      _profileModel = _profileModel.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      print('Profile update error: ${_profileModel.errorMessage}');
    }
    notifyListeners();

    // Clear success message after 3 seconds
    if (_profileModel.successMessage != null) {
      Future.delayed(const Duration(seconds: 3), () {
        clearSuccess();
      });
    }
  }

  // Clear error message
  void clearError() {
    if (_profileModel.errorMessage != null) {
      _profileModel = _profileModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_profileModel.successMessage != null) {
      _profileModel = _profileModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }

  // Refresh profile data
  Future<void> refreshProfile() async {
    await fetchProfile();
  }
}
