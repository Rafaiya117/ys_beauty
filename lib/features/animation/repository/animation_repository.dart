import '../../../shared/constants/app_constants.dart';

class AnimationRepository {
  List<String> getAnimationImages() {
    return AppConstants.animationImagePaths;
  }

  int getTotalImageCount() {
    return AppConstants.animationImagePaths.length;
  }

  Duration getImageChangeInterval() {
    return Duration(milliseconds: AppConstants.imageChangeInterval);
  }

  Duration getLastImagePauseDuration() {
    return Duration(milliseconds: AppConstants.lastImagePauseDuration);
  }

  Duration getNavigationDelay() {
    return Duration(milliseconds: AppConstants.navigationDelay);
  }
}
