class AccountModel {
  final String name;
  final String email;
  final String dateOfBirth;
  final String location;
  final String? profileImagePath;
  final bool isLoading;
  final bool isEditing;
  final String? errorMessage;
  final String? successMessage;

  const AccountModel({
    this.name = 'Nicolas Smith',
    this.email = 'nicolassmith1234@gmail.com',
    this.dateOfBirth = 'Mar 11, 1993',
    this.location = 'Colorado',
    this.profileImagePath,
    this.isLoading = false,
    this.isEditing = false,
    this.errorMessage,
    this.successMessage,
  });

  AccountModel copyWith({
    String? name,
    String? email,
    String? dateOfBirth,
    String? location,
    String? profileImagePath,
    bool? isLoading,
    bool? isEditing,
    String? errorMessage,
    String? successMessage,
  }) {
    return AccountModel(
      name: name ?? this.name,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      isLoading: isLoading ?? this.isLoading,
      isEditing: isEditing ?? this.isEditing,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}
