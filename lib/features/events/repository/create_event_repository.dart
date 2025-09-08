import '../model/create_event_model.dart';

class CreateEventRepository {
  Future<void> createEvent(CreateEventModel eventModel) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate API response
    // In a real app, this would make an HTTP request to your backend
    try {
      // Validate the event data
      if (eventModel.event.isEmpty) {
        throw Exception('Event name is required');
      }
      
      if (eventModel.location.isEmpty) {
        throw Exception('Location is required');
      }
      
      if (eventModel.boothFee.isEmpty) {
        throw Exception('Booth fee is required');
      }
      
      if (eventModel.boothSize.isEmpty) {
        throw Exception('Booth size is required');
      }
      
      if (eventModel.spaceNumber.isEmpty) {
        throw Exception('Space number is required');
      }
      
      if (eventModel.date.isEmpty) {
        throw Exception('Date is required');
      }
      
      if (eventModel.selectedStatus == null) {
        throw Exception('Status is required');
      }
      
      if (eventModel.isPaid == null) {
        throw Exception('Payment status is required');
      }
      
      // Simulate successful event creation
      print('Event created successfully:');
      print('Event: ${eventModel.event}');
      print('Location: ${eventModel.location}');
      print('Booth Fee: ${eventModel.boothFee}');
      print('Booth Size: ${eventModel.boothSize}');
      print('Space Number: ${eventModel.spaceNumber}');
      print('Date: ${eventModel.date}');
      print('Reminder: ${eventModel.reminder}');
      print('Status: ${eventModel.selectedStatus}');
      print('Paid: ${eventModel.isPaid}');
      print('Description: ${eventModel.description}');
      
    } catch (e) {
      throw Exception('Failed to create event: ${e.toString()}');
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
