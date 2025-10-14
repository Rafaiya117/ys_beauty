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

        // Populate history events
        _salesEvents = [
          SalesEvent(
            title: _financesData!.eventName,
            date: _financesData!.date,
            amount: '\$${_financesData!.eventSales.toStringAsFixed(0)}',
          ),
        ];

        _expensesEvents = [
          SalesEvent(
            title: _financesData!.eventName,
            date: _financesData!.date,
            amount: '\$${_financesData!.eventExpenses.toStringAsFixed(0)}',
          ),
        ];
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
      Uri.parse("$_baseurl/finance/finance/edit/sales/${_financesData!.id}/"),
      headers: {
        "Content-Type": "application/json",
        if (accessToken != null) "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({"sales": amount}), // your API expects "sales"
    );
    debugPrint('!-------------------${_financesData!.id}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ Sale updated on server: ${response.body}");
      // Update local financesData to reflect the new sales immediately
      _financesData = FinancesViewModel(
        id: _financesData!.id,
        eventName: _financesData!.eventName,
        date: _financesData!.date,
        eventSales: amount, // updated
        eventExpenses: _financesData!.eventExpenses,
        netProfit: amount - _financesData!.eventExpenses,
        boothFee: _financesData!.boothFee,
        boothSize: _financesData!.boothSize,
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
      Uri.parse("$_baseurl/finance/finance/${_financesData!.id}/edit-expense/"),
      headers: {
        "Content-Type": "application/json",
        if (accessToken != null) "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({"expense": amount}), // fixed typo: "expence" → "expense"
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ Expense updated on server: ${response.body}");
      // Update local financesData to reflect the new expenses immediately
      _financesData = FinancesViewModel(
        id: _financesData!.id,
        eventName: _financesData!.eventName,
        date: _financesData!.date,
        eventSales: _financesData!.eventSales,
        eventExpenses: amount, // updated
        netProfit: _financesData!.eventSales - amount,
        boothFee: _financesData!.boothFee,
        boothSize: _financesData!.boothSize,
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
  String title;
  String date;
  String amount;

  SalesEvent({required this.title, required this.date, required this.amount});
}
