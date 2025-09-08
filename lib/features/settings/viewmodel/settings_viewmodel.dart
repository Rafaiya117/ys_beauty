import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/settings_model.dart';
import '../../../core/router.dart';

class SettingsViewModel extends ChangeNotifier {
  late SettingsModel _settingsModel;

  // Constructor - initialize data immediately
  SettingsViewModel() {
    _initializeData();
  }

  // Getters
  SettingsModel get settingsModel => _settingsModel;
  bool get isNotificationsEnabled => _settingsModel.isNotificationsEnabled;
  bool get isLoading => _settingsModel.isLoading;
  String? get errorMessage => _settingsModel.errorMessage;
  String? get successMessage => _settingsModel.successMessage;

  void _initializeData() {
    _settingsModel = const SettingsModel();
    notifyListeners();
  }

  // Toggle notifications
  void toggleNotifications() {
    _settingsModel = _settingsModel.copyWith(
      isNotificationsEnabled: !_settingsModel.isNotificationsEnabled,
    );
    notifyListeners();
  }

  // Navigate to account information
  void navigateToAccountInformation() {
    AppRouter.navigateToAccountInformation();
  }

  // Navigate to help & support
  void navigateToHelpSupport() {
    AppRouter.navigateToHelpSupport();
  }

  // Navigate to terms & conditions
  void navigateToTermsConditions() {
    AppRouter.navigateToTermsCondition();
  }

  // Navigate to privacy policy
  void navigateToPrivacyPolicy() {
    AppRouter.navigateToPrivacyPolicy();
  }

  // Show log out confirmation dialog
  void showLogOutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _buildLogOutDialog(context);
      },
    );
  }

  // Build log out confirmation dialog
  Widget _buildLogOutDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300.w,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF404040),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 16.h),
            
            // Confirmation message
            Text(
              'Are you sure you want to log out of your account?',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 24.h),
            
            // Action buttons
            Row(
              children: [
                // Cancel button
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(width: 12.w),
                
                // Log out button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _performLogOut();
                    },
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF8A00), Color(0xFFFFC107)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Perform actual logout
  void _performLogOut() {
    _settingsModel = _settingsModel.copyWith(isLoading: true);
    notifyListeners();

    // Simulate logout process
    Future.delayed(const Duration(seconds: 2), () {
      _settingsModel = _settingsModel.copyWith(
        isLoading: false,
        successMessage: 'Logged out successfully!',
      );
      notifyListeners();
      
      // Clear success message after 3 seconds and navigate to auth
      Future.delayed(const Duration(seconds: 3), () {
        clearSuccess();
        // Navigate to auth page
        AppRouter.navigateToAuth();
      });
    });
  }

  // Show coming soon message
  void _showComingSoonMessage(String feature) {
    _settingsModel = _settingsModel.copyWith(
      successMessage: '$feature feature coming soon!',
    );
    notifyListeners();
    
    // Clear message after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      clearSuccess();
    });
  }

  // Clear error message
  void clearError() {
    if (_settingsModel.errorMessage != null) {
      _settingsModel = _settingsModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_settingsModel.successMessage != null) {
      _settingsModel = _settingsModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }
}
