class ResetPasswordModel {
  final String email;
  final String newPassword;
  final String confirmPassword;
  final bool isLoading;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String? errorMessage;
  final String? successMessage;
  final bool isPasswordReset;

  const ResetPasswordModel({
    this.email = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.errorMessage,
    this.successMessage,
    this.isPasswordReset = false,
  });

  ResetPasswordModel copyWith({
    String? email,
    String? newPassword,
    String? confirmPassword,
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? errorMessage,
    String? successMessage,
    bool? isPasswordReset,
  }) {
    return ResetPasswordModel(
      email: email ?? this.email,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
    );
  }
}
