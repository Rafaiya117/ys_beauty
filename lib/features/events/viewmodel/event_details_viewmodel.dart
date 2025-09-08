import 'package:flutter/material.dart';
import '../model/event_details_model.dart';
import '../repository/event_details_repository.dart';

class EventDetailsViewModel extends ChangeNotifier {
  final EventDetailsRepository _repository = EventDetailsRepository();
  
  EventDetailsModel? _eventDetails;
  bool _isLoading = false;
  String? _errorMessage;

  EventDetailsModel? get eventDetails => _eventDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadEventDetails(String eventId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _eventDetails = await _repository.getEventDetails(eventId);
    } catch (e) {
      _errorMessage = 'Failed to load event details: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.yellow;
      case 'approved':
        return Colors.green;
      case 'paid':
        return Colors.green;
      case 'denied':
        return Colors.red;
      case 'unpaid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
