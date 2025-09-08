import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/splash_viewmodel.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
      child: Consumer<SplashViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(viewModel.backgroundImagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  
                  // Center content - Only logo
                  Center(
                    child: Container(
                      width: AppConstants.logoSize,
                      height: AppConstants.logoSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.logoBorderRadius),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppConstants.logoBorderRadius),
                        child: Image.asset(
                          viewModel.logoPath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            print('SplashPage: Image error for ${viewModel.logoPath}: $error');
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(AppConstants.logoBorderRadius),
                              ),
                              child: Icon(
                                Icons.image,
                                size: AppConstants.logoSize * 0.6,
                                color: AppColors.primaryBlue,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}