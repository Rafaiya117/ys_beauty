import '../model/account_model.dart';
import '../model/profile_model.dart';
import '../../../api/auth_api_service.dart';

class AccountRepository {
  // Fetch account information via API
  Future<AccountModel> fetchAccountInformation() async {
    try {
      print('Calling AuthApiService.getUserProfile...');
      final authApiService = AuthApiService();

      final result = await authApiService.getUserProfile();

      if (result != null && result['success'] == true) {
        final profileData = result['profile'] as Map<String, dynamic>;
        final profile = ProfileModel.fromJson(profileData);

        print('Profile fetch success: $profile');
        return AccountModel.fromProfile(profile);
      } else {
        final errorMessage =
            result?['error'] ?? 'Failed to load account information';
        print('Profile fetch failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Account repository error: $e');
      throw Exception('Failed to load account information');
    }
  }

  // Update account information via API
  Future<AccountModel> updateAccountInformation({
    required String name,
    required String email,
    required String dateOfBirth,
    required String location,
    String? phone,
    String? profileImagePath,
  }) async {
    try {
      print('Calling AuthApiService.updateUserProfile...');
      final authApiService = AuthApiService();

      final result = await authApiService.updateUserProfile(
        firstName: name,
        email: email,
        city: location,
        dateOfBirth: dateOfBirth,
        phone: phone ?? '',
        profilePhoto: profileImagePath,
      );

      if (result != null && result['success'] == true) {
        final profileData = result['profile'] as Map<String, dynamic>;
        final profile = ProfileModel.fromJson(profileData);

        print('Account update success: $profile');
        return AccountModel.fromProfile(profile);
      } else {
        final errorMessage =
            result?['error'] ?? 'Failed to update account information';
        print('Account update failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Account repository update error: $e');
      throw Exception('Failed to update account information');
    }
  }

  // Change password via API
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      print('Calling AuthApiService.changePassword...');
      final authApiService = AuthApiService();

      final result = await authApiService.changePassword(
        oldPassword: currentPassword,
        newPassword: newPassword,
        retypePassword: newPassword,
      );

      if (result != null && result['success'] == true) {
        print('Password change success: ${result['message']}');
        return true;
      } else {
        final errorMessage = result?['error'] ?? 'Failed to change password';
        print('Password change failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Account repository password change error: $e');
      if (e.toString().contains('Authentication expired')) {
        throw Exception('Authentication expired. Please login again.');
      } else if (e.toString().contains('Current password is incorrect')) {
        throw Exception('Current password is incorrect');
      } else if (e.toString().contains('Network')) {
        throw Exception('Network error. Please check your connection.');
      } else {
        throw Exception('Failed to change password. Please try again.');
      }
    }
  }

  // Simulate API call to update profile picture
  Future<String> updateProfilePicture(String imagePath) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate potential error (5% chance)
    if (DateTime.now().millisecond % 20 == 0) {
      throw Exception('Failed to upload image');
    }

    // Return mock image URL
    return 'https://example.com/profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
  }
}
