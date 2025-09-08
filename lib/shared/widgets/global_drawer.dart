import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_constants.dart';
import '../../core/router.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFF8E1), // Light yellow background
      child: SafeArea(
        child: Column(
          children: [
            // Close button
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Menu title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 32.h),
            
            // Menu items
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  _buildMenuItem(
                    icon: Icons.home_outlined,
                    title: 'Home',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        AppRouter.navigateToMain(initialIndex: 0);
                      });
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'Booking Calendar',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        AppRouter.navigateToCreateEvent();
                      });
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.alarm_outlined,
                    title: 'Reminders',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        AppRouter.navigateToReminders();
                      });
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.attach_money_outlined,
                    title: 'Finances',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        AppRouter.navigateToMain(initialIndex: 2);
                      });
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.history_outlined,
                    title: 'Booking History',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        AppRouter.navigateToMain(initialIndex: 1);
                      });
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.feedback_outlined,
                    title: 'Feedback',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        AppRouter.navigateToFeedback();
                      });
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        AppRouter.navigateToMain(initialIndex: 3);
                      });
                    },
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8.h),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showDivider)
          Container(
            height: 1.h,
            color: Colors.black,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
          ),
      ],
    );
  }
}
