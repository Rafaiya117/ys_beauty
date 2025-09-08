class FeedbackModel {
  final String id;
  final String feedback;
  final String email;
  final DateTime createdAt;
  final String status;

  FeedbackModel({
    required this.id,
    required this.feedback,
    required this.email,
    required this.createdAt,
    required this.status,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'] ?? '',
      feedback: map['feedback'] ?? '',
      email: map['email'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      status: map['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'feedback': feedback,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }

  FeedbackModel copyWith({
    String? id,
    String? feedback,
    String? email,
    DateTime? createdAt,
    String? status,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      feedback: feedback ?? this.feedback,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
