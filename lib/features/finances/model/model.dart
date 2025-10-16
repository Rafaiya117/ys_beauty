class MonthlyData {
  final String month;
  final double sales;
  final double expenses;
  final double profit;

  MonthlyData({
    required this.month,
    required this.sales,
    required this.expenses,
    required this.profit,
  });
}

class EventHistory {
  final String id;
  final String title;
  final String date;
  final double amount;

  EventHistory({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
  });
}
