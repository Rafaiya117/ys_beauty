import 'package:flutter/material.dart';
import '../model/edit_financial_details_model.dart';
import '../repository/edit_financial_details_repository.dart';

// class EditFinancialDetailsViewModel extends ChangeNotifier {
//   final EditFinancialDetailsRepository _repository = EditFinancialDetailsRepository();
  
//   EditFinancialDetailsModel? _financialDetails;
//   bool _isLoading = false;
//   String? _error;
//   bool _isSaving = false;
//   bool _isSuccess = false;

//   // TextEditingControllers for form fields
//   final TextEditingController _eventController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _boothSizeController = TextEditingController();
//   final TextEditingController _boothFeeController = TextEditingController();
//   final TextEditingController _grossSalesController = TextEditingController();
//   final TextEditingController _expensesController = TextEditingController();
//   final TextEditingController _netProfitController = TextEditingController();

//   // Getters
//   EditFinancialDetailsModel? get financialDetails => _financialDetails;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   bool get isSaving => _isSaving;
//   bool get isSuccess => _isSuccess;

//   // Form controllers getters
//   TextEditingController get eventController => _eventController;
//   TextEditingController get dateController => _dateController;
//   TextEditingController get boothSizeController => _boothSizeController;
//   TextEditingController get boothFeeController => _boothFeeController;
//   TextEditingController get grossSalesController => _grossSalesController;
//   TextEditingController get expensesController => _expensesController;
//   TextEditingController get netProfitController => _netProfitController;

//   // Load financial details by ID
//   Future<void> loadFinancialDetails(String id) async {
//     _setLoading(true);
//     _clearError();
    
//     try {
//       _financialDetails = await _repository.getFinancialDetailsById(id);
//       if (_financialDetails != null) {
//         _populateFormFields();
//       } else {
//         _setError('Financial details not found');
//       }
//       notifyListeners();
//     } catch (e) {
//       _setError('Failed to load financial details: ${e.toString()}');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Populate form fields with loaded data
//   void _populateFormFields() {
//     if (_financialDetails != null) {
//       _eventController.text = _financialDetails!.event;
//       _dateController.text = _financialDetails!.date;
//       _boothSizeController.text = _financialDetails!.boothSize;
//       _boothFeeController.text = _financialDetails!.boothFee.toStringAsFixed(2);
//       _grossSalesController.text = _financialDetails!.grossSales.toStringAsFixed(2);
//       _expensesController.text = _financialDetails!.expenses.toStringAsFixed(2);
//       _netProfitController.text = _financialDetails!.netProfit.toStringAsFixed(2);
//     }
//   }

//   // Calculate net profit automatically
  // void calculateNetProfit() {
  //   try {
  //     final grossSales = double.tryParse(_grossSalesController.text) ?? 0.0;
  //     final expenses = double.tryParse(_expensesController.text) ?? 0.0;
  //     final netProfit = grossSales - expenses;
  //     _netProfitController.text = netProfit.toStringAsFixed(2);
  //   } catch (e) {
  //     // Handle calculation error
  //   }
  // }

//   // Save financial details
//   Future<void> saveFinancialDetails() async {
//     if (_financialDetails == null) return;
    
//     _setSaving(true);
//     _clearError();
//     _clearSuccess();
    
//     try {
//       // Create updated model
//       final updatedDetails = EditFinancialDetailsModel(
//         id: _financialDetails!.id,
//         event: _eventController.text.trim(),
//         date: _dateController.text.trim(),
//         boothSize: _boothSizeController.text.trim(),
//         boothFee: double.tryParse(_boothFeeController.text) ?? 0.0,
//         grossSales: double.tryParse(_grossSalesController.text) ?? 0.0,
//         expenses: double.tryParse(_expensesController.text) ?? 0.0,
//         netProfit: double.tryParse(_netProfitController.text) ?? 0.0,
//       );

//       final success = await _repository.updateFinancialDetails(updatedDetails);
//       if (success) {
//         _financialDetails = updatedDetails;
//         _setSuccess(true);
//       } else {
//         _setError('Failed to save financial details');
//       }
//       notifyListeners();
//     } catch (e) {
//       _setError('Failed to save financial details: ${e.toString()}');
//     } finally {
//       _setSaving(false);
//     }
//   }

//   // Refresh data
  // Future<void> refresh() async {
  //   if (_financialDetails != null) {
  //     await loadFinancialDetails(_financialDetails!.id);
  //   }
  // }

