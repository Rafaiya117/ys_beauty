import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/otp_model.dart';
import '../repository/otp_repository.dart';
import '../../../core/router.dart';

class OtpViewModel extends ChangeNotifier {
  final OtpRepository _repository = OtpRepository();
  
  late OtpModel _otpModel;
  final List<TextEditingController> _otpControllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  Timer? _resendTimer;
  int _countdown = 0;

  // Constructor - initialize data immediately
  OtpViewModel({required String email}) {
    _initializeData(email);
  }

  // Getters
  OtpModel get otpModel => _otpModel;
  bool get isLoading => _otpModel.isLoading;
  bool get isVerifying => _otpModel.isVerifying;
  String? get errorMessage => _otpModel.errorMessage;
  String? get successMessage => _otpModel.successMessage;
  bool get isOtpVerified => _otpModel.isOtpVerified;
  int get resendCountdown => _otpModel.resendCountdown;
  bool get canResend => _otpModel.canResend;
  List<TextEditingController> get otpControllers => _otpControllers;
  List<FocusNode> get focusNodes => _focusNodes;

  void _initializeData(String email) {
    _otpModel = OtpModel(email: email);
    _startResendCountdown();
    notifyListeners();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Start resend countdown timer
  void _startResendCountdown() {
    _countdown = 60; // 60 seconds countdown
    _otpModel = _otpModel.copyWith(
      resendCountdown: _countdown,
      canResend: false,
    );
    notifyListeners();

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countdown--;
      _otpModel = _otpModel.copyWith(resendCountdown: _countdown);
      
      if (_countdown <= 0) {
        _otpModel = _otpModel.copyWith(canResend: true);
        timer.cancel();
      }
      notifyListeners();
    });
  }

  // Handle OTP input changes
  void onOtpChanged(String value, int index) {
    if (value.length == 1) {
      // Move to next field
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last field, verify OTP automatically
        _focusNodes[index].unfocus();
        _verifyOtp();
      }
    } else if (value.isEmpty && index > 0) {
      // Move to previous field
      _focusNodes[index - 1].requestFocus();
    }
    
    // Clear error message when user starts typing
    if (_otpModel.errorMessage != null) {
      clearError();
    }
  }

  // Verify OTP
  Future<void> _verifyOtp() async {
    if (isVerifying) return;

    final otpCode = _otpControllers.map((controller) => controller.text).join();
    
    if (otpCode.length != 4) {
      _otpModel = _otpModel.copyWith(
        errorMessage: 'Please enter a valid 4-digit OTP code',
      );
      notifyListeners();
      return;
    }

    _otpModel = _otpModel.copyWith(
      isVerifying: true,
      errorMessage: null,
      successMessage: null,
    );
    notifyListeners();

    try {
      final result = await _repository.verifyOtp(_otpModel.email, otpCode);
      _otpModel = result;
      
      if (result.isOtpVerified) {
        // Navigate to reset password screen or show success
        _navigateToResetPassword();
      }
    } catch (e) {
      _otpModel = _otpModel.copyWith(
        isVerifying: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
    notifyListeners();
  }

  // Manual verify OTP (when user clicks verify button)
  Future<void> verifyOtp() async {
    await _verifyOtp();
  }

  // Resend OTP
  Future<void> resendOtp() async {
    if (!canResend || isLoading) return;

    _otpModel = _otpModel.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );
    notifyListeners();

    try {
      final result = await _repository.resendOtp(_otpModel.email);
      _otpModel = result;
      
      if (result.successMessage != null) {
        // Clear OTP fields
        for (var controller in _otpControllers) {
          controller.clear();
        }
        _focusNodes[0].requestFocus();
        
        // Start new countdown
        _startResendCountdown();
      }
    } catch (e) {
      _otpModel = _otpModel.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
    notifyListeners();
  }

  // Navigate to reset password screen
  void _navigateToResetPassword() {
    AppRouter.navigateToResetPassword(_otpModel.email);
  }

  // Navigate back to forgot password
  void navigateToForgotPassword() {
    AppRouter.goBack();
  }

  // Clear error message
  void clearError() {
    if (_otpModel.errorMessage != null) {
      _otpModel = _otpModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_otpModel.successMessage != null) {
      _otpModel = _otpModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }
}
