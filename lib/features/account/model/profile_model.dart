class ProfileModel {
  final String firstName;
  final String email;
  final String? city;
  final String? dateOfBirth;
  final String? profilePhoto;
  final String? phone;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const ProfileModel({
    this.firstName = '',
    this.email = '',
    this.city,
    this.dateOfBirth,
    this.profilePhoto,
    this.phone,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  // Factory constructor to create ProfileModel from API response
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['first_name'] ?? '',
      email: json['email'] ?? '',
      city: json['city'],
      dateOfBirth: json['date_of_birth'],
      profilePhoto: json['profile_photo'],
      phone: json['phone'],
    );
  }

  // Convert ProfileModel to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'email': email,
      'city': city,
      'date_of_birth': dateOfBirth,
      'profile_photo': profilePhoto,
      'phone': phone,
    };
  }

  ProfileModel copyWith({
    String? firstName,
    String? email,
    String? city,
    String? dateOfBirth,
    String? profilePhoto,
    String? phone,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return ProfileModel(
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      city: city ?? this.city,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      phone: phone ?? this.phone,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  String toString() {
    return 'ProfileModel(firstName: $firstName, email: $email, city: $city, dateOfBirth: $dateOfBirth, profilePhoto: $profilePhoto, phone: $phone)';
  }
}
