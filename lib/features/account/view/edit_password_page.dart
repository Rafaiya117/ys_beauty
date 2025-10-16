import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/edit_password_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class EditPasswordPage extends StatelessWidget {
  const EditPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditPasswordViewModel(),
      child: Consumer<EditPasswordViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.backgroundImagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
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
                          Expanded(
                            child: Text(
                              'Edit Password',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF424242),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 44.w), // Balance the back button
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Main Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            // Password Input Section
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(24.w),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFFFF3C4,
                                ), // Light cream background
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1.w,
                                ),
                              ),
                              child: Column(
                                children: [
                                  // Current Password Field
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: const Color(0xFFE0E0E0),
                                        width: 1.w,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: const Color(0xFFFF8A00),
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 12.w),
                                        Flexible(
                                          child: TextField(
                                            controller: viewModel
                                                .currentPasswordController,
                                            obscureText: !viewModel
                                                .editPasswordModel
                                                .isCurrentPasswordVisible,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF424242),
                                            ),
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Enter Current Password',
                                              hintStyle: TextStyle(
                                                color: const Color(0xFF9E9E9E),
                                                fontSize: 16.sp,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: viewModel
                                              .toggleCurrentPasswordVisibility,
                                          child: Icon(
                                            viewModel
                                                    .editPasswordModel
                                                    .isCurrentPasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: const Color(0xFF9E9E9E),
                                            size: 20.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 16.h),

                                  // New Password Field
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: const Color(0xFFE0E0E0),
                                        width: 1.w,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: const Color(0xFFFF8A00),
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 12.w),
                                        Flexible(
                                          child: TextField(
                                            controller:
                                                viewModel.newPasswordController,
                                            obscureText: !viewModel
                                                .editPasswordModel
                                                .isNewPasswordVisible,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF424242),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Enter New Password',
                                              hintStyle: TextStyle(
                                                color: const Color(0xFF9E9E9E),
                                                fontSize: 16.sp,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: viewModel
                                              .toggleNewPasswordVisibility,
                                          child: Icon(
                                            viewModel
                                                    .editPasswordModel
                                                    .isNewPasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: const Color(0xFF9E9E9E),
                                            size: 20.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 16.h),

                                  // Confirm Password Field
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: const Color(0xFFE0E0E0),
                                        width: 1.w,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: const Color(0xFFFF8A00),
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 12.w),
                                        Flexible(
                                          child: TextField(
                                            controller: viewModel
                                                .confirmPasswordController,
                                            obscureText: !viewModel
                                                .editPasswordModel
                                                .isConfirmPasswordVisible,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF424242),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Re-enter New Password',
                                              hintStyle: TextStyle(
                                                color: const Color(0xFF9E9E9E),
                                                fontSize: 16.sp,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: viewModel
                                              .toggleConfirmPasswordVisibility,
                                          child: Icon(
                                            viewModel
                                                    .editPasswordModel
                                                    .isConfirmPasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: const Color(0xFF9E9E9E),
                                            size: 20.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Update Password Button
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF8A00), // Orange
                                    Color(0xFFFFC107), // Yellow
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: viewModel.isLoading
                                      ? null
                                      : viewModel.updatePassword,
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Center(
                                    child: viewModel.isLoading
                                        ? SizedBox(
                                            width: 24.w,
                                            height: 24.h,
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
                                            'Update Password',
                                            style: TextStyle(
                                              color: const Color(0xFF424242),
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Password Requirement Note
                            Text(
                              'Make sure your new password is at least 8 characters long.',
                              style: TextStyle(
                                color: const Color(0xFF424242),
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),

                    // Success message
                    if (viewModel.successMessage != null) ...[
                      Container(
                        margin: EdgeInsets.all(16.w),
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
                        margin: EdgeInsets.all(16.w),
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
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
