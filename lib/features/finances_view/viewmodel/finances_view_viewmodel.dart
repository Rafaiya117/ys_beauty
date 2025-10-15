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
  
 List<ExpenseEvent> _expensesEvents = [];
 List<ExpenseEvent> get expensesEvents => _expensesEvents;

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
        Uri.parse("$_baseurl/finance/finance/$id/"),
        headers: {
          'Content-Type': 'application/json',
          if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _financesData = FinancesViewModel.fromJson(data);

        // Populate Sales Events
        _salesEvents = [];
        for (var sale in data['sales_list'] ?? []) {
          debugPrint('📦 Loaded sale: ${sale['id']} -> ${sale['sales']}');
          _salesEvents.add(
            SalesEvent(
              id: sale['id'].toString(),
              title: "${_financesData!.eventName} Sale",
              date: sale['date'] ?? '',
              amount: '\$${sale['sales'].toString()}',
              boothId: '',
            ),
          );
        }

        // Populate Expenses Events
        _expensesEvents = [];
        for (var expense in data['expence_list'] ?? []) {
          _expensesEvents.add(ExpenseEvent(
            id: expense['id'].toString(),
            boothId: _financesData!.id,
            title: "${_financesData!.eventName} Expense",
            date: expense['date'] ?? '',
            amount: '\$${expense['expence'].toString()}',
          ));
        }
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
    // ✅ Preserve the original sale ID
    final oldEvent = _salesEvents[index];
    final eventWithId = updatedEvent.copyWith(id: oldEvent.id);

    _salesEvents[index] = eventWithId;
    notifyListeners();

    await _putSalesEvent(eventWithId); // Call API
    await loadFinancesView(_financesData!.id); // Refresh
  }
}


  Future<void> updateExpenseEvent(int index, ExpenseEvent updatedEvent) async {
  if (index >= 0 && index < _expensesEvents.length) {
    final oldEvent = _expensesEvents[index];
    final eventWithId = updatedEvent.copyWith(id: oldEvent.id);

    _expensesEvents[index] = eventWithId;
    notifyListeners();

    await _putExpenseEvent(eventWithId); // Call API
    await loadFinancesView(_financesData!.id); // Refresh
  }
}


  // --------------------- Private API helpers ---------------------
  Future<void> _putSalesEvent(SalesEvent event) async {
    final accessToken = await TokenStorage.getAccessToken();
    final amount = double.tryParse(event.amount.replaceAll('\$', '')) ?? 0;
    debugPrint('!--------------sales id ${event.id}');
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
        _financesData = _financesData!.copyWith(
          eventSales: _salesEvents.fold<double>(0,(sum, e) => sum + (double.tryParse(e.amount.replaceAll('\$', '')) ?? 0),
          ),
          netProfit: _salesEvents.fold<double>(0,(sum, e) => sum + (double.tryParse(e.amount.replaceAll('\$', '')) ?? 0),) -_financesData!.eventExpenses,
        );
        notifyListeners();
      } else {
        print("Failed to update sale: ${response.statusCode}");
      }
    } catch (e) {
      print("Error updating sale: $e");
    }
  }

  Future<void> _putExpenseEvent(ExpenseEvent event) async {
  final accessToken = await TokenStorage.getAccessToken();
  final amount = double.tryParse(event.amount.replaceAll('\$', '')) ?? 0;
  debugPrint('!--------------expense id ${event.id}');

  try {
    final response = await http.put(
      Uri.parse("$_baseurl/finance/finance/edit/expance/${event.id}/"),
      headers: {
        "Content-Type": "application/json",
        if (accessToken != null) "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({"expence": amount}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      _financesData = _financesData!.copyWith(
        eventExpenses: _expensesEvents.fold<double>(0,(sum, e) =>sum + (double.tryParse(e.amount.replaceAll('\$', '')) ?? 0),),
        netProfit: _financesData!.eventSales -
        _expensesEvents.fold<double>(0,(sum, e) => sum + (double.tryParse(e.amount.replaceAll('\$', '')) ?? 0),),
      );
      notifyListeners();
    } else {
      debugPrint("Failed to update expense: ${response.statusCode}");
    }
  } catch (e) {
    debugPrint("Error updating expense: $e");
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
  String id; // sales/expense id
  String boothId; // booth id (optional)
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

  factory SalesEvent.fromJson(Map<String, dynamic> json) {
    return SalesEvent(
      id: json['id'].toString(),
      boothId: '',
      title: '',
      date: json['date'] ?? '',
      amount: '\$${json['sales'] ?? json['expence'] ?? 0}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "sales": amount,
    };
  }

  SalesEvent copyWith({
    String? id,
    String? boothId,
    String? title,
    String? date,
    String? amount,
  }) {
    return SalesEvent(
      id: id ?? this.id,
      boothId: boothId ?? this.boothId,
      title: title ?? this.title,
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }
}

// --------------------- ExpenseEvent model ---------------------
class ExpenseEvent {
  String id;        // expense id
  String boothId;   // booth id (optional)
  String title;
  String date;
  String amount;

  ExpenseEvent({
    required this.id,
    required this.boothId,
    required this.title,
    required this.date,
    required this.amount,
  });

  // ✅ Add copyWith for preserving/updating fields
  ExpenseEvent copyWith({
    String? id,
    String? boothId,
    String? title,
    String? date,
    String? amount,
  }) {
    return ExpenseEvent(
      id: id ?? this.id,
      boothId: boothId ?? this.boothId,
      title: title ?? this.title,
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  // Optional: for JSON serialization if needed
  factory ExpenseEvent.fromJson(Map<String, dynamic> json) {
    return ExpenseEvent(
      id: json['id'].toString(),
      boothId: '', // Adjust if your API sends boothId
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      amount: (json['expence'] ?? 0).toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "date": date,
      "expence": amount,
    };
  }
}
