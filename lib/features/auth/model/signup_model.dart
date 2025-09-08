class SignUpModel {
  final bool isEmailSignUpLoading;
  final bool isGoogleSignUpLoading;
  final bool isPasswordVisible;
  final bool isRememberMe;
  final String? errorMessage;

  SignUpModel({
    this.isEmailSignUpLoading = false,
    this.isGoogleSignUpLoading = false,
    this.isPasswordVisible = false,
    this.isRememberMe = false,
    this.errorMessage,
  });

  // Helper getter for backward compatibility
  bool get isLoading => isEmailSignUpLoading || isGoogleSignUpLoading;

  SignUpModel copyWith({
    bool? isEmailSignUpLoading,
    bool? isGoogleSignUpLoading,
    bool? isPasswordVisible,
    bool? isRememberMe,
    String? errorMessage,
  }) {
    return SignUpModel(
      isEmailSignUpLoading: isEmailSignUpLoading ?? this.isEmailSignUpLoading,
      isGoogleSignUpLoading: isGoogleSignUpLoading ?? this.isGoogleSignUpLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
