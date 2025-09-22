import '../model/profile_model.dart';
import '../../../api/auth_api_service.dart';

class ProfileRepository {
  // Fetch user profile via API
  Future<ProfileModel> getUserProfile() async {
    try {
      print('Calling AuthApiService.getUserProfile...');
      final authApiService = AuthApiService();

      final result = await authApiService.getUserProfile();

      if (result != null && result['success'] == true) {
        final profileData = result['profile'] as Map<String, dynamic>;
        final profile = ProfileModel.fromJson(profileData);

        print('Profile fetch success: $profile');
        return profile;
      } else {
        final errorMessage = result?['error'] ?? 'Failed to load profile';
        print('Profile fetch failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Profile repository error: $e');
      if (e.toString().contains('Authentication expired')) {
        throw Exception('Authentication expired. Please login again.');
      } else if (e.toString().contains('Network')) {
        throw Exception('Network error. Please check your connection.');
      } else {
        throw Exception('Failed to load profile. Please try again.');
      }
    }
  }

  // Update user profile via API (placeholder for future implementation)
  Future<ProfileModel> updateUserProfile(ProfileModel profile) async {
    try {
      print('Calling AuthApiService.updateUserProfile...');
      final authApiService = AuthApiService();

      final result = await authApiService.updateUserProfile(
        firstName: profile.firstName,
        email: profile.email,
        city: profile.city ?? '',
        dateOfBirth: profile.dateOfBirth ?? '',
        phone: profile.phone ?? '',
        profilePhoto: profile.profilePhoto,
      );

      if (result != null && result['success'] == true) {
        final profileData = result['profile'] as Map<String, dynamic>;
        final updatedProfile = ProfileModel.fromJson(profileData);

        print('Profile update success: $updatedProfile');
        return updatedProfile;
      } else {
        final errorMessage = result?['error'] ?? 'Failed to update profile';
        print('Profile update failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Profile repository update error: $e');
      if (e.toString().contains('Authentication expired')) {
        throw Exception('Authentication expired. Please login again.');
      } else if (e.toString().contains('Network')) {
        throw Exception('Network error. Please check your connection.');
      } else {
        throw Exception('Failed to update profile. Please try again.');
      }
    }
  }

  // Upload profile picture via API
  Future<String> uploadProfilePicture(String filePath) async {
    try {
      print('Calling AuthApiService.uploadProfilePhoto...');
      final authApiService = AuthApiService();

      final result = await authApiService.uploadProfilePhoto(filePath);
      print('API response: $result');

      if (result != null && result['success'] == true) {
        // Handle nested response structure: {photo: {profile_photo: "url"}}
        final photoData = result['photo'] as Map<String, dynamic>?;
        print('Photo data: $photoData');

        final profilePhotoUrl = photoData?['profile_photo'] as String?;
        print('Extracted profile photo URL: $profilePhotoUrl');

        if (profilePhotoUrl != null) {
          // Convert relative URL to full URL
          final fullUrl = profilePhotoUrl.startsWith('http')
              ? profilePhotoUrl
              : 'http://10.10.13.36$profilePhotoUrl';
          print('Profile photo upload success: $fullUrl');
          return fullUrl;
        } else {
          print('Profile photo URL not found in response');
          throw Exception('Profile photo URL not found in response');
        }
      } else {
        final errorMessage =
            result?['error'] ?? 'Failed to upload profile picture';
        print('Profile photo upload failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Profile repository upload error: $e');
      if (e.toString().contains('Authentication expired')) {
        throw Exception('Authentication expired. Please login again.');
      } else if (e.toString().contains('Network')) {
        throw Exception('Network error. Please check your connection.');
      } else {
        throw Exception('Failed to upload profile picture. Please try again.');
      }
    }
  }
}
