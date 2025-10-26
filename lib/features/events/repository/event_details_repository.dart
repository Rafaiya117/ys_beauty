import '../model/event_details_model.dart';
import '../model/event_model.dart';
import '../../../api/auth_api_service.dart';
import '../repository/events_repository.dart';
import 'package:intl/intl.dart';

class EventDetailsRepository {
  final AuthApiService _apiService = AuthApiService();
  final EventsRepository _eventsRepository = EventsRepository();

  Future<EventDetailsModel> getEventDetails(String eventId) async {
    try {
      // First, try to get the event from API
      final response = await _apiService.getEventById(eventId);
      
      if (response != null && response['success'] == true) {
        final eventData = response['event'];
        final eventModel = EventModel.fromJson(eventData);
        return _convertToEventDetailsModel(eventModel);
      }
      
      // If API fails, try to find it in today's events list
      try {
        final todayEvents = await _eventsRepository.getTodayEvents();
        final matchingEvent = todayEvents.firstWhere(
          (event) => event.id == eventId,
        );
        
        // Convert EventItem back to a format we can use
        return EventDetailsModel(
          id: matchingEvent.id,
          title: matchingEvent.title,
          description: 'Event details', // EventItem doesn't have description
          status: matchingEvent.status,
          date: matchingEvent.date,
          location: matchingEvent.location,
          fee: matchingEvent.cost,
          spaceNumber: matchingEvent.spaceNumber,
          boothSize: matchingEvent.boothSize,
          startTime: matchingEvent.startTime,
          endTime: matchingEvent.endTime,
        );
      } catch (e) {
        print('Event not found in today\'s events: $e');
      }
      
      // If both fail, return dummy data for now
      return EventDetailsModel(
        id: eventId,
        title: 'Event Not Found',
        description: 'Unable to load event details. Please try again later.',
        status: ['Unknown'],
        date: 'Unknown',
        location: 'Unknown',
        fee: '\$0',
        spaceNumber: '0',
        boothSize: '0*0',
        startTime: '12:00 PM',
        endTime: '6:00 PM',
      );
    } catch (e) {
      throw Exception('Failed to load event details: $e');
    }
  }
  
  EventDetailsModel _convertToEventDetailsModel(EventModel event) {
    // Format booth fee
    final formattedCost = '\$${event.boothFee.toString()}';
    
    // Create status list based on payment and approval
    // final List<String> statusList = [];
    // if (event.status == 'Approved') {
    //   statusList.add('Approved');
    // } else if (event.status == 'Pending') {
    //   statusList.add('Pending');
    // } else if (event.status == 'Denied') {
    //   statusList.add('Denied');
    // }
    
    // if (event.paid) {
    //   statusList.add('Paid');
    // } else {
    //   statusList.add('Unpaid');
    // }
    final List<String> statusList = [];
  if (event.status?.toLowerCase() == 'PEN' || event.status == 'Pending') {
    statusList.add('Pending');
  } else if (event.status?.toLowerCase() == 'APP' || event.status == 'Approved') {
    statusList.add('Approved');
  } else if (event.status?.toLowerCase() == 'DEN' || event.status == 'Denied') {
    statusList.add('Denied');
  }
  if (event.paid == true) {
    statusList.add('Paid');
  }


    // Format date for display
    String displayDate;
    try {
      final parsedDate = DateTime.parse(event.date);
      displayDate = DateFormat('MMMM d, yyyy').format(parsedDate); // e.g., "September 22, 2025"
    } catch (e) {
      displayDate = event.date.isNotEmpty ? event.date : DateFormat('MMMM d, yyyy').format(DateTime.now());
    }

    return EventDetailsModel(
      id: event.id?.toString() ?? '0',
      title: event.eventName,
      description: event.description,
      status: statusList,
      date: displayDate,
      location: event.address,
      fee: formattedCost,
      spaceNumber: event.boothSpace.replaceFirst('#', ''), // Remove # prefix if present
      boothSize: event.boothSize,
      startTime: event.startTimeUi,
      endTime: event.endTimeUi,
    );
  }
}
