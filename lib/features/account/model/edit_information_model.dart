class EditInformationModel {
  final String name;
  final String email;
  final String birthDate;
  final String city;
  final String? profileImagePath;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const EditInformationModel({
    this.name = '',
    this.email = '',
    this.birthDate = '',
    this.city = '',
    this.profileImagePath,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  EditInformationModel copyWith({
    String? name,
    String? email,
    String? birthDate,
    String? city,
    String? profileImagePath,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return EditInformationModel(
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      city: city ?? this.city,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}
