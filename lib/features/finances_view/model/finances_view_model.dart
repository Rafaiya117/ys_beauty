import 'package:animation/features/finances_view/viewmodel/finances_view_viewmodel.dart';

class FinancesViewModel {
  final String id;
  final String eventName;
  final String date;
  final double eventSales;
  final double eventExpenses;
  final double netProfit;
  final double boothFee;
  final String boothSize;
  final List<SalesEvent> salesList;
  final List<ExpenseEvent> expenseList;

  FinancesViewModel({
    required this.id,
    required this.eventName,
    required this.date,
    required this.eventSales,
    required this.eventExpenses,
    required this.netProfit,
    required this.boothFee,
    required this.boothSize,
    required this.salesList,
    required this.expenseList,
  });

  factory FinancesViewModel.fromJson(Map<String, dynamic> json) {
    return FinancesViewModel(
      id: json['id'].toString(),
      eventName: json['name'],
      date: json['date'],
      boothSize: json['booth_size'],
      boothFee: (json['booth_fee'] as num).toDouble(),
      salesList: (json['sales_list'] as List)
          .map((e) => SalesEvent.fromJson(e))
          .toList(),
      expenseList: (json['expence_list'] as List)
          .map((e) => ExpenseEvent.fromJson(e))
          .toList(),
      eventSales: (json['sales_list'] as List)
          .fold(0.0, (sum, e) => sum + (e['sales'] as num).toDouble()),
      eventExpenses: (json['expence_list'] as List)
          .fold(0.0, (sum, e) => sum + (e['expence'] as num).toDouble()),
      netProfit: (json['sales_list'] as List)
              .fold(0.0, (sum, e) => sum + (e['sales'] as num).toDouble()) -
          (json['expence_list'] as List)
              .fold(0.0, (sum, e) => sum + (e['expence'] as num).toDouble()) -
          (json['booth_fee'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": eventName,
      "date": date,
      "booth_size": boothSize,
      "booth_fee": boothFee,
      "sales_list": salesList.map((e) => e.toJson()).toList(),
      "expence_list": expenseList.map((e) => e.toJson()).toList(),
    };
  }

  FinancesViewModel copyWith({
    String? id,
    String? eventName,
    String? date,
    double? eventSales,
    double? eventExpenses,
    double? netProfit,
    double? boothFee,
    String? boothSize,
    List<SalesEvent>? salesList,
    List<ExpenseEvent>? expenseList,
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
      salesList: salesList ?? this.salesList,
      expenseList: expenseList ?? this.expenseList,
    );
  }
}

