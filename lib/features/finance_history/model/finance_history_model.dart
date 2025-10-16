class FinanceHistoryModel {
  final String id;
  final String eventName;
  final String date;
  final double amount;
  final String type; // 'sale', 'expense', 'booth_fee'
  final String description;

  FinanceHistoryModel({
    required this.id,
    required this.eventName,
    required this.date,
    required this.amount,
    required this.type,
    required this.description,
  });

  factory FinanceHistoryModel.fromJson(Map<String, dynamic> json) {
  return FinanceHistoryModel(
    id: json['id']?.toString() ?? '',
    eventName: json['name'] ?? json['name'] ?? '',
    date: json['date'] ?? '',
    amount: (json['booth_fee'] ?? 0).toDouble(),
    type: json['type'] ?? '',
    description: json['description'] ?? '',
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': eventName,
      'date': date,
      'booth_fee': amount,
      'type': type,
      'description': description,
    };
  }
}
