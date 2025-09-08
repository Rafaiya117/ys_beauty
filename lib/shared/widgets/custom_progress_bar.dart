import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color progressColor;

  const CustomProgressBar({
    super.key,
    required this.progress,
    this.width = 200.0,
    this.height = 4.0,
    this.backgroundColor = AppColors.primaryBlue,
    this.progressColor = AppColors.primaryBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
