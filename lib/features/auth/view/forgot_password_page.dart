import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/forgot_password_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordViewModel(),
      child: Consumer<ForgotPasswordViewModel>(
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
                      minHeight: MediaQuery.of(context).size.height -
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
                                    icon:SvgPicture.asset(
                                      'assets/icons/back_button.svg',
                                      width:16.w,
                                      height: 12.h,
                                    ),
                                    // Icon(
                                    //   Icons.arrow_back_ios,
                                    //   color: const Color(0xFF424242),
                                    //   size: 20.sp,
                                    // ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color:Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(width: 44.w), // Balance the back button
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
                                          color: const Color(0xFF424242).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(20.r),
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

                                  // Instruction text
                                  Text(
                                    "Enter your email address and we'll send you a verify code to reset your password.",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      height: 1.4,
                                      fontWeight: FontWeight.w400
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(height: 40.h),
                                ],
                              ),
                            ),

                            // Email input field
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3C4), // Light yellow background
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(0xFFFFE8A1),
                                  width: 1.w,
                                ),
                              ),
                              child: TextField(
                                controller: viewModel.emailController,
                                keyboardType: TextInputType.emailAddress,
                                enabled: !viewModel.isLoading,
                                decoration: InputDecoration(
                                  prefixIcon:Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/login_email_icon.svg',
                                      width: 14.w,
                                      height: 12.h,
                                      color: Color(0xFF363636), 
                                        // ignore: deprecated_member_use
                                        colorBlendMode: BlendMode.modulate,
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.email_outlined,
                                  //   color: const Color(0xFFFF8A00),
                                  //   size: 20.sp,
                                  // ),
                                  hintText: 'Enter Email Address',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Request OTP button
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFFA167), // Orange
                                    Color(0xFFFFDF6F), // Yellow
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
                                  onTap: viewModel.isLoading ? null : viewModel.sendResetPasswordEmail,
                                  child: Center(
                                    child: viewModel.isLoading
                                        ? SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child: const CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          )
                                        : Text(
                                            'Request OTP',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Back to Login link
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Back to ',
                                    style: TextStyle(
                                      color: const Color(0xFF424242),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: viewModel.navigateToLogin,
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: const Color(0xFFFF8A00),
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
                                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
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
                                  border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
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
