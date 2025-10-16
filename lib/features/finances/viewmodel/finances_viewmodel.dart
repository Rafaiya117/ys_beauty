import 'dart:convert';
import 'package:animation/core/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class FinancesViewModel extends ChangeNotifier {
  FinancesViewModel() {
    fetchFinanceSummary();
    fetchMonthlyData();
    fetchFinanceList(); // <- fetch booths as event history
  }

  double _totalSales = 0.0;
  double _totalExpenses = 0.0;
  double _boothFees = 0.0;
  double _netProfit = 0.0;

  int _selectedTabIndex = 0;
  int? _financeId;
  final _baseurl = 'http://10.10.13.36';

  // Text controllers
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

  List<MonthlyData> _monthlyData = [];

  // Event history now comes from finance list
  List<EventHistory> _eventHistory = [];
  List<EventHistory> get eventHistory => _eventHistory;

  // ---------------- Added ----------------
  final List<String> _createdBooths = [];
  List<String> get createdBooths => _createdBooths;
  // ---------------------------------------

  double get totalSales => _totalSales;
  double get totalExpenses => _totalExpenses;
  double get boothFees => _boothFees;
  double get netProfit => _netProfit;
  int get selectedTabIndex => _selectedTabIndex;
  List<MonthlyData> get monthlyData => _monthlyData;

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

  void selectTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

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

  // ---------------- addBoothFee updated ----------------
  void addBoothFee({required String name, required String boothSize}) async {
    if (_boothFeeController.text.isNotEmpty) {
      final accessToken = await TokenStorage.getAccessToken();
      double amount = double.tryParse(_boothFeeController.text) ?? 0.0;

      final Map<String, dynamic> data = {
        "name": name,
        "booth_size": boothSize,
        "booth_fee": amount,
      };

      try {
        final response = await http.post(
          Uri.parse("$_baseurl/finance/finance/create/"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: jsonEncode(data),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final result = jsonDecode(response.body);
          print("Booth added successfully: $result");

          _financeId = result['id'];
          print("✅ Booth created with ID: $_financeId");

          // Add booth name for dropdown
          _createdBooths.add(name);

          // Optional: refresh finance list to include this new booth
          await fetchFinanceList();

          updateBoothFees(amount);
          _clearBoothForm();
        } else {
          print("Failed to add booth: ${response.statusCode}");
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }
  // ------------------------------------------------------

  // ----------------- New: select Event History -----------------
  void selectEventHistory(EventHistory event) {
    _financeId = int.tryParse(event.id);

    // optional: prefill controllers
    _salesAmountController.text = event.amount.toStringAsFixed(0);
    _expensesAmountController.text = event.amount.toStringAsFixed(0);

    notifyListeners();
  }
  // ------------------------------------------------------------

  void recordSale() async {
    if (_salesAmountController.text.isNotEmpty && _financeId != null) {
      final accessToken = await TokenStorage.getAccessToken();
      double amount = double.tryParse(_salesAmountController.text) ?? 0.0;

      final Map<String, dynamic> data = {"sales": amount};

      try {
        final response = await http.post(
          Uri.parse("$_baseurl/finance/finance/$_financeId/add-sale/"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: jsonEncode(data),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final result = jsonDecode(response.body);
          print("${result['message']}");

          updateTotalSales(amount);
          _clearSalesForm();
        } else {
          print("Failed to record sale: ${response.statusCode}");
          print("Response body: ${response.body}");
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Missing finance_id or empty sales field");
    }
  }

  void addExpense() async {
    if (_expensesAmountController.text.isNotEmpty && _financeId != null) {
      final accessToken = await TokenStorage.getAccessToken();
      double amount = double.tryParse(_expensesAmountController.text) ?? 0.0;

      final Map<String, dynamic> data = {"expence": amount};

      try {
        final response = await http.post(
          Uri.parse("$_baseurl/finance/finance/$_financeId/add-expense/"),
          headers: {
            "Content-Type": "application/json",
            if (accessToken != null) "Authorization": "Bearer $accessToken",
          },
          body: jsonEncode(data),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final result = jsonDecode(response.body);
          print("✅ Expense added: $result");

          updateTotalExpenses(amount);
          _clearExpensesForm();
        } else {
          print("Failed to add expense: ${response.statusCode}");
          print("Response body: ${response.body}");
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Missing finance_id or empty expense field");
    }
  }

  Future<void> fetchFinanceSummary() async {
    try {
      final accessToken = await TokenStorage.getAccessToken();
      final response = await http.get(
        Uri.parse("$_baseurl/finance/finance/summary/yearly/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          final item = data.first;

          _totalSales = (item['total_sales'] ?? 0).toDouble();
          _totalExpenses = (item['total_expense'] ?? 0).toDouble();
          _boothFees = (item['total_booth_fee'] ?? 0).toDouble();
          _netProfit = (item['net_profit'] ?? 0).toDouble();

          notifyListeners();
        }
      } else {
        debugPrint('Failed to load finance data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching finance summary: $e');
    }
  }

  // ----------------- NEW: fetch finance list -----------------
  Future<void> fetchFinanceList() async {
    final accessToken = await TokenStorage.getAccessToken();
    try {
      final response = await http.get(
        Uri.parse("$_baseurl/finance/finance/list/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Map finance list to EventHistory
        _eventHistory = data.map((item) {
          return EventHistory(
            id: item['id'].toString(),
            title: item['name'] ?? 'Untitled Booth',
            date: item['date'] ?? '',
            amount: (item['booth_fee'] ?? 0).toDouble(),
          );
        }).toList();

        notifyListeners();
      } else {
        debugPrint("Failed to load finance list: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching finance list: $e");
    }
  }
  // ------------------------------------------------------------

  Future<void> fetchMonthlyData() async {
    String apiUrl = "$_baseurl/finance/finance/summary/monthly/";

    try {
      final accessToken = await TokenStorage.getAccessToken();
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        if (_monthlyData.isEmpty) {
          _monthlyData = [
            MonthlyData(month: 'Jan', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Feb', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Mar', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Apr', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'May', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Jun', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Jul', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Aug', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Sep', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Oct', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Nov', sales: 0, expenses: 0, profit: 0),
            MonthlyData(month: 'Dec', sales: 0, expenses: 0, profit: 0),
          ];
        }

        for (final item in jsonData) {
          final monthStr = item['month'];
          if (monthStr == null) continue;

          final monthNum = int.tryParse(monthStr.split('-').last) ?? 0;
          if (monthNum < 1 || monthNum > 12) continue;

          final monthName = _monthlyData[monthNum - 1].month;

          final updated = MonthlyData(
            month: monthName,
            sales: (item['total_sales'] ?? 0).toDouble(),
            expenses: (item['total_expense'] ?? 0).toDouble(),
            profit: (item['net_profit'] ?? 0).toDouble(),
          );
          _monthlyData[monthNum - 1] = updated;
        }

        notifyListeners();
      } else {
        debugPrint("Failed to load data: ${response.statusCode}");
        debugPrint("Response body: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error fetching monthly data: $e");
    }
  }

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

  List<FlSpot> getChartData() {
    return _monthlyData.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.sales);
    }).toList();
  }

  MonthlyData? getHighlightedMonthData() {
    final currentMonth = _monthlyData[DateTime.now().month - 1].month;
    return _monthlyData.firstWhere(
      (data) => data.month == currentMonth,
      orElse: () => _monthlyData[DateTime.now().month - 1],
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
