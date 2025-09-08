class OtpModel {
  final String email;
  final String otpCode;
  final bool isLoading;
  final bool isVerifying;
  final String? errorMessage;
  final String? successMessage;
  final bool isOtpVerified;
  final int resendCountdown;
  final bool canResend;

  const OtpModel({
    this.email = '',
    this.otpCode = '',
    this.isLoading = false,
    this.isVerifying = false,
    this.errorMessage,
    this.successMessage,
    this.isOtpVerified = false,
    this.resendCountdown = 0,
    this.canResend = true,
  });

  OtpModel copyWith({
    String? email,
    String? otpCode,
    bool? isLoading,
    bool? isVerifying,
    String? errorMessage,
    String? successMessage,
    bool? isOtpVerified,
    int? resendCountdown,
    bool? canResend,
  }) {
    return OtpModel(
      email: email ?? this.email,
      otpCode: otpCode ?? this.otpCode,
      isLoading: isLoading ?? this.isLoading,
      isVerifying: isVerifying ?? this.isVerifying,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      canResend: canResend ?? this.canResend,
    );
  }
}
