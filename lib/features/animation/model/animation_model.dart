class AnimationModel {
  final List<String> imagePaths;
  final int totalImages;
  final int currentImageIndex;

  AnimationModel({
    required this.imagePaths,
    required this.totalImages,
    this.currentImageIndex = 0,
  });

  AnimationModel copyWith({
    List<String>? imagePaths,
    int? totalImages,
    int? currentImageIndex,
  }) {
    return AnimationModel(
      imagePaths: imagePaths ?? this.imagePaths,
      totalImages: totalImages ?? this.totalImages,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
    );
  }

  bool get isLastImage => currentImageIndex == totalImages - 1;
  bool get isFirstImage => currentImageIndex == 0;
  double get progressPercentage => (currentImageIndex + 1) / totalImages;
}
