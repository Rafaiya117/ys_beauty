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
    debugPrint('!------------------$eventId');
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
  switch (status.toLowerCase().trim()) {
    case 'PEN':
    case 'pending':
      return const Color(0xFFEEBC20);
    case 'app':
    case 'approved':
      return const Color(0xFF00BF63);
    case 'paid':
      return const Color(0xFF00703A);
    case 'den':
    case 'denied':
      return const Color(0xFFFF5151);
    case 'unpaid':
    case 'unp':
      return const Color(0xFFEF4444);
    default:
      return Colors.grey;
  }
}

}
