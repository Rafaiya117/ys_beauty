import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/feedback_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FeedbackViewModel()..loadFeedback(),
      child: Consumer<FeedbackViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF8E1), // Light yellow background
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Header
                    _buildHeader(context),
                    
                    SizedBox(height: 20.h),
                    
                    // Content
                    Expanded(
                      child: _buildContent(viewModel),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child:SvgPicture.asset(
              'assets/icons/back_button.svg',
              width:16.w,
              height: 12.h,
            ),
            // Icon(
            //   Icons.arrow_back_ios,
            //   size: 24.sp,
            //   color: Colors.black,
            // ),
          ),
          
          // Title - Centered
          Expanded(
            child: Center(
              child: Text(
                'Feedback',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          
          // Spacer to balance the back button
          SizedBox(width: 24.w),
        ],
      ),
    );
  }

  Widget _buildContent(FeedbackViewModel viewModel) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Feedback Section
          Text(
            'Feedback',
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Description text
          Text(
            'Let us know how we can improve Market Pop! If you have a feature request, can you also share how you would use it and why it\'s important to you?',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.normal,
              //height: 1.4,
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Feedback input field
          _buildFeedbackInputField(viewModel),
          
          SizedBox(height: 20.h),
          
          // Email contact text
          Text(
            'You can also email us at support@marketpop.com.',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400
            ),
          ),
          
          SizedBox(height: 40.h),
          
          // Send Feedback Button
          _buildSendFeedbackButton(viewModel),
          
          SizedBox(height: 20.h),
          
          // Success/Error messages
          if (viewModel.isSuccess)
            _buildSuccessMessage(),
          
          if (viewModel.error != null)
            _buildErrorMessage(viewModel.error!),
        ],
      ),
    );
  }

  Widget _buildFeedbackInputField(FeedbackViewModel viewModel) {
    return Container(
      height: 131.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C4), // Slightly darker yellow
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFFF3C7),
          width: 1.w,
        ),
      ),
      child: TextField(
        controller: viewModel.feedbackController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          height: 1.4,
        ),
        decoration: InputDecoration(
          hintText: 'Enter Your Feedback',
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color:Colors.black,
            fontWeight: FontWeight.normal
            // height: 1.4,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildSendFeedbackButton(FeedbackViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFA267), Color(0xFFFFDF6F)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8A00).withValues(alpha: 0.3),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: viewModel.isSubmitting ? null : () => viewModel.submitFeedback(),
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: viewModel.isSubmitting
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Send Feedback',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFF4CAF50),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: const Color(0xFF4CAF50),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Thank you for your feedback! We\'ll review it and get back to you soon.',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF2E7D32),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFFE91E63),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error,
            color: const Color(0xFFE91E63),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              error,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFFC62828),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
