import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../viewmodel/edit_information_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class EditInformationPage extends StatelessWidget {
  final String? name;
  final String? email;
  final String? birthDate;
  final String? city;
  final String? profileImagePath;

  const EditInformationPage({
    super.key,
    this.name,
    this.email,
    this.birthDate,
    this.city,
    this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditInformationViewModel(
        name: name,
        email: email,
        birthDate: birthDate,
        city: city,
        profileImagePath: profileImagePath,
      ),
      child: Consumer<EditInformationViewModel>(
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
                              'Edit Information',
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
                          children: [
                            // Profile Card
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFFFF3C4,
                                ), // Light cream/yellow background
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1.w,
                                ),
                              ),
                              child: Column(
                                children: [
                                  // Profile Picture
                                  Stack(
                                    children: [
                                      Container(
                                        width: 100.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFFE0E0E0),
                                        ),
                                        child:viewModel.editInformationModel.profileImagePath !=null
                                          ? ClipOval(
                                          child: _buildProfileImage(
                                            viewModel.editInformationModel.profileImagePath!,
                                          ),
                                        )
                                        : const Icon(
                                          Icons.person,
                                          size: 50,
                                          color: Color(0xFF9E9E9E),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () => _showImagePicker(context,viewModel,),
                                          child: Container(
                                            width: 32.w,
                                            height: 32.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2196F3),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2.w,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.camera_alt,
                                              size: 16.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24.h),
                                  // Name Field
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
                                        SvgPicture.asset(
                                          'assets/icons/profile_user.svg',
                                          width: 16.w,
                                          height: 16.h,
                                        ),
                                        // Icon(
                                        //   Icons.person,
                                        //   color: Colors.black,
                                        //   size: 20.sp,
                                        // ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: TextField(
                                            controller:viewModel.nameController,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF424242),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Enter Name',
                                              hintStyle: TextStyle(
                                                color: const Color(0xFF9E9E9E),
                                                fontSize: 16.sp,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  // Email Field
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h,),
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
                                          Icons.email,
                                          color: Color(0xFFFFA268),
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: TextField(
                                            controller:viewModel.emailController,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF424242),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Enter Email Address',
                                              hintStyle: TextStyle(
                                                color: const Color(0xFF9E9E9E),
                                                fontSize: 16.sp,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  // Birth Date and City Row
                                  Row(
                                    children: [
                                      // Birth Date
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                            vertical: 12.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12.r,),
                                            border: Border.all(
                                              color: const Color(0xFFE0E0E0),
                                              width: 1.w,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: Color(0xFFFFA268),
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 12.w),
                                              Expanded(
                                                child: TextField(
                                                  controller: viewModel.birthDateController,
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: const Color(
                                                      0xFF424242,
                                                    ),
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText:'Enter Birth-date',
                                                    hintStyle: TextStyle(
                                                      color: const Color(0xFF9E9E9E,),
                                                      fontSize: 16.sp,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      // City
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                            vertical: 12.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12.r,),
                                            border: Border.all(
                                              color: const Color(0xFFE0E0E0),
                                              width: 1.w,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_city,
                                                color: Color(0xFFFFA268),
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 12.w),
                                              Expanded(
                                                child: TextField(
                                                  controller:viewModel.cityController,
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: const Color(
                                                      0xFF424242,
                                                    ),
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: 'Enter City',
                                                    hintStyle: TextStyle(
                                                      color: const Color(
                                                        0xFF9E9E9E,
                                                      ),
                                                      fontSize: 16.sp,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),

                    // Action Buttons
                    Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        children: [
                          // Save Button
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
                                onTap: viewModel.isLoading
                                  ? null
                                  : viewModel.saveChanges,
                                borderRadius: BorderRadius.circular(12.r),
                                child: Center(
                                  child: viewModel.isLoading
                                    ? SizedBox(
                                      width: 24.w,
                                      height: 24.h,
                                        child:const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ): Text(
                                          'Save',
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
                            SizedBox(height: 12.h),
                            // Cancel Button
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFF424242),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: viewModel.cancelChanges,
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  void _showImagePicker(BuildContext context,EditInformationViewModel viewModel,) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              // Title
              Text(
                'Select Profile Picture',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF424242),
                ),
              ),
              SizedBox(height: 20.h),
              // Options
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Colors.black,
                  size: 24.sp,
                ),
                title: Text(
                  'Choose from Gallery',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF424242),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromGallery(viewModel);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickFromGallery(EditInformationViewModel viewModel) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        await viewModel.updateProfilePicture(image.path);
      }
    } catch (e) {
      // Handle error - could show a snackbar or error message
      // In production, you might want to show a user-friendly error message
    }
  }

  Widget _buildProfileImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        width: 100.w,
        height: 100.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.person, size: 50, color: Color(0xFF9E9E9E));
        },
      );
    } else if (imagePath.startsWith('/')) {
      final fullUrl = 'http://10.10.13.36$imagePath';
      return Image.network(
        fullUrl,
        width: 100.w,
        height: 100.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.person, size: 50, color: Color(0xFF9E9E9E));
        },
      );
    } else {
      return Image.file(
        File(imagePath),
        width: 100.w,
        height: 100.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.person, size: 50, color: Color(0xFF9E9E9E));
        },
      );
    }
  }
}
