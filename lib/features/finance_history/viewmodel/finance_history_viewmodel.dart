import 'package:flutter/material.dart';
import '../model/finance_history_model.dart';
import '../repository/finance_history_repository.dart';

class FinanceHistoryViewModel extends ChangeNotifier {
  final FinanceHistoryRepository _repository = FinanceHistoryRepository();
  
  List<FinanceHistoryModel> _financeHistory = [];
  bool _isLoading = false;
  String? _error;
  String _selectedFilter = 'All';

  // Getters
  List<FinanceHistoryModel> get financeHistory => _financeHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedFilter => _selectedFilter;

  // Filter options
  List<String> get filterOptions => ['All', 'Sales', 'Expenses', 'Booth Fees'];

  // Initialize and load data
  Future<void> loadFinanceHistory() async {
    _setLoading(true);
    _clearError();
    
    try {
      _financeHistory = await _repository.getFinanceHistory();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load finance history: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Filter finance history by type
  List<FinanceHistoryModel> get filteredFinanceHistory {
    if (_selectedFilter == 'All') {
      return _financeHistory;
    }
    
    String type = '';
    switch (_selectedFilter) {
      case 'Sales':
        type = 'sale';
        break;
      case 'Expenses':
        type = 'expense';
        break;
      case 'Booth Fees':
        type = 'booth_fee';
        break;
    }
    
    return _financeHistory.where((item) => item.type == type).toList();
  }

  // Set filter
  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  // Get total amount for filtered results
  double get totalAmount {
    return filteredFinanceHistory.fold(0.0, (sum, item) => sum + item.amount);
  }

  // Get count for filtered results
  int get totalCount {
    return filteredFinanceHistory.length;
  }

  // Get type display name
  String getTypeDisplayName(String type) {
    switch (type) {
      case 'sale':
        return 'Sale';
      case 'expense':
        return 'Expense';
      case 'booth_fee':
        return 'Booth Fee';
      default:
        return 'Unknown';
    }
  }

  // Get type color
  Color getTypeColor(String type) {
    switch (type) {
      case 'sale':
        return const Color(0xFF4CAF50); // Green
      case 'expense':
        return const Color(0xFFE91E63); // Red
      case 'booth_fee':
        return const Color(0xFFFF9800); // Orange
      default:
        return const Color(0xFF757575); // Gray
    }
  }

  // Private methods
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

  // Refresh data
  Future<void> refresh() async {
    await loadFinanceHistory();
  }
}
