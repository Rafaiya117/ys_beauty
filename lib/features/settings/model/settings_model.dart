class SettingsModel {
  final bool isNotificationsEnabled;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const SettingsModel({
    this.isNotificationsEnabled = true,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  SettingsModel copyWith({
    bool? isNotificationsEnabled,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return SettingsModel(
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}
