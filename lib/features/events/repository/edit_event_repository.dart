import '../model/edit_event_model.dart';

class EditEventRepository {
  // Simulate fetching event data for editing
  Future<EditEventModel> fetchEventForEdit(String eventId) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return sample data - in real app, this would come from API
    return EditEventModel(
      id: eventId,
      title: 'Tech Conference 2024',
      description: 'Annual technology conference featuring the latest innovations in software development, AI, and digital transformation.',
      date: 'March 15, 2024',
      location: 'Convention Center, Downtown',
      fee: '\$299',
      spaceNumber: 'A-15',
      boothSize: '10x10 ft',
      startTime: '9:00 AM',
      endTime: '5:00 PM',
      status: ['Pending', 'Unpaid'],
      isPaid: false,
      reminder: '1 day before',
    );
  }

  // Simulate updating event data
  Future<bool> updateEvent(EditEventModel event) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    // In real app, this would make API call to update event
    print('Updating event: ${event.toJson()}');
    
    // Simulate success
    return true;
  }
}
