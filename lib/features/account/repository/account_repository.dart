import '../model/account_model.dart';

class AccountRepository {
  // Simulate API call to fetch account information
  Future<AccountModel> fetchAccountInformation() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return mock data
    return const AccountModel(
      name: 'Nicolas Smith',
      email: 'nicolassmith1234@gmail.com',
      dateOfBirth: 'Mar 11, 1993',
      location: 'Colorado',
      profileImagePath: null,
    );
  }

  // Simulate API call to update account information
  Future<AccountModel> updateAccountInformation({
    required String name,
    required String email,
    required String dateOfBirth,
    required String location,
    String? profileImagePath,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate potential error (10% chance)
    if (DateTime.now().millisecond % 10 == 0) {
      throw Exception('Network error occurred');
    }
    
    // Return updated data
    return AccountModel(
      name: name,
      email: email,
      dateOfBirth: dateOfBirth,
      location: location,
      profileImagePath: profileImagePath,
    );
  }

  // Simulate API call to change password
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate potential error (5% chance)
    if (DateTime.now().millisecond % 20 == 0) {
      throw Exception('Current password is incorrect');
    }
    
    // Return success
    return true;
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
