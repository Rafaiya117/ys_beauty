import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/otp_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class OtpPage extends StatelessWidget {
  final String email;

  const OtpPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OtpViewModel(email: email),
      child: Consumer<OtpViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.backgroundImagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with back button
                            Padding(
                              padding: EdgeInsets.only(top: 16.h, bottom: 32.h),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: const Color(0xFF424242),
                                      size: 20.sp,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'OTP',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF424242),
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: 44.w,
                                  ), // Balance the back button
                                ],
                              ),
                            ),

                            // Logo and illustration section
                            Center(
                              child: Column(
                                children: [
                                  // App logo
                                  Image.asset(
                                    AppConstants.appLogo,
                                    width: 120.w,
                                    height: 120.h,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 120.w,
                                        height: 120.h,
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF424242,
                                          ).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.image,
                                          size: 40.sp,
                                          color: const Color(0xFF424242),
                                        ),
                                      );
                                    },
                                  ),

                                  SizedBox(height: 24.h),

                                  // Verify OTP title
                                  Text(
                                    'Verify OTP',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF424242),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(height: 8.h),

                                  // Instruction text
                                  Text(
                                    'We have sent a 4-digit code to your email',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: const Color(0xFF424242),
                                      height: 1.4,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(height: 40.h),
                                ],
                              ),
                            ),

                            // OTP input fields
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(4, (index) {
                                return Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFFFF3C4,
                                    ), // Light yellow background
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: const Color(0xFFE0E0E0),
                                      width: 1.w,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: viewModel.otpControllers[index],
                                    focusNode: viewModel.focusNodes[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    enabled: !viewModel.isVerifying,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF424242),
                                    ),
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    onChanged: (value) {
                                      viewModel.onOtpChanged(value, index);
                                    },
                                  ),
                                );
                              }),
                            ),

                            SizedBox(height: 32.h),

                            // Verify button
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF8A00), // Orange
                                    Color(0xFFFFD700), // Yellow
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onTap: viewModel.isVerifying
                                      ? null
                                      : viewModel.verifyOtp,
                                  child: Center(
                                    child: viewModel.isVerifying
                                        ? SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child:
                                                const CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.white),
                                                ),
                                          )
                                        : Text(
                                            'Verify',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Resend OTP section
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Didn't get the code?",
                                    style: TextStyle(
                                      color: const Color(0xFF424242),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  GestureDetector(
                                    onTap:
                                        viewModel.canResend &&
                                            !viewModel.isLoading
                                        ? viewModel.resendOtp
                                        : null,
                                    child: Text(
                                      viewModel.canResend
                                          ? 'Resend OTP'
                                          : 'Resend OTP (${viewModel.resendCountdown}s)',
                                      style: TextStyle(
                                        color: viewModel.canResend
                                            ? const Color(0xFFFF8A00)
                                            : const Color(0xFF9E9E9E),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Success message
                            if (viewModel.successMessage != null) ...[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: Colors.green.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(
                                  viewModel.successMessage!,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],

                            // Error message
                            if (viewModel.errorMessage != null) ...[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: Colors.red.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(
                                  viewModel.errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
