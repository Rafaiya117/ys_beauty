class SupportRequestModel {
  final int id;
  final String email;
  final String description;
  final DateTime? createdAt;

  const SupportRequestModel({
    required this.id,
    required this.email,
    required this.description,
    this.createdAt,
  });

  // Factory constructor to create SupportRequestModel from API response
  factory SupportRequestModel.fromJson(Map<String, dynamic> json) {
    return SupportRequestModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  // Convert SupportRequestModel to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'description': description,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SupportRequestModel(id: $id, email: $email, description: $description, createdAt: $createdAt)';
  }
}
