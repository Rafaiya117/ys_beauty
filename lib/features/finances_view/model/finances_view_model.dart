class FinancesViewModel {
  final String id;
  final String eventName;
  final String date;
  final String boothSize;
  final double boothFee;
  final double eventSales;
  final double eventExpenses;
  final double netProfit;

  FinancesViewModel({
    required this.id,
    required this.eventName,
    required this.date,
    required this.boothSize,
    required this.boothFee,
    required this.eventSales,
    required this.eventExpenses,
    required this.netProfit,
  });

  factory FinancesViewModel.fromJson(Map<String, dynamic> json) {
    return FinancesViewModel(
      id: json['id'] ?? '',
      eventName: json['eventName'] ?? '',
      date: json['date'] ?? '',
      boothSize: json['boothSize'] ?? '',
      boothFee: (json['boothFee'] ?? 0.0).toDouble(),
      eventSales: (json['eventSales'] ?? 0.0).toDouble(),
      eventExpenses: (json['eventExpenses'] ?? 0.0).toDouble(),
      netProfit: (json['netProfit'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventName': eventName,
      'date': date,
      'boothSize': boothSize,
      'boothFee': boothFee,
      'eventSales': eventSales,
      'eventExpenses': eventExpenses,
      'netProfit': netProfit,
    };
  }
}
