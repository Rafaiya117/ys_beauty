import '../../../shared/constants/app_constants.dart';

class AuthModel {
  final bool isLoginLoading;
  final bool isSignUpLoading;
  final String? errorMessage;
  final String logoPath;
  final String backgroundImagePath;

  AuthModel({
    this.isLoginLoading = false,
    this.isSignUpLoading = false,
    this.errorMessage,
    this.logoPath = AppConstants.appLogo,
    this.backgroundImagePath = AppConstants.backgroundImagePath,
  });

  AuthModel copyWith({
    bool? isLoginLoading,
    bool? isSignUpLoading,
    String? errorMessage,
    String? logoPath,
    String? backgroundImagePath,
  }) {
    return AuthModel(
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isSignUpLoading: isSignUpLoading ?? this.isSignUpLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      logoPath: logoPath ?? this.logoPath,
      backgroundImagePath: backgroundImagePath ?? this.backgroundImagePath,
    );
  }
}
