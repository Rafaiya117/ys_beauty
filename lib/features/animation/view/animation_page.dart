import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodel/animation_viewmodel.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../shared/utils/greeting_utils.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnimationViewModel(),
      child: Consumer<AnimationViewModel>(
        builder: (context, viewModel, child) {
          // Start animation after the ViewModel is created and available
          if (viewModel.totalImages > 0 && !viewModel.animationStarted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!viewModel.animationStarted) {
                viewModel.startImageAnimation();
              }
            });
          }

          // Show loading if images are not loaded yet
          if (viewModel.totalImages == 0) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.backgroundImagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image container with smooth transitions
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          key: ValueKey(viewModel.currentImageIndex),
                          width: AppConstants.imageContainerSize.w,
                          height: AppConstants.imageContainerSize.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadius.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadius.r),
                            child: Image.asset(
                              viewModel.currentImagePath,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                                  child: Icon(
                                    Icons.image,
                                    size: AppConstants.iconSize.sp,
                                    color: AppColors.primaryBlue,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppConstants.largeSpacing.h),
                      
                      // First text line - "Good morning"
                        Text(
                          GreetingUtils.getGreeting(),
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      SizedBox(height: AppConstants.smallSpacing.h),
                      // Second text line - "Crafty by Gigi"
                      Text(
                        'Crafty by Gigi',
                        style: GoogleFonts.greatVibes(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.2,
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
}
