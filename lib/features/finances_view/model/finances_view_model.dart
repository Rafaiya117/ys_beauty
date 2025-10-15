class FinancesViewModel {
  final String id;
  final String eventName;
  final String date;
  final double eventSales;
  final double eventExpenses;
  final double netProfit;
  final double boothFee;
  final String boothSize;

  FinancesViewModel({
    required this.id,
    required this.eventName,
    required this.date,
    required this.eventSales,
    required this.eventExpenses,
    required this.netProfit,
    required this.boothFee,
    required this.boothSize,
  });

  // ------------------- CopyWith -------------------
  FinancesViewModel copyWith({
    String? id,
    String? eventName,
    String? date,
    double? eventSales,
    double? eventExpenses,
    double? netProfit,
    double? boothFee,
    String? boothSize,
  }) {
    return FinancesViewModel(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      date: date ?? this.date,
      eventSales: eventSales ?? this.eventSales,
      eventExpenses: eventExpenses ?? this.eventExpenses,
      netProfit: netProfit ?? this.netProfit,
      boothFee: boothFee ?? this.boothFee,
      boothSize: boothSize ?? this.boothSize,
    );
  }

  // ------------------- To JSON -------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_name': eventName,
      'date': date,
      'sales': eventSales,
      'expenses': eventExpenses,
      'net_profit': netProfit,
      'booth_fee': boothFee,
      'booth_size': boothSize,
    };
  }

  // ------------------- From JSON -------------------
  factory FinancesViewModel.fromJson(Map<String, dynamic> json) {
    return FinancesViewModel(
      id: json['id'].toString(),
      eventName: json['event_name'] ?? '',
      date: json['date'] ?? '',
      eventSales: (json['sales'] ?? 0).toDouble(),
      eventExpenses: (json['expenses'] ?? 0).toDouble(),
      netProfit: (json['net_profit'] ?? 0).toDouble(),
      boothFee: (json['booth_fee'] ?? 0).toDouble(),
      boothSize: json['booth_size'] ?? '',
    );
  }
}
