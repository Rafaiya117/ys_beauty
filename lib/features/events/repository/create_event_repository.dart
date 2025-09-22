import '../model/create_event_model.dart';
import '../model/event_model.dart';
import '../../../api/auth_api_service.dart';

class CreateEventRepository {
  Future<EventModel> createEvent(CreateEventModel eventModel) async {
    try {
      print('Creating event via API...');

      // Create EventModel with proper date/time conversion
      final eventForApi = EventModel.fromCreateEventModel(
        eventName: eventModel.event,
        startTime: eventModel.startTime,
        endTime: eventModel.endTime,
        address: eventModel.location,
        boothFee: eventModel.boothFee,
        boothSize: eventModel.boothSize,
        boothSpace: eventModel.spaceNumber,
        uiDate: eventModel.date,
        paid: eventModel.isPaid ?? false,
        status: _mapStatusToApi(eventModel.selectedStatus ?? ''),
        description: eventModel.description,
      );

      final authApiService = AuthApiService();
      final result = await authApiService.createEvent(eventForApi.toJson());

      if (result != null && result['success'] == true) {
        // For success response with wrapped event data
        final eventData = result['event'] as Map<String, dynamic>;
        final createdEvent = EventModel.fromJson(eventData);

        print('Event created successfully: $createdEvent');
        return createdEvent;
      } else if (result != null && result.containsKey('id')) {
        // For direct event data response (201 status)
        final createdEvent = EventModel.fromJson(result);

        print('Event created successfully: $createdEvent');
        return createdEvent;
      } else {
        final errorMessage = result?['error'] ?? 'Failed to create event';
        print('Event creation failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Event repository error: $e');
      if (e.toString().contains('Authentication expired')) {
        throw Exception('Authentication expired. Please login again.');
      } else if (e.toString().contains('Network')) {
        throw Exception('Network error. Please check your connection.');
      } else {
        throw Exception('Failed to create event. Please try again.');
      }
    }
  }

  /// Maps UI status to API status codes
  String _mapStatusToApi(String uiStatus) {
    switch (uiStatus.toLowerCase()) {
      case 'approved':
        return 'APP';
      case 'pending':
        return 'PEN';
      case 'denied':
        return 'DEN';
      default:
        return 'PEN'; // Default to pending
    }
  }

  Future<List<Map<String, dynamic>>> getEventTemplates() async {
    // Simulate API call for event templates
    await Future.delayed(const Duration(seconds: 1));

    return [
      {
        'id': '1',
        'name': 'Conference',
        'defaultDuration': 8,
        'defaultBoothSize': '10x10',
      },
      {
        'id': '2',
        'name': 'Workshop',
        'defaultDuration': 4,
        'defaultBoothSize': '8x8',
      },
      {
        'id': '3',
        'name': 'Exhibition',
        'defaultDuration': 6,
        'defaultBoothSize': '12x12',
      },
    ];
  }

  Future<List<String>> getLocations() async {
    // Simulate API call for locations
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      'Bardessono - Yountville, CA',
      'Marriott Downtown - San Francisco, CA',
      'Hilton Garden Inn - Napa, CA',
      'Hyatt Regency - Sacramento, CA',
      'Sheraton Grand - Los Angeles, CA',
    ];
  }

  Future<List<String>> getReminderOptions() async {
    // Simulate API call for reminder options
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      '1 hour before',
      '2 hours before',
      '1 day before',
      '1 week before',
      'No reminder',
    ];
  }
}
