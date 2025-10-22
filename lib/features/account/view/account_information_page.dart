import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import '../viewmodel/account_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../core/router.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({super.key});

  @override
  State<AccountInformationPage> createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  late AccountViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AccountViewModel();
    _loadAccountData();
  }

  Future<void> _loadAccountData() async {
    await _viewModel.fetchAccountInformation();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<AccountViewModel>(
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
                      padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h,),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon:SvgPicture.asset(
                              'assets/icons/back_button.svg',
                              width:16.w,
                              height: 12.h,
                              // ignore: deprecated_member_use
                              color: Color(0xFF363636),
                              // ignore: deprecated_member_use
                              colorBlendMode: BlendMode.modulate,
                            ),
                            // Icon(
                            //   Icons.arrow_back_ios,
                            //   color: const Color(0xFF424242),
                            //   size: 20.sp,
                            // ),
                          ),
                          Expanded(
                            child: Text(
                              'Account Information',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF424242),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 44.w), 
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
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
                                color: const Color(0xFFFFF3C4,), 
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: const Color(0xFFFFF3C4),
                                  width: 1.w,
                                ),
                              ),
                              child: Column(
                                children: [
                                  // Profile Picture
                                  Container(
                                    width: 100.w,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFFE0E0E0),
                                    ),
                                    child:viewModel.accountModel.profileImagePath !=null
                                      ? ClipOval(
                                        child: _buildProfileImage(
                                          viewModel.accountModel.profileImagePath!,
                                          ),
                                        )
                                        : const Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Color(0xFF9E9E9E),
                                          ),
                                        ),
                                      SizedBox(height: 16.h),
                                  // Name and Edit Button
                                      Row(
                                        children: [
                                          // Name (centered)
                                        Expanded(
                                          child: Center(
                                            child: viewModel.isEditing
                                              ? TextField(
                                                  controller:viewModel.nameController,
                                                  style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                      0xFF424242,
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:BorderRadius.circular(8.r,),
                                                      borderSide: BorderSide(
                                                        color: const Color(
                                                          0xFFFF8A00,
                                                        ),
                                                        width: 1.w,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                          BorderRadius.circular(8.r,),
                                                          borderSide: BorderSide(
                                                            color: const Color(
                                                              0xFFFF8A00,
                                                            ),
                                                            width: 2.w,
                                                          ),
                                                        ),
                                                        contentPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 8.h,
                                                          ),
                                                        ),
                                                      ): Text(
                                                        viewModel.accountModel.name,
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: const Color(0xFF424242,),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Edit Button (right side)
                                                  GestureDetector(
                                                    onTap: viewModel.isEditing ? viewModel.saveChanges
                                                    : () => _navigateToEditInformation(context,viewModel,),
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 16.w,
                                                        vertical: 8.h,
                                                      ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF424242),
                                                      borderRadius: BorderRadius.circular(8.r,),
                                                    ),
                                                    child: viewModel.isLoading? SizedBox(
                                                      width: 16.w,
                                                      height: 16.h,
                                                      child: const CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor:
                                                        AlwaysStoppedAnimation<Color>(Colors.white),
                                                      ),
                                                    )
                                                    : Text(
                                                        viewModel.isEditing ? 'Save' : 'Edit',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            SizedBox(height: 20.h),
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
                                                  // color: Color(0xFFFFA268),
                                                  color:Color(0xFF1B1B1B),
                                                  size: 20.sp,
                                                ),
                                              SizedBox(width: 12.w),
                                              if (viewModel.isEditing) ...[
                                              Flexible(
                                                child: TextField(
                                                  controller:viewModel.emailController,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: const Color(0xFF424242),
                                                  ),
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ] else ...[
                                          Flexible(
                                            child: Text(
                                              viewModel.accountModel.email,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: const Color(0xFF424242),
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  // Date of Birth and Location Row
                                  Row(
                                    children: [
                                      // Date of Birth
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h,),
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
                                                Icons.calendar_today_outlined,
                                                // color:Color(0xFFFFA268),
                                                color:Color(0xFF1B1B1B),
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 12.w),
                                              if (viewModel.isEditing) ...[
                                                Flexible(
                                                  child: TextField(
                                                    controller: viewModel.dateOfBirthController,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: const Color(0xFF424242,),
                                                    ),
                                                    decoration:const InputDecoration(
                                                      border:InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ] else ...[
                                                Flexible(
                                                  child: Text(
                                                    viewModel.accountModel.dateOfBirth,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: const Color(0xFF424242,),
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      // Location
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h,),
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
                                                Icons.location_city_outlined,
                                                // color: Color(0xFFFFA268),
                                                color:Color(0xFF1B1B1B),
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 12.w),
                                              if (viewModel.isEditing) ...[
                                                Flexible(
                                                  child: TextField(
                                                    controller: viewModel.locationController,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: const Color(0xFF424242,),
                                                    ),
                                                    decoration:
                                                      const InputDecoration(
                                                        border:InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ] else ...[
                                                Flexible(
                                                  child: Text(
                                                    viewModel.accountModel.location,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: const Color(0xFF424242,),
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            // Change Password Section
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3C4,), 
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1.w,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/key_icon.svg',
                                        width:14.w ,
                                        height:18.h ,
                                        // ignore: deprecated_member_use
                                        color: Color(0xFF363636), 
                                        // ignore: deprecated_member_use
                                        colorBlendMode: BlendMode.modulate,
                                      ),
                                      // Icon(
                                      //   Icons.lock,
                                      //   color: Colors.black,
                                      //   size: 24.sp,
                                      // ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Text(
                                          'Change Password',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF424242),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () =>_navigateToEditPassword(context),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h,),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF424242),
                                            borderRadius: BorderRadius.circular(8.r,),
                                          ),
                                          child: Text(
                                            'Change Password',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

  Widget _buildProfileImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(imagePath,width: 100.w,height: 100.h,
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
      // It's a local file path, use Image.file
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

  void _navigateToEditInformation(
    BuildContext context,
    AccountViewModel viewModel,
  ) async {
    final result = await AppRouter.navigateToEditInformation(
      name: viewModel.accountModel.name,
      email: viewModel.accountModel.email,
      birthDate: viewModel.accountModel.dateOfBirth,
      city: viewModel.accountModel.location,
      profileImagePath: viewModel.accountModel.profileImagePath,
    );

    // Refresh account data when returning from edit page
    if (mounted) {
      await _loadAccountData();
    }
  }

  void _navigateToEditPassword(BuildContext context) {
    AppRouter.navigateToEditPassword();
  }
}
