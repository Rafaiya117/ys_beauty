import '../../../shared/constants/app_constants.dart';

class SplashRepository {
  String getLogoPath() {
    return 'assets/app_logo/app_logo.png';
  }

  String getBackgroundImagePath() {
    return AppConstants.backgroundImagePath;
  }

  Duration getSplashDuration() {
    return Duration(milliseconds: AppConstants.splashDuration);
  }

  Duration getFadeInDuration() {
    return Duration(milliseconds: AppConstants.fadeInDuration);
  }

  Duration getFadeOutDuration() {
    return Duration(milliseconds: AppConstants.fadeOutDuration);
  }
}
