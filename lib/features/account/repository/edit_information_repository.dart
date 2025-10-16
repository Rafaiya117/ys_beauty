import '../model/edit_information_model.dart';

class EditInformationRepository {
  Future<EditInformationModel> updateUserInformation({
    required String name,
    required String email,
    required String birthDate,
    required String city,
    String? profileImagePath,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (DateTime.now().millisecond % 10 == 0) {
      throw Exception('Failed to update information. Please try again.');
    }
    
    return EditInformationModel(
      name: name,
      email: email,
      birthDate: birthDate,
      city: city,
      profileImagePath: profileImagePath,
    );
  }

  Future<bool> validateEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  Future<bool> isEmailAvailable(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final takenEmails = ['admin@example.com', 'test@example.com'];
    return !takenEmails.contains(email.toLowerCase());
  }
  Future<String> updateProfilePicture(String imagePath) async {
    await Future.delayed(const Duration(seconds: 2));
    if (DateTime.now().millisecond % 20 == 0) {
      throw Exception('Failed to upload image');
    }
    return 'https://example.com/profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
  }
}
