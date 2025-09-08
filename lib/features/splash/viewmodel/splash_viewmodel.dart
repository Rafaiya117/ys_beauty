import 'dart:async';
import 'package:flutter/material.dart';
import '../model/splash_model.dart';
import '../repository/splash_repository.dart';
import '../../../core/router.dart';

class SplashViewModel extends ChangeNotifier {
  final SplashRepository _repository = SplashRepository();
  
  late SplashModel _splashModel;
  Timer? _timer;

  // Constructor - initialize data immediately
  SplashViewModel() {
    _initializeData();
  }

  // Getters
  SplashModel get splashModel => _splashModel;
  bool get isLoading => _splashModel.isLoading;
  bool get isReady => _splashModel.isReady;
  String get logoPath => _splashModel.logoPath;
  String get backgroundImagePath => _splashModel.backgroundImagePath;

  void _initializeData() {
    final logoPath = _repository.getLogoPath();
    final backgroundImagePath = _repository.getBackgroundImagePath();
    print('SplashViewModel: Logo path: $logoPath');
    print('SplashViewModel: Background path: $backgroundImagePath');
    
    _splashModel = SplashModel(
      isLoading: false, // Show logo and text immediately
      isReady: false,
      logoPath: logoPath,
      backgroundImagePath: backgroundImagePath,
    );
    notifyListeners();
    
    // Start the splash sequence
    _startSplashSequence();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSplashSequence() {
    // Wait for splash duration then navigate to animation
    _timer = Timer(
      _repository.getSplashDuration(),
      () {
        _navigateToAnimation();
      },
    );
  }

  void _navigateToAnimation() {
    _splashModel = _splashModel.copyWith(
      isLoading: false,
      isReady: true,
    );
    notifyListeners();

    // Navigate to animation page
    AppRouter.navigateToAnimation();
  }

  void resetSplash() {
    _splashModel = SplashModel(
      isLoading: true,
      isReady: false,
      logoPath: _repository.getLogoPath(),
    );
    _timer?.cancel();
    notifyListeners();
  }
}
