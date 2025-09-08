import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/settings_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
      child: Consumer<SettingsViewModel>(
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
                      child: Text(
                        'Setting',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF424242),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    // Settings list
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            // Account Information
                            _buildSettingItem(
                              icon: Icons.person,
                              title: 'Account Information',
                              onTap: viewModel.navigateToAccountInformation,
                              showArrow: true,
                            ),
                            
                            SizedBox(height: 8.h),
                            
                            // Notifications & Reminders
                            _buildSettingItem(
                              icon: Icons.notifications,
                              title: 'Notifications & Reminders',
                              onTap: null,
                              showArrow: false,
                              showToggle: true,
                              toggleValue: viewModel.isNotificationsEnabled,
                              onToggle: viewModel.toggleNotifications,
                            ),
                            
                            SizedBox(height: 8.h),
                            
                            // Help & Support
                            _buildSettingItem(
                              icon: Icons.help,
                              title: 'Help & Support',
                              onTap: viewModel.navigateToHelpSupport,
                              showArrow: true,
                            ),
                            
                            SizedBox(height: 8.h),
                            
                            // Terms & Condition
                            _buildSettingItem(
                              icon: Icons.description,
                              title: 'Terms & Condition',
                              onTap: viewModel.navigateToTermsConditions,
                              showArrow: true,
                            ),
                            
                            SizedBox(height: 8.h),
                            
                            // Privacy Policy
                            _buildSettingItem(
                              icon: Icons.privacy_tip,
                              title: 'Privacy Policy',
                              onTap: viewModel.navigateToPrivacyPolicy,
                              showArrow: true,
                            ),
                            
                            SizedBox(height: 8.h),
                            
                            // Log Out
                            _buildSettingItem(
                              icon: Icons.logout,
                              title: 'Log Out',
                              onTap: () => viewModel.showLogOutDialog(context),
                              showArrow: true,
                              isLoading: viewModel.isLoading,
                            ),
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

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback? onTap,
    required bool showArrow,
    bool showToggle = false,
    bool toggleValue = false,
    VoidCallback? onToggle,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3C4), // Light yellow background
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: const Color(0xFFFF8A00).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(
                icon,
                size: 18.sp,
                color: const Color(0xFFFF8A00),
              ),
            ),
            
            SizedBox(width: 16.w),
            
            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF424242),
                ),
              ),
            ),
            
            // Toggle or Arrow
            if (showToggle) ...[
              Switch(
                value: toggleValue,
                onChanged: isLoading ? null : (value) => onToggle?.call(),
                activeColor: const Color(0xFFFF8A00),
                inactiveThumbColor: const Color(0xFF9E9E9E),
                inactiveTrackColor: const Color(0xFFE0E0E0),
              ),
            ] else if (showArrow) ...[
              if (isLoading) ...[
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8A00)),
                  ),
                ),
              ] else ...[
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: const Color(0xFFFF8A00),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
