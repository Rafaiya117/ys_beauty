class SplashModel {
  final bool isLoading;
  final bool isReady;
  final String logoPath;
  final String backgroundImagePath;

  SplashModel({
    this.isLoading = true,
    this.isReady = false,
    this.logoPath = 'assets/app_logo/app_logo.png',
    this.backgroundImagePath = 'assets/background/background.jpg',
  });

  SplashModel copyWith({
    bool? isLoading,
    bool? isReady,
    String? logoPath,
    String? backgroundImagePath,
  }) {
    return SplashModel(
      isLoading: isLoading ?? this.isLoading,
      isReady: isReady ?? this.isReady,
      logoPath: logoPath ?? this.logoPath,
      backgroundImagePath: backgroundImagePath ?? this.backgroundImagePath,
    );
  }
}
