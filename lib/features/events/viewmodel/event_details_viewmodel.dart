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
        return const Color(0xFFEEBC20); // Yellow background for Pending
      case 'approved':
        return const Color(0xFF00BF63); // Green background for Approved
      case 'paid':
        return const Color(0xFF00703A); // Dark green background for Paid
      case 'denied':
        return const Color(0xFFFF5151); // Red background for Denied
      case 'unpaid':
        return const Color(0xFFEF4444); // Red background for Unpaid
      default:
        return Colors.grey;
    }
  }
}
