import 'dart:async';
import 'package:flutter/material.dart';
import '../model/animation_model.dart';
import '../repository/animation_repository.dart';
import '../../../core/router.dart';

class AnimationViewModel extends ChangeNotifier {
  final AnimationRepository _repository = AnimationRepository();
  
  late AnimationModel _animationModel;
  Timer? _timer;
  bool _isNavigating = false;
  bool _animationStarted = false;

  // Constructor - initialize data immediately
  AnimationViewModel() {
    _initializeData();
  }

  // Getters
  AnimationModel get animationModel => _animationModel;
  bool get isNavigating => _isNavigating;
  bool get animationStarted => _animationStarted;
  String get currentImagePath => _animationModel.imagePaths.isNotEmpty 
      ? _animationModel.imagePaths[_animationModel.currentImageIndex] 
      : '';
  int get currentImageIndex => _animationModel.currentImageIndex;
  int get totalImages => _animationModel.totalImages;
  double get progressPercentage => _animationModel.progressPercentage;
  bool get isLastImage => _animationModel.isLastImage;

  void _initializeData() {
    final images = _repository.getAnimationImages();
    final totalCount = _repository.getTotalImageCount();
    
    _animationModel = AnimationModel(
      imagePaths: images,
      totalImages: totalCount,
      currentImageIndex: 0, // Start from first image
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startImageAnimation() {
    if (_animationStarted) return; // Prevent multiple starts
    
    _animationStarted = true;
    
    // Cancel any existing timer
    _timer?.cancel();
    
    // Start with first image (index 0)
    _animationModel = _animationModel.copyWith(currentImageIndex: 0);
    notifyListeners();
    
    _timer = Timer.periodic(
      _repository.getImageChangeInterval(),
      (timer) {
        if (!_animationModel.isLastImage) {
          _nextImage();
        } else {
          timer.cancel();
          _handleLastImage();
        }
      },
    );
  }

  void _nextImage() {
    final nextIndex = _animationModel.currentImageIndex + 1;
    if (nextIndex < _animationModel.totalImages) {
      _animationModel = _animationModel.copyWith(
        currentImageIndex: nextIndex,
      );
      notifyListeners();
    }
  }

  void _handleLastImage() {
    Future.delayed(
      _repository.getLastImagePauseDuration(),
      () {
        if (!_isNavigating) {
          _navigateToMainScreen();
        }
      },
    );
  }

  void _navigateToMainScreen() {
    if (_isNavigating) return;
    
    _isNavigating = true;
    notifyListeners();

    Future.delayed(
      _repository.getNavigationDelay(),
      () {
        AppRouter.navigateToAuth();
      },
    );
  }

  void resetAnimation() {
    _animationModel = AnimationModel(
      imagePaths: _repository.getAnimationImages(),
      totalImages: _repository.getTotalImageCount(),
      currentImageIndex: 0,
    );
    _isNavigating = false;
    _animationStarted = false;
    _timer?.cancel();
    notifyListeners();
  }
}
