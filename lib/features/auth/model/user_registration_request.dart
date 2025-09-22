class UserRegistrationRequest {
  final String firstName;
  final String email;
  final String phone;
  final String password;
  final String retypePassword;

  UserRegistrationRequest({
    required this.firstName,
    required this.email,
    required this.phone,
    required this.password,
    required this.retypePassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'email': email,
      'phone': phone,
      'password': password,
      'retype_password': retypePassword,
    };
  }
}