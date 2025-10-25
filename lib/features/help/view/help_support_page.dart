import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import '../viewmodel/help_support_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HelpSupportViewModel(),
      child: Consumer<HelpSupportViewModel>(
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
                              'Help & Support',
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
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Submit a request heading
                            Text(
                              'Submit a request',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF424242),
                              ),
                            ),
                            
                            SizedBox(height: 32.h),
                            
                            // Email Input Field
                            _buildEmailInputField(viewModel),
                            
                            SizedBox(height: 20.h),
                            
                            // Request Details Text Area
                            _buildRequestDetailsField(viewModel),
                            
                            SizedBox(height: 20.h),
                            
                            // File Upload Area
                            _buildFileUploadArea(viewModel),
                            
                            // Selected Files
                            if (viewModel.selectedFiles.isNotEmpty) ...[
                              SizedBox(height: 16.h),
                              _buildSelectedFiles(viewModel),
                            ],
                            
                            SizedBox(height: 40.h),
                            
                            // Submit Button
                            _buildSubmitButton(viewModel),
                            
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

  Widget _buildEmailInputField(HelpSupportViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFFE89D),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          // Orange envelope icon
          Icon(
            Icons.email_outlined,
            color:Color(0xFF1B1B1B), //const Color(0xFFFF8A00),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          // Email input field
          Expanded(
            child: TextField(
              controller: viewModel.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter Email',
                hintStyle: TextStyle(
                  color: const Color(0xFF9E9E9E),
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF424242),
              ),
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }

  Widget _buildRequestDetailsField(HelpSupportViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFFE89D),
          width: 1.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: TextField(
          controller: viewModel.requestDetailsController,
          maxLines: null,
          expands: true,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: 'Please enter the details of your request. A member of our support staff will respond as soon as possible',
            hintStyle: TextStyle(
              color: const Color(0xFF9E9E9E),
              fontSize: 12.sp,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF424242),
          ),
        ),
      ),
    );
  }

  Widget _buildFileUploadArea(HelpSupportViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.onFileUploadTap(),
      child: Container(
        width: double.infinity,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFFFE89D),
            width: 1.w,
          ),
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Add file',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: ' or drop files here',
                  style: TextStyle(
                    color: const Color(0xFF9E9E9E),
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedFiles(HelpSupportViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Files (${viewModel.selectedFiles.length})',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF424242),
          ),
        ),
        SizedBox(height: 8.h),
        ...viewModel.selectedFiles.asMap().entries.map((entry) {
          int index = entry.key;
          File file = entry.value;
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 1.w,
              ),
            ),
            child: Row(
              children: [
                // File icon
                Icon(
                  Icons.image,
                  color: const Color(0xFFFF8A00),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                // File name
                Expanded(
                  child: Text(
                    file.path.split('/').last,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF424242),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Remove button
                GestureDetector(
                  onTap: () => viewModel.removeFile(index),
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 18.sp,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSubmitButton(HelpSupportViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.isLoading ? null : () => viewModel.submitRequest(),
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFA167), Color(0xFFFFDF6F)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: viewModel.isLoading
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