//   // Helper methods
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   void _setSaving(bool saving) {
//     _isSaving = saving;
//     notifyListeners();
//   }

//   void _setError(String error) {
//     _error = error;
//     notifyListeners();
//   }

//   void _setSuccess(bool success) {
//     _isSuccess = success;
//     notifyListeners();
//   }

//   void _clearError() {
//     _error = null;
//     notifyListeners();
//   }

//   void _clearSuccess() {
//     _isSuccess = false;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _eventController.dispose();
//     _dateController.dispose();
//     _boothSizeController.dispose();
//     _boothFeeController.dispose();
//     _grossSalesController.dispose();
//     _expensesController.dispose();
//     _netProfitController.dispose();
//     super.dispose();
//   }
// }
class EditFinancialDetailsViewModel extends ChangeNotifier {
  final EditFinancialDetailsRepository _repository = EditFinancialDetailsRepository();
  EditFinancialDetailsRepository get repository => _repository;

  EditFinancialDetailsModel? _financialDetails;
  bool _isLoading = false;
  String? _error;
  bool _isSaving = false;
  bool _isSuccess = false;

  // TextEditingControllers
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _boothSizeController = TextEditingController();
  final TextEditingController _boothFeeController = TextEditingController();
  final TextEditingController _grossSalesController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  final TextEditingController _netProfitController = TextEditingController();

  // Getters
  EditFinancialDetailsModel? get financialDetails => _financialDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSaving => _isSaving;
  bool get isSuccess => _isSuccess;

  // Controllers getters
  TextEditingController get eventController => _eventController;
  TextEditingController get dateController => _dateController;
  TextEditingController get boothSizeController => _boothSizeController;
  TextEditingController get boothFeeController => _boothFeeController;
  TextEditingController get grossSalesController => _grossSalesController;
  TextEditingController get expensesController => _expensesController;
  TextEditingController get netProfitController => _netProfitController;

  // 🔹 Load from API by ID
  Future<void> loadFinancialDetailsById(String id) async {
    _setLoading(true);
    _clearError();

    try {
      _financialDetails = await _repository.getFinancialDetailsById(id);
      if (_financialDetails != null) {
        _populateFormFields();
      } else {
        _setError('Financial details not found');
      }
    } catch (e) {
      _setError('Failed to load financial details: $e');
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  // Populate form
  void _populateFormFields() {
    if (_financialDetails != null) {
      _eventController.text = _financialDetails!.event;
      _dateController.text = _financialDetails!.date;
      _boothSizeController.text = _financialDetails!.boothSize;
      _boothFeeController.text = _financialDetails!.boothFee.toStringAsFixed(2);
      _grossSalesController.text = _financialDetails!.grossSales.toStringAsFixed(2);
      _expensesController.text = _financialDetails!.expenses.toStringAsFixed(2);
      _netProfitController.text = _financialDetails!.netProfit.toStringAsFixed(2);
    }
  }

  // Save changes
  Future<void> saveFinancialDetails() async {
    if (_financialDetails == null) return;

    _setSaving(true);
    _clearError();
    _clearSuccess();

    try {
      final updatedDetails = EditFinancialDetailsModel(
        id: _financialDetails!.id,
        event: _eventController.text.trim(),
        date: _dateController.text.trim(),
        boothSize: _boothSizeController.text.trim(),
        boothFee: double.tryParse(_boothFeeController.text) ?? 0.0,
        grossSales: double.tryParse(_grossSalesController.text) ?? 0.0,
        expenses: double.tryParse(_expensesController.text) ?? 0.0,
        netProfit: double.tryParse(_netProfitController.text) ?? 0.0,
      );

      final success = await _repository.updateFinancialDetails(updatedDetails);
      if (success) {
        _financialDetails = updatedDetails;
        _populateFormFields();
        _setSuccess(true);
      } else {
        _setError('Failed to save financial details');
      }
    } catch (e) {
      _setError('Failed to save financial details: $e');
    } finally {
      _setSaving(false);
      notifyListeners();
    }
  }

  void calculateNetProfit() {
    try {
      final grossSales = double.tryParse(_grossSalesController.text) ?? 0.0;
      final expenses = double.tryParse(_expensesController.text) ?? 0.0;
      final netProfit = grossSales - expenses;
      _netProfitController.text = netProfit.toStringAsFixed(2);
    } catch (e) {
      // Handle calculation error
    }
  }

  Future<void> refresh() async {
    if (_financialDetails != null) {
      await loadFinancialDetailsById(_financialDetails!.id);
    }
  }
  // Helpers
  void _setLoading(bool value) { _isLoading = value; notifyListeners(); }
  void _setSaving(bool value) { _isSaving = value; notifyListeners(); }
  void _setError(String value) { _error = value; notifyListeners(); }
  void _setSuccess(bool value) { _isSuccess = value; notifyListeners(); }
  void _clearError() { _error = null; notifyListeners(); }
  void _clearSuccess() { _isSuccess = false; notifyListeners(); }

  @override
  void dispose() {
    _eventController.dispose();
    _dateController.dispose();
    _boothSizeController.dispose();
    _boothFeeController.dispose();
    _grossSalesController.dispose();
    _expensesController.dispose();
    _netProfitController.dispose();
    super.dispose();
  }
}
