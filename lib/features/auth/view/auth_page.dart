import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/constants/app_constants.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: Consumer<AuthViewModel>(
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo section
                    Container(
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
                    
                    const SizedBox(height: 60),
                    
                    // Buttons section
                    Container(
                      width: 280,
                      child: Column(
                        children: [
                          // Log In Button
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF8A00), // Orange
                                  Color(0xFFFFD700), // Yellow
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25),
                                onTap: (viewModel.isLoginLoading || viewModel.isSignUpLoading) ? null : viewModel.navigateToLogin,
                                child: Center(
                                  child: viewModel.isLoginLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : const Text(
                                          'Log In',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: AppConstants.mediumSpacing),
                          
                          // Sign Up Button
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF424242), // Dark gray
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25),
                                onTap: (viewModel.isLoginLoading || viewModel.isSignUpLoading) ? null : viewModel.navigateToSignUp,
                                child: Center(
                                  child: viewModel.isSignUpLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Error message
                    if (viewModel.errorMessage != null) ...[
                      SizedBox(height: AppConstants.mediumSpacing),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          viewModel.errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
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
}
