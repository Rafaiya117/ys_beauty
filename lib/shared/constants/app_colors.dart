import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color secondaryBlue = Color(0xFF3B82F6);
  static const Color darkBlue = Color(0xFF1E40AF);
  
  // Background gradients
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryBlue,
      secondaryBlue,
      darkBlue,
    ],
  );
  
  static const LinearGradient mainScreenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryBlue,
      secondaryBlue,
    ],
  );
  
  // Text colors
  static const Color whiteText = Colors.white;
  static const Color whiteText70 = Colors.white70;
  
  // Container colors
  static const Color semiTransparentWhite = Color(0x33FFFFFF); // 20% opacity
  static const Color semiTransparentWhite30 = Color(0x4DFFFFFF); // 30% opacity
}
