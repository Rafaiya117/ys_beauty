import 'dart:convert';
import 'package:animation/core/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/finances_view_model.dart';

class FinancesViewViewModel extends ChangeNotifier {
  FinancesViewModel? _financesData;
  bool _isLoading = false;
  String? _error;
  final _baseurl = 'http://10.10.13.36';

  // Editable sales and expenses events
  List<SalesEvent> _salesEvents = [];
  List<SalesEvent> get salesEvents => _salesEvents;
  
  List<SalesEvent> _expensesEvents = [];
  List<SalesEvent> get expensesEvents => _expensesEvents;

  // Getters
  FinancesViewModel? get financesData => _financesData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // --------------------- Load finance data ---------------------
  Future<void> loadFinancesView(String id) async {
  _setLoading(true);
  _clearError();

  try {
    final accessToken = await TokenStorage.getAccessToken();
    debugPrint('!-------------$id');
    final response = await http.get(
      Uri.parse("$_baseurl/event/events/$id/"),
      headers: {
        'Content-Type': 'application/json',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      _financesData = FinancesViewModel(
        id: data['id'].toString(),
        eventName: data['event_name'] ?? '',
        date: data['date'] ?? '',
        eventSales: (data['sales'] ?? 0).toDouble(),
        eventExpenses: (data['expenses'] ?? 0).toDouble(),
        netProfit: (data['net_profit'] ?? 0).toDouble(),
        boothFee: (data['booth_fee'] ?? 0).toDouble(), 
        boothSize: (data['booth_size'] ?? ''),
      );

      // Populate Sales & Expenses for all booths under the event
      _salesEvents = (data['booths'] as List<dynamic>? ?? []).expand((booth) {
        final boothId = booth['id'].toString();
        final boothName = booth['name'] ?? '';
        final salesList = (booth['sales'] as List<dynamic>? ?? []);
        return salesList.map((sale) => SalesEvent(
          id: sale['id'].toString(),
          boothId: boothId,
          title: "$boothName - ${sale['title'] ?? 'Sale'}",
          date: sale['date'] ?? '',
          amount: '\$${(sale['amount'] ?? 0).toStringAsFixed(0)}',
        ));
      }).toList();

      _expensesEvents = (data['booths'] as List<dynamic>? ?? []).expand((booth) {
        final boothId = booth['id'].toString();
        final boothName = booth['name'] ?? '';
        final expensesList = (booth['expenses'] as List<dynamic>? ?? []);
        return expensesList.map((expense) => SalesEvent(
          id: expense['id'].toString(),
          boothId: boothId,
          title: "$boothName - ${expense['title'] ?? 'Expense'}",
          date: expense['date'] ?? '',
          amount: '\$${(expense['amount'] ?? 0).toStringAsFixed(0)}',
        ));
      }).toList();

    } else {
      _setError('Failed to load finance data: ${response.statusCode}');
    }

    notifyListeners();
  } catch (e) {
    _setError('Failed to load finance details: $e');
  } finally {
    _setLoading(false);
  }
}

  // --------------------- Update Sales & Expenses ---------------------
  Future<void> updateSalesEvent(int index, SalesEvent updatedEvent) async {
    if (index >= 0 && index < _salesEvents.length) {
      _salesEvents[index] = updatedEvent;
      notifyListeners();

      await _putSalesEvent(updatedEvent); // Call API
      await loadFinancesView(_financesData!.id); // Refresh
    }
  }

  Future<void> updateExpenseEvent(int index, SalesEvent updatedEvent) async {
    if (index >= 0 && index < _expensesEvents.length) {
      _expensesEvents[index] = updatedEvent;
      notifyListeners();

      await _putExpenseEvent(updatedEvent); // Call API
      await loadFinancesView(_financesData!.id); // Refresh
    }
  }

  // --------------------- Private API helpers ---------------------
Future<void> _putSalesEvent(SalesEvent event) async {
  final accessToken = await TokenStorage.getAccessToken();
  final amount = double.tryParse(event.amount.replaceAll('\$', '')) ?? 0;

  try {
    final response = await http.put(
      Uri.parse("$_baseurl/finance/finance/edit/sales/${event.id}/"),
      headers: {
        "Content-Type": "application/json",
        if (accessToken != null) "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({"sales": amount}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // update local _financesData to reflect change
      _financesData = _financesData!.copyWith(
        eventSales: _salesEvents.fold<double>(0,(sum, e) => sum + double.tryParse(e.amount.replaceAll('\$', ''))!,
        ),
        netProfit: _salesEvents.fold<double>(0,(sum, e) => sum + double.tryParse(e.amount.replaceAll('\$', ''))!,) - _financesData!.eventExpenses,
      );
      notifyListeners();
    } else {
      print("Failed to update sale: ${response.statusCode}");
    }
  } catch (e) {
    print("Error updating sale: $e");
  }
}

Future<void> _putExpenseEvent(SalesEvent event) async {
  final accessToken = await TokenStorage.getAccessToken();
  final amount = double.tryParse(event.amount.replaceAll('\$', '')) ?? 0;

  try {
    final response = await http.put(
      Uri.parse("$_baseurl/finance/finance/edit/expense/${event.id}/"),
      headers: {
        "Content-Type": "application/json",
        if (accessToken != null) "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({"expense": amount}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      _financesData = _financesData!.copyWith(
        eventExpenses: _expensesEvents.fold<double>(0,(sum, e) => sum + double.tryParse(e.amount.replaceAll('\$', ''))!,
        ),
        netProfit: _financesData!.eventSales -
            _expensesEvents.fold<double>(0,(sum, e) => sum + double.tryParse(e.amount.replaceAll('\$', ''))!,
        ),
      );
      notifyListeners();
    } else {
      print("Failed to update expense: ${response.statusCode}");
    }
  } catch (e) {
    print("Error updating expense: $e");
  }
}

  // --------------------- Helpers ---------------------
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> refresh() async {
    if (_financesData != null) {
      await loadFinancesView(_financesData!.id);
    }
  }
}

// --------------------- SalesEvent model ---------------------
class SalesEvent {
  String id;        // sales/expense id
  String boothId;   // booth id (optional)
  String title;
  String date;
  String amount;

  SalesEvent({
    required this.id,
    required this.boothId,
    required this.title,
    required this.date,
    required this.amount,
  });
}

