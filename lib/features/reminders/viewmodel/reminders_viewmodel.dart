import 'package:flutter/material.dart';
import '../model/reminders_model.dart';
import '../repository/reminders_repository.dart';

class RemindersViewModel extends ChangeNotifier {
  final RemindersRepository _repository = RemindersRepository();
  
  RemindersModel _model = RemindersModel();
  RemindersModel get model => _model;

  bool get isLoading => _model.isLoading;
  String? get errorMessage => _model.errorMessage;
  List<ReminderItem> get reminders => _model.reminders;

  Future<void> loadReminders() async {
    _updateModel(_model.copyWith(isLoading: true, errorMessage: null));
    
    try {
      final reminders = await _repository.getReminders();
      _updateModel(_model.copyWith(
        isLoading: false,
        reminders: reminders,
      ));
    } catch (e) {
      _updateModel(_model.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load reminders: ${e.toString()}',
      ));
    }
  }

  void _updateModel(RemindersModel newModel) {
    _model = newModel;
    notifyListeners();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Color(0xFFEEBC20);
      case 'approved':
        return Color(0xFF00BF63);
      case 'denied':
        return Color(0xFFFF0000);
      default:
        return Color(0xFF808080);
    }
  }
}
