class LoginModel {
  final bool isEmailLoginLoading;
  final bool isGoogleLoginLoading;
  final bool isPasswordVisible;
  final String? errorMessage;

  LoginModel({
    this.isEmailLoginLoading = false,
    this.isGoogleLoginLoading = false,
    this.isPasswordVisible = false,
    this.errorMessage,
  });

  // Helper getter for backward compatibility
  bool get isLoading => isEmailLoginLoading || isGoogleLoginLoading;

  LoginModel copyWith({
    bool? isEmailLoginLoading,
    bool? isGoogleLoginLoading,
    bool? isPasswordVisible,
    String? errorMessage,
  }) {
    return LoginModel(
      isEmailLoginLoading: isEmailLoginLoading ?? this.isEmailLoginLoading,
      isGoogleLoginLoading: isGoogleLoginLoading ?? this.isGoogleLoginLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
