import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/signup_viewmodel.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_constants.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
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
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Sign Up',
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
                                    width: 96.48.w,
                                    height: 86.75.h,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 120.w,
                                        height: 120.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF424242,).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(20.r,),
                                        ),
                                        child: Icon(
                                          Icons.image,
                                          size: 40.sp,
                                          color: const Color(0xFF424242),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            // Create Account title
                            Text(
                              'Create Account',
                              style: GoogleFonts.poppins(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Name input field
                            Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3C6),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: const Color(0xFFFFE8A1),
                                  width: 1.w,
                                ),
                              ),
                              child: TextField(
                                controller: viewModel.nameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/reg_user_icon.svg',
                                      width: 14.w,
                                      height: 12.h,
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.person_outline,
                                  //   color: const Color(0xFFFF8A00),
                                  //   size: 20.sp,
                                  // ),
                                  hintText: 'Enter Name',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF1A1A1A),
                                    fontSize: 12.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Phone input field
                            Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3C6),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: const Color(0xFFFFE8A1),
                                  width: 1.w,
                                ),
                              ),
                              child: TextField(
                                controller: viewModel.phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefixIcon:Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/reg_phone.svg',
                                      width: 14.w,
                                      height: 12.h,
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.phone_outlined,
                                  //   color: const Color(0xFFFF8A00),
                                  //   size: 20.sp,
                                  // ),
                                  hintText: 'Enter Phone Number',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF1A1A1A),
                                    fontSize: 12.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            // Email input field
                            Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3C6),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: const Color(0xFFFFE8A1),
                                  width: 1.w,
                                ),
                              ),
                              child: TextField(
                                controller: viewModel.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon:Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/login_email_icon.svg',
                                      width: 14.w,
                                      height: 12.h,
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.email_outlined,
                                  //   color: const Color(0xFFFF8A00),
                                  //   size: 20.sp,
                                  // ),
                                  hintText: 'Enter Email Address',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF1A1A1A),
                                    fontSize: 12.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Password input field
                            Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3C6),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: const Color(0xFFFFE8A1),
                                  width: 1.w,
                                ),
                              ),
                              child: TextField(
                                controller: viewModel.passwordController,
                                obscureText: viewModel.isPasswordVisible,
                                decoration: InputDecoration(
                                  prefixIcon:Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/login_password.svg',
                                      width: 14.w,
                                      height: 12.h,
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.lock_outline,
                                  //   color: const Color(0xFFFF8A00),
                                  //   size: 20.sp,
                                  // ),
                                  suffixIcon: IconButton(
                                    onPressed:
                                        viewModel.togglePasswordVisibility,
                                    icon: Icon(
                                      viewModel.isPasswordVisible
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: const Color(0xFFFF8A00),
                                      size: 20.sp,
                                    ),
                                  ),
                                  hintText: 'Enter Password',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF1A1A1A),
                                    fontSize: 12.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Remember me checkbox
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: viewModel.toggleRememberMe,
                                  child: Container(
                                    width: 14.w,
                                    height: 14.h,
                                    decoration: BoxDecoration(
                                      color: viewModel.isRememberMe
                                          ? const Color(0xFFFF8A00)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: const Color(0xFF1B1B1B),
                                        width: 2.w,
                                      ),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: viewModel.isRememberMe
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 14.sp,
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Sign Up button
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
                                  onTap: viewModel.isEmailSignUpLoading
                                      ? null
                                      : viewModel.signUp,
                                  child: Center(
                                    child: viewModel.isEmailSignUpLoading
                                      ? SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                          child:const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:AlwaysStoppedAnimation<Color>(Colors.black54),
                                            ),
                                          )
                                        : Text(
                                            'Sign Up',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Or Continue With
                            Center(
                              child: Text(
                                'Or Continue With',
                                style: TextStyle(
                                  color: const Color(0xFF424242),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),

                            SizedBox(height: 10.h),

                            // Google sign up button
                            Center(
                              child: GestureDetector(
                                onTap: viewModel.isGoogleSignUpLoading
                                    ? null
                                    : viewModel.googleSignUp,
                                child: viewModel.isGoogleSignUpLoading
                                    ? SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Color(0xFF4285F4),
                                              ),
                                        ),
                                      )
                                    : Image.asset(
                                        AppConstants.googleLogoPath,
                                        width: 24.w,
                                        height: 24.h,
                                        errorBuilder:(context, error, stackTrace) {
                                    return Icon(
                                      Icons.g_mobiledata,
                                      size: 50.sp,
                                      color: const Color(0xFF4285F4),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            // Login link
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Have an account? ",
                                    style: TextStyle(
                                      color: const Color(0xFF424242),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: viewModel.navigateToLogin,
                                    child: Text(
                                      'Log In',
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
