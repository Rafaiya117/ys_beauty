class AppConstants {
  // Splash screen durations
  static const int splashDuration = 2000; // milliseconds (2 seconds)
  static const int fadeInDuration = 800; // milliseconds
  static const int fadeOutDuration = 500; // milliseconds
  
  // Animation durations - Faster timing for smoother experience
  static const int imageAnimationDuration = 800; // milliseconds (reduced from 1200)
  static const int imageChangeInterval = 600; // milliseconds (reduced from 1000)
  static const int lastImagePauseDuration = 500; // milliseconds (reduced from 1500)
  static const int navigationDelay = 100; // milliseconds (reduced from 300)
  static const int transitionDuration = 500; // milliseconds (reduced from 800)
  
  // Image paths
  static const List<String> animationImagePaths = [
    'assets/splash_screen_animation/1.png',
    'assets/splash_screen_animation/2.png',
    'assets/splash_screen_animation/3.png',
    'assets/splash_screen_animation/4.png',
    'assets/splash_screen_animation/5.png',
    'assets/splash_screen_animation/6.png',
    'assets/splash_screen_animation/7.png',
    'assets/splash_screen_animation/8.png',
    'assets/splash_screen_animation/9.png',
    'assets/splash_screen_animation/10.png',
    'assets/splash_screen_animation/11.png',
    'assets/splash_screen_animation/12.png',
    'assets/splash_screen_animation/13.png',
    'assets/splash_screen_animation/14.png',
    'assets/splash_screen_animation/15.png',
    'assets/splash_screen_animation/16.png',
    'assets/splash_screen_animation/17.png',
    'assets/splash_screen_animation/18.png',
    'assets/splash_screen_animation/19.png',
    'assets/splash_screen_animation/20.png',
    'assets/splash_screen_animation/21.png',
    'assets/splash_screen_animation/22.png',
  ];
  
  // App assets paths
  static const String appLogoPath = 'assets/app_logo/app_logo.png';
  static const String appLogo = 'assets/app_logo/logo.png';
  static const String backgroundImagePath = 'assets/background/background.png';
  static const String googleLogoPath = 'assets/logIn/google_logo.png';
  static const String cardBgPath = 'assets/card/card_bg.png';
  
  // Navigation icon paths
  static const String homeIconPath = 'assets/navigation_icon/home.svg';
  static const String eventsIconPath = 'assets/navigation_icon/Events.svg';
  static const String financesIconPath = 'assets/navigation_icon/Finances.svg';
  static const String settingsIconPath = 'assets/navigation_icon/Setting.svg';
  
  // UI dimensions
  static const double imageContainerSize = 200.0;
  static const double borderRadius = 20.0;
  static const double progressBarWidth = 200.0;
  static const double progressBarHeight = 4.0;
  static const double iconSize = 80.0;
  static const double largeIconSize = 100.0;
  
  // Logo dimensions
  static const double logoSize = 150.0;
  static const double logoBorderRadius = 25.0;
  
  // Spacing
  static const double largeSpacing = 30.0;
  static const double mediumSpacing = 20.0;
  static const double smallSpacing = 10.0;
  
  // Text sizes
  static const double largeTextSize = 24.0;
  static const double mediumTextSize = 16.0;
  
  // Navigation colors
  static const int selectedIconColor = 0xFFFFA066; // Selected color: FFA066
  
  // App info
  static const String appTitle = 'Animation App';
  static const String welcomeTitle = 'Welcome to Animation App';
  static const String animationCompleteText = 'Animation Complete!';
  static const String welcomeText = 'Welcome to your app';
}
