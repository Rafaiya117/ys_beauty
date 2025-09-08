import '../model/edit_information_model.dart';

class EditInformationRepository {
  // Simulate API call to update user information
  Future<EditInformationModel> updateUserInformation({
    required String name,
    required String email,
    required String birthDate,
    required String city,
    String? profileImagePath,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate potential error (10% chance)
    if (DateTime.now().millisecond % 10 == 0) {
      throw Exception('Failed to update information. Please try again.');
    }
    
    // Return updated data
    return EditInformationModel(
      name: name,
      email: email,
      birthDate: birthDate,
      city: city,
      profileImagePath: profileImagePath,
    );
  }

  // Simulate API call to validate email format
  Future<bool> validateEmail(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simple email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Simulate API call to check if email is already taken
  Future<bool> isEmailAvailable(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simulate some emails being taken
    final takenEmails = ['admin@example.com', 'test@example.com'];
    return !takenEmails.contains(email.toLowerCase());
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
