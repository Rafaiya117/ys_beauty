class PrivacyPolicyModel {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final String content;

  const PrivacyPolicyModel({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.content = '',
  });

  PrivacyPolicyModel copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    String? content,
  }) {
    return PrivacyPolicyModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      content: content ?? this.content,
    );
  }
}
