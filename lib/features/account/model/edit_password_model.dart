class EditPasswordModel {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isCurrentPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const EditPasswordModel({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isCurrentPasswordVisible = false,
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  EditPasswordModel copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isCurrentPasswordVisible,
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return EditPasswordModel(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isCurrentPasswordVisible: isCurrentPasswordVisible ?? this.isCurrentPasswordVisible,
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}
