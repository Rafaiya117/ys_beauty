import '../model/event_details_model.dart';

class EventDetailsRepository {
  Future<EventDetailsModel> getEventDetails(String eventId) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return sample event details
    return EventDetailsModel(
      id: eventId,
      title: 'Birthday Party',
      description: 'Join us for an unforgettable evening as we celebrate John\'s milestone 30th birthday! This vibrant birthday party will feature an exciting mix of games, music, delicious food, and a cocktail bar. The night will kick off with a live DJ performance, followed by a birthday toast.',
      status: ['Pending', 'Unpaid'],
      date: 'July 25, 2025',
      location: 'Bardessono - Yountville, CA',
      fee: '\$200',
      spaceNumber: '12',
      boothSize: '10*10',
      startTime: '12:00 PM',
      endTime: '6:00 PM',
    );
  }
}
