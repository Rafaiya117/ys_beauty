class EditFinancialDetailsModel {
  final String id;
  final String event;
  final String date;
  final String boothSize;
  final double boothFee;
  final double grossSales;
  final double expenses;
  final double netProfit;

  EditFinancialDetailsModel({
    required this.id,
    required this.event,
    required this.date,
    required this.boothSize,
    required this.boothFee,
    required this.grossSales,
    required this.expenses,
    required this.netProfit,
  });

  factory EditFinancialDetailsModel.fromMap(Map<String, dynamic> map) {
    return EditFinancialDetailsModel(
      id: map['id'] ?? '',
      event: map['event'] ?? '',
      date: map['date'] ?? '',
      boothSize: map['boothSize'] ?? '',
      boothFee: (map['boothFee'] ?? 0.0).toDouble(),
      grossSales: (map['grossSales'] ?? 0.0).toDouble(),
      expenses: (map['expenses'] ?? 0.0).toDouble(),
      netProfit: (map['netProfit'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'event': event,
      'date': date,
      'boothSize': boothSize,
      'boothFee': boothFee,
      'grossSales': grossSales,
      'expenses': expenses,
      'netProfit': netProfit,
    };
  }

  EditFinancialDetailsModel copyWith({
    String? id,
    String? event,
    String? date,
    String? boothSize,
    double? boothFee,
    double? grossSales,
    double? expenses,
    double? netProfit,
  }) {
    return EditFinancialDetailsModel(
      id: id ?? this.id,
      event: event ?? this.event,
      date: date ?? this.date,
      boothSize: boothSize ?? this.boothSize,
      boothFee: boothFee ?? this.boothFee,
      grossSales: grossSales ?? this.grossSales,
      expenses: expenses ?? this.expenses,
      netProfit: netProfit ?? this.netProfit,
    );
  }
}
