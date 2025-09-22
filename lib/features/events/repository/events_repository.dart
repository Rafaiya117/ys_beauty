import '../model/events_model.dart';
import '../model/event_model.dart';
import '../../../api/auth_api_service.dart';
import '../../../shared/utils/datetime_helper.dart';
import 'package:intl/intl.dart';

class EventsRepository {
  final AuthApiService _apiService = AuthApiService();

  Future<List<EventItem>> getEvents() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    return [
      EventItem(
        id: '1',
        title: 'Friendly Party',
        location: 'Bardessono - Yountville, CA',
        boothSize: '10*10',
        spaceNumber: '12',
        cost: '\$500',
        startTime: '2:00 PM',
        endTime: '6:00 PM',
        date: 'July 25',
        status: ['Pending', 'Paid'],
        category: 'Today',
      ),
      EventItem(
        id: '2',
        title: 'Friendly Party',
        location: 'Bardessono - Yountville, CA',
        boothSize: '10*10',
        spaceNumber: '12',
        cost: '\$500',
        startTime: '2:00 PM',
        endTime: '6:00 PM',
        date: 'July 25',
        status: ['Pending', 'Unpaid'],
        category: 'Today',
      ),
      EventItem(
        id: '3',
        title: 'Friendly Party',
        location: 'Bardessono - Yountville, CA',
        boothSize: '10*10',
        spaceNumber: '12',
        cost: '\$500',
        startTime: '2:00 PM',
        endTime: '6:00 PM',
        date: 'July 25',
        status: ['Pending', 'Paid'],
        category: 'Today',
      ),
      EventItem(
        id: '4',
        title: 'Friendly Party',
        location: 'Bardessono - Yountville, CA',
        boothSize: '10*10',
        spaceNumber: '12',
        cost: '\$500',
        startTime: '2:00 PM',
        endTime: '6:00 PM',
        date: 'July 25',
        status: ['Denied'],
        category: 'Today',
      ),
      EventItem(
        id: '5',
        title: 'Conference Event',
        location: 'San Francisco, CA',
        boothSize: '15*15',
        spaceNumber: '25',
        cost: '\$800',
        startTime: '9:00 AM',
        endTime: '5:00 PM',
        date: 'July 30',
        status: ['Approved', 'Paid'],
        category: 'Upcoming',
      ),
      EventItem(
        id: '6',
        title: 'Trade Show',
        location: 'Los Angeles, CA',
        boothSize: '20*20',
        spaceNumber: '45',
        cost: '\$1200',
        startTime: '10:00 AM',
        endTime: '6:00 PM',
        date: 'August 5',
        status: ['Pending', 'Unpaid'],
        category: 'Upcoming',
      ),
      EventItem(
        id: '7',
        title: 'Exhibition',
        location: 'San Diego, CA',
        boothSize: '12*12',
        spaceNumber: '18',
        cost: '\$600',
        startTime: '1:00 PM',
        endTime: '7:00 PM',
        date: 'July 15',
        status: ['Approved', 'Paid'],
        category: 'Past',
      ),
    ];
  }

  Future<List<EventItem>> getTodayEvents() async {
    try {
      final response = await _apiService.getTodayEvents();

      if (response == null || response['success'] != true) {
        throw Exception(
          response?['error'] ?? 'Failed to fetch today\'s events',
        );
      }

      final List<dynamic> eventsData = response['events'] ?? [];

      if (eventsData.isEmpty) {
        return [];
      }

      // Convert API response to EventModel objects
      final List<EventModel> eventModels = eventsData
          .map((json) => EventModel.fromJson(json))
          .toList();

      // Filter events that are active (show all active events regardless of status)
      final filteredEvents = eventModels
          .where((event) => event.isActive)
          .toList();

      // Convert EventModel to EventItem
      return filteredEvents
          .map((event) => _convertToEventItem(event, 'Today'))
          .toList();
    } catch (e) {
      print('Error in getTodayEvents: $e');
      throw Exception('Failed to load today\'s events: $e');
    }
  }

  Future<List<EventItem>> getUpcomingEvents() async {
    try {
      final response = await _apiService.getUpcomingEvents();

      if (response == null || response['success'] != true) {
        throw Exception(
          response?['error'] ?? 'Failed to fetch upcoming events',
        );
      }

      final List<dynamic> eventsData = response['events'] ?? [];

      if (eventsData.isEmpty) {
        return [];
      }

      // Convert API response to EventModel objects
      final List<EventModel> eventModels = eventsData
          .map((json) => EventModel.fromJson(json))
          .toList();

      // Filter events that are active
      final filteredEvents = eventModels
          .where((event) => event.isActive)
          .toList();

      // Convert EventModel to EventItem with 'Upcoming' category
      return filteredEvents
          .map((event) => _convertToEventItem(event, 'Upcoming'))
          .toList();
    } catch (e) {
      print('Error in getUpcomingEvents: $e');
      throw Exception('Failed to load upcoming events: $e');
    }
  }

  Future<List<EventItem>> getPastEvents() async {
    try {
      final response = await _apiService.getPastEvents();

      if (response == null || response['success'] != true) {
        throw Exception(response?['error'] ?? 'Failed to fetch past events');
      }

      final List<dynamic> eventsData = response['events'] ?? [];

      if (eventsData.isEmpty) {
        return [];
      }

      // Convert API response to EventModel objects
      final List<EventModel> eventModels = eventsData
          .map((json) => EventModel.fromJson(json))
          .toList();

      // Filter events that are active
      final filteredEvents = eventModels
          .where((event) => event.isActive)
          .toList();

      // Convert EventModel to EventItem with 'Past' category
      return filteredEvents
          .map((event) => _convertToEventItem(event, 'Past'))
          .toList();
    } catch (e) {
      print('Error in getPastEvents: $e');
      throw Exception('Failed to load past events: $e');
    }
  }

  EventItem _convertToEventItem(EventModel event, String category) {
    // Format booth fee
    final formattedCost = '\$${event.boothFee.toString()}';

    // Create status list based on payment and approval
    final List<String> statusList = [];
    if (event.status == 'APP') {
      statusList.add('Approved');
    } else if (event.status == 'PEN') {
      statusList.add('Pending');
    } else if (event.status == 'DEN') {
      statusList.add('Denied');
    }

    if (event.paid) {
      statusList.add('Paid');
    } else {
      statusList.add('Unpaid');
    }

    // Format date for display
    String displayDate;
    try {
      final parsedDate = DateTime.parse(event.date);
      displayDate = DateFormat(
        'MMMM d',
      ).format(parsedDate); // e.g., "September 22"
    } catch (e) {
      // If parsing fails, try to use the raw date or fallback to current date
      displayDate = event.date.isNotEmpty
          ? event.date
          : DateFormat('MMMM d').format(DateTime.now());
    }

    return EventItem(
      id: event.id?.toString() ?? '0',
      title: event.eventName,
      location: event.address,
      boothSize: event.boothSize,
      spaceNumber: event.boothSpace.replaceFirst(
        '#',
        '',
      ), // Remove # prefix if present
      cost: formattedCost,
      startTime: event.startTimeUi,
      endTime: event.endTimeUi,
      date: displayDate,
      status: statusList,
      category: category,
    );
  }
}
