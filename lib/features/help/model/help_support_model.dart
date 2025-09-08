class HelpSupportModel {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final List<HelpItem> helpItems;
  final List<ContactMethod> contactMethods;

  const HelpSupportModel({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.helpItems = const [],
    this.contactMethods = const [],
  });

  HelpSupportModel copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    List<HelpItem>? helpItems,
    List<ContactMethod>? contactMethods,
  }) {
    return HelpSupportModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      helpItems: helpItems ?? this.helpItems,
      contactMethods: contactMethods ?? this.contactMethods,
    );
  }
}

class HelpItem {
  final String title;
  final String description;
  final String icon;
  final String? route;

  const HelpItem({
    required this.title,
    required this.description,
    required this.icon,
    this.route,
  });
}

class ContactMethod {
  final String title;
  final String description;
  final String icon;
  final String action;

  const ContactMethod({
    required this.title,
    required this.description,
    required this.icon,
    required this.action,
  });
}
