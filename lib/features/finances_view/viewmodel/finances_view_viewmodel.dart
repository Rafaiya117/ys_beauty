import 'package:flutter/material.dart';
import '../model/finances_view_model.dart';
import '../repository/finances_view_repository.dart';

class FinancesViewViewModel extends ChangeNotifier {
  final FinancesViewRepository _repository = FinancesViewRepository();
  
  FinancesViewModel? _financesData;
  bool _isLoading = false;
  String? _error;

  // Getters
  FinancesViewModel? get financesData => _financesData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load finances view data by ID
  Future<void> loadFinancesView(String id) async {
    _setLoading(true);
    _clearError();
    
    try {
      _financesData = await _repository.getFinancesView(id);
      if (_financesData == null) {
        _setError('Finance details not found');
      }
      notifyListeners();
    } catch (e) {
      _setError('Failed to load finance details: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Load default finances view (for demo purposes)
  Future<void> loadDefaultFinancesView() async {
    _setLoading(true);
    _clearError();
    
    try {
      // Load the first item as default
      _financesData = await _repository.getFinancesView('1');
      notifyListeners();
    } catch (e) {
      _setError('Failed to load finance details: ${e.toString()}');
    } finally {
      _setLoading(false);
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
    if (_financesData != null) {
      await loadFinancesView(_financesData!.id);
    }
  }
}
