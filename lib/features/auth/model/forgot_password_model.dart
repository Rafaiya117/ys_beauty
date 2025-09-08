import '../../../shared/constants/app_constants.dart';

class ForgotPasswordModel {
  final String email;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final bool isEmailSent;

  const ForgotPasswordModel({
    this.email = '',
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.isEmailSent = false,
  });

  ForgotPasswordModel copyWith({
    String? email,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool? isEmailSent,
  }) {
    return ForgotPasswordModel(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isEmailSent: isEmailSent ?? this.isEmailSent,
    );
  }
}
