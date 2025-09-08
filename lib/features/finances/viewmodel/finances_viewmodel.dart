import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FinancesViewModel extends ChangeNotifier {
  // Financial summary data
  double _totalSales = 625.00;
  double _totalExpenses = 175.00;
  double _boothFees = 175.00;
  double _netProfit = 275.00;
  
  // Selected tab index
  int _selectedTabIndex = 0;
  
  // TextEditingControllers for form fields
  final TextEditingController _boothEventController = TextEditingController();
  final TextEditingController _boothDateController = TextEditingController();
  final TextEditingController _boothSizeController = TextEditingController();
  final TextEditingController _boothFeeController = TextEditingController();
  
  final TextEditingController _salesEventController = TextEditingController();
  final TextEditingController _salesDateController = TextEditingController();
  final TextEditingController _salesAmountController = TextEditingController();
  
  final TextEditingController _expensesEventController = TextEditingController();
  final TextEditingController _expensesDateController = TextEditingController();
  final TextEditingController _expensesAmountController = TextEditingController();
  
  // Monthly financial data for chart
  List<MonthlyData> _monthlyData = [
    MonthlyData(month: 'Jan', sales: 200, expenses: 150, profit: 50),
    MonthlyData(month: 'Feb', sales: 300, expenses: 200, profit: 100),
    MonthlyData(month: 'Mar', sales: 250, expenses: 180, profit: 70),
    MonthlyData(month: 'Apr', sales: 400, expenses: 250, profit: 150),
    MonthlyData(month: 'May', sales: 350, expenses: 220, profit: 130),
    MonthlyData(month: 'Jun', sales: 500, expenses: 300, profit: 200),
    MonthlyData(month: 'Jul', sales: 49.02, expenses: 47.42, profit: 1.60),
    MonthlyData(month: 'Aug', sales: 450, expenses: 280, profit: 170),
    MonthlyData(month: 'Sep', sales: 380, expenses: 240, profit: 140),
    MonthlyData(month: 'Oct', sales: 420, expenses: 260, profit: 160),
    MonthlyData(month: 'Nov', sales: 480, expenses: 290, profit: 190),
    MonthlyData(month: 'Dec', sales: 550, expenses: 320, profit: 230),
  ];
  
  // Event history data
  List<EventHistory> _eventHistory = [
    EventHistory(
      id: '1',
      title: 'Birthday Party',
      date: '01 July 2025',
      amount: 500.00,
    ),
    EventHistory(
      id: '2',
      title: 'Concert',
      date: '31 Jun 2025',
      amount: 200.00,
    ),
    EventHistory(
      id: '3',
      title: 'Conference',
      date: '30 Jun 2025',
      amount: 100.00,
    ),
    EventHistory(
      id: '4',
      title: 'Friendly Party',
      date: '29 July 2025',
      amount: 400.00,
    ),
  ];
  
  // Getters
  double get totalSales => _totalSales;
  double get totalExpenses => _totalExpenses;
  double get boothFees => _boothFees;
  double get netProfit => _netProfit;
  int get selectedTabIndex => _selectedTabIndex;
  List<MonthlyData> get monthlyData => _monthlyData;
  List<EventHistory> get eventHistory => _eventHistory;
  
  // TextEditingController getters
  TextEditingController get boothEventController => _boothEventController;
  TextEditingController get boothDateController => _boothDateController;
  TextEditingController get boothSizeController => _boothSizeController;
  TextEditingController get boothFeeController => _boothFeeController;
  
  TextEditingController get salesEventController => _salesEventController;
  TextEditingController get salesDateController => _salesDateController;
  TextEditingController get salesAmountController => _salesAmountController;
  
  TextEditingController get expensesEventController => _expensesEventController;
  TextEditingController get expensesDateController => _expensesDateController;
  TextEditingController get expensesAmountController => _expensesAmountController;
  
  // Tab selection
  void selectTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
  
  // Update financial data
  void updateTotalSales(double amount) {
    _totalSales += amount;
    _netProfit = _totalSales - _totalExpenses;
    notifyListeners();
  }
  
  void updateTotalExpenses(double amount) {
    _totalExpenses += amount;
    _netProfit = _totalSales - _totalExpenses;
    notifyListeners();
  }
  
  void updateBoothFees(double amount) {
    _boothFees += amount;
    notifyListeners();
  }
  
  // Form submission methods
  void addBoothFee() {
    if (_boothFeeController.text.isNotEmpty) {
      double amount = double.tryParse(_boothFeeController.text) ?? 0.0;
      updateBoothFees(amount);
      _clearBoothForm();
    }
  }
  
  void recordSale() {
    if (_salesAmountController.text.isNotEmpty) {
      double amount = double.tryParse(_salesAmountController.text) ?? 0.0;
      updateTotalSales(amount);
      _clearSalesForm();
    }
  }
  
  void addExpense() {
    if (_expensesAmountController.text.isNotEmpty) {
      double amount = double.tryParse(_expensesAmountController.text) ?? 0.0;
      updateTotalExpenses(amount);
      _clearExpensesForm();
    }
  }
  
  // Clear form methods
  void _clearBoothForm() {
    _boothEventController.clear();
    _boothDateController.clear();
    _boothSizeController.clear();
    _boothFeeController.clear();
  }
  
  void _clearSalesForm() {
    _salesEventController.clear();
    _salesDateController.clear();
    _salesAmountController.clear();
  }
  
  void _clearExpensesForm() {
    _expensesEventController.clear();
    _expensesDateController.clear();
    _expensesAmountController.clear();
  }
  
  // Get chart data for fl_chart
  List<FlSpot> getChartData() {
    return _monthlyData.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.sales);
    }).toList();
  }
  
  // Get highlighted month data (July)
  MonthlyData? getHighlightedMonthData() {
    return _monthlyData.firstWhere(
      (data) => data.month == 'Jul',
      orElse: () => _monthlyData[6], // Default to July (index 6)
    );
  }
  
  @override
  void dispose() {
    _boothEventController.dispose();
    _boothDateController.dispose();
    _boothSizeController.dispose();
    _boothFeeController.dispose();
    _salesEventController.dispose();
    _salesDateController.dispose();
    _salesAmountController.dispose();
    _expensesEventController.dispose();
    _expensesDateController.dispose();
    _expensesAmountController.dispose();
    super.dispose();
  }
}

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
