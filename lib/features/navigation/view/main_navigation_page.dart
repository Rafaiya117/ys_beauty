import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../viewmodel/navigation_viewmodel.dart';
import '../../home/view/home_page.dart';
import '../../events/view/events_page.dart';
import '../../finances/view/finances_page.dart';
import '../../settings/view/settings_page.dart';
import '../../../core/router.dart';
import '../../../shared/constants/app_constants.dart';

class MainNavigationPage extends StatelessWidget {
  final int initialIndex;

  const MainNavigationPage({super.key, this.initialIndex = 0});

  final List<Widget> _pages = const [
    HomePage(),
    EventsPage(),
    FinancesPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationViewModel(initialIndex: initialIndex),
      child: Consumer<NavigationViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: _pages[viewModel.currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFBECBD), // Light yellow background
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8.r,
                    offset: Offset(0, -2.h),
                  ),
                ],
              ),
              child: SafeArea(
                child: Container(
                  height:
                      70.h, // Increased height to accommodate floating button
                  padding: EdgeInsets.only(
                    left: 15.w,
                    right: 15.w,
                    top: 10.h,
                    // bottom: 0.h, // Reduced bottom padding
                  ),
                  child: Stack(
                    clipBehavior:
                        Clip.none, // Allow overflow for floating button
                    children: [
                      // Navigation items row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem(
                            context: context,
                            viewModel: viewModel,
                            iconPath: AppConstants.homeIconPath,
                            label: 'Home',
                            index: 0,
                            isActive: viewModel.currentIndex == 0,
                          ),
                          _buildNavItem(
                            context: context,
                            viewModel: viewModel,
                            iconPath: AppConstants.eventsIconPath,
                            label: 'Events',
                            index: 1,
                            isActive: viewModel.currentIndex == 1,
                          ),
                          // Empty space for floating button
                          SizedBox(width: 64.w),
                          _buildNavItem(
                            context: context,
                            viewModel: viewModel,
                            iconPath: AppConstants.financesIconPath,
                            label: 'Finances',
                            index: 2,
                            isActive: viewModel.currentIndex == 2,
                          ),
                          _buildNavItem(
                            context: context,
                            viewModel: viewModel,
                            iconPath: AppConstants.settingsIconPath,
                            label: 'Setting',
                            index: 3,
                            isActive: viewModel.currentIndex == 3,
                          ),
                        ],
                      ),
                      // Custom floating button positioned in center
                      Positioned(
                        left: 0,
                        right: 0,
                        top: -30.h,
                        child: Center(
                          child: _buildFloatingButton(context, viewModel),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required NavigationViewModel viewModel,
    required String iconPath,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        viewModel.changeTab(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 2.h,
        ), // Further reduced padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 22.w,
              height: 22.h,
              colorFilter: isActive
                  ? ColorFilter.mode(
                      const Color(
                        AppConstants.selectedIconColor,
                      ), // FFA066 for active
                      BlendMode.srcIn,
                    )
                  : null, // Use default SVG color for inactive
            ),
            SizedBox(height: 1.h), // Minimal spacing
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp, // Further reduced font size
                fontWeight: FontWeight.w500,
                color: isActive
                    ? const Color(
                        AppConstants.selectedIconColor,
                      ) // FFA066 for active
                    : const Color(0xFF010101,), // 010101 for inactive (hardcoded since it's the default)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingButton(
    BuildContext context,
    NavigationViewModel viewModel,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('✅ Custom floating button tapped successfully!');
          try {
            AppRouter.navigateToCreateEvent();
            print('✅ Navigation to CreateEvent initiated');
          } catch (e) {
            print('❌ Navigation error: $e');
          }
        },
        borderRadius: BorderRadius.circular(32.r),
        child: Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            color:Color(0xFF1B1B1B),//Colors.black, //const Color(0xFFFFA066), 
            shape: BoxShape.circle,
            // boxShadow: [
            //   BoxShadow(
            //     color: const Color(0xFFFF8A00).withValues(alpha: 0.4),
            //     blurRadius: 12.r,
            //     offset: Offset(0, 6.h),
            //   ),
            // ],
          ),
          child: Icon(Icons.add, size: 28.sp, color: Colors.white),
        ),
      ),
    );
  }

  void _showAddNewOptions(BuildContext context, NavigationViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Text(
                    'Add New',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF424242),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildAddOption(
                    icon: Icons.event,
                    title: 'New Event',
                    subtitle: 'Create a new event',
                    onTap: () {
                      Navigator.pop(context);
                      AppRouter.navigateToCreateEvent();
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildAddOption(
                    icon: Icons.account_balance_wallet,
                    title: 'New Transaction',
                    subtitle: 'Add a new transaction',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to create transaction
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildAddOption(
                    icon: Icons.note_add,
                    title: 'New Note',
                    subtitle: 'Create a new note',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to create note
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: const Color(0xFFFF8A00).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(icon, size: 20.sp, color: const Color(0xFFFF8A00)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF424242),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: const Color(0xFF757575),
            ),
          ],
        ),
      ),
    );
  }
}
