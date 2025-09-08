class TermsConditionModel {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final String content;

  const TermsConditionModel({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.content = '',
  });

  TermsConditionModel copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    String? content,
  }) {
    return TermsConditionModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      content: content ?? this.content,
    );
  }
}
