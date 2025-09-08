class HomeModel {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const HomeModel({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  HomeModel copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return HomeModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}
