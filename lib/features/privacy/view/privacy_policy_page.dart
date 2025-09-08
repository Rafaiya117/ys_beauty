import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/privacy_policy_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrivacyPolicyViewModel(),
      child: Consumer<PrivacyPolicyViewModel>(
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
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
                          Expanded(
                            child: Text(
                              'Privacy Policy',
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
                    
                    SizedBox(height: 20.h),
                    
                    // Main Content
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3C4), // Light yellow/cream background
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(20.w),
                            child: Text(
                              viewModel.content,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF424242),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    // Success message
                    if (viewModel.successMessage != null) ...[
                      Container(
                        margin: EdgeInsets.all(16.w),
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
                        margin: EdgeInsets.all(16.w),
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
          );
        },
      ),
    );
  }
}
