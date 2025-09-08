import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/login_viewmodel.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFF8E1), // Light yellow background
            body: SafeArea(
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
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: const Color(0xFF424242),
                                    size: 20.sp,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF424242),
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
                                
                                // App description
                                Text(
                                  'Made for market entrepreneurs',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF424242),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                
                                SizedBox(height: 8.h),
                                
                                Text(
                                  'Stay organized. Stay booked. Stay growing.',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF757575),
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
                                color: const Color(0xFFE0E0E0),
                                width: 1.w,
                              ),
                            ),
                            child: TextField(
                              controller: viewModel.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: const Color(0xFFFF8A00),
                                  size: 20.sp,
                                ),
                                hintText: 'Enter Email Address',
                                hintStyle: TextStyle(
                                  color: const Color(0xFF9E9E9E),
                                  fontSize: 16.sp,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 16.h),
                          
                          // Password input field
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3C4), // Light yellow background
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1.w,
                              ),
                            ),
                            child: TextField(
                              controller: viewModel.passwordController,
                              obscureText: viewModel.isPasswordVisible,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: const Color(0xFFFF8A00),
                                  size: 20.sp,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: viewModel.togglePasswordVisibility,
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
                                  color: const Color(0xFF9E9E9E),
                                  fontSize: 16.sp,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 2.h),
                          
                          // Forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: viewModel.forgotPassword,
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: const Color(0xFF424242),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 5.h),
                          
                          // Login button
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
                                onTap: viewModel.isEmailLoginLoading ? null : viewModel.login,
                                child: Center(
                                  child: viewModel.isEmailLoginLoading
                                      ? SizedBox(
                                          width: 20.w,
                                          height: 20.h,
                                          child: const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : Text(
                                          'Log In',
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
                          
                          SizedBox(height: 10.h),
                          
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
                          
                          SizedBox(height: 16.h),
                          
                          // Google login button
                          Center(
                            child: GestureDetector(
                              onTap: viewModel.isGoogleLoginLoading ? null : viewModel.googleLogin,
                              child: Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 8.r,
                                      offset: Offset(0, 2.h),
                                    ),
                                  ],
                                ),
                                child: viewModel.isGoogleLoginLoading
                                    ? SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4285F4)),
                                        ),
                                      )
                                    : Image.asset(
                                        AppConstants.googleLogoPath,
                                        width: 24.w,
                                        height: 24.h,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(
                                            Icons.g_mobiledata,
                                            size: 24.sp,
                                            color: const Color(0xFF4285F4),
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 10.h),
                          
                          // Sign up link
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: const Color(0xFF424242),
                                    fontSize: 14.sp,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: viewModel.navigateToSignUp,
                                  child: Text(
                                    'Sign Up',
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
                          
                          SizedBox(height: 10.h),
                          
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
          );
        },
      ),
    );
  }
}