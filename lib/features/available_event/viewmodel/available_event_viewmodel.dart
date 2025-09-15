import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/available_event_model.dart';

class AvailableEventViewModel extends ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<AvailableEventModel> _events = [];
  bool _isLoading = false;

  // Getters
  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  List<AvailableEventModel> get events => _events;
  bool get isLoading => _isLoading;

  // Initialize with sample data
  void initializeEvents() {
    _isLoading = true;
    notifyListeners();

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _events.clear();
      _events.addAll([
        AvailableEventModel(
          id: '1',
          title: 'Friendly Party',
          location: 'Bardessono - Yountville, CA',
          boothSize: '10*10',
          spaceNumber: '12',
          cost: '\$500',
          startTime: '2:00 PM',
          endTime: '6:00 PM',
          status: ['Approved', 'Paid'],
          eventDate: DateTime(2025, 7, 1),
        ),
        AvailableEventModel(
          id: '2',
          title: 'Birthday Celebration',
          location: 'Grand Hotel Ballroom',
          boothSize: '15*15',
          spaceNumber: '8',
          cost: '\$750',
          startTime: '3:00 PM',
          endTime: '8:00 PM',
          status: ['Approved', 'Paid'],
          eventDate: DateTime(2025, 7, 3),
        ),
        AvailableEventModel(
          id: '3',
          title: 'Corporate Event',
          location: 'Convention Center',
          boothSize: '20*20',
          spaceNumber: '5',
          cost: '\$1000',
          startTime: '9:00 AM',
          endTime: '5:00 PM',
          status: ['Pending', 'Unpaid'],
          eventDate: DateTime(2025, 7, 5),
        ),
        AvailableEventModel(
          id: '4',
          title: 'Wedding Reception',
          location: 'Garden Venue',
          boothSize: '12*12',
          spaceNumber: '15',
          cost: '\$600',
          startTime: '4:00 PM',
          endTime: '10:00 PM',
          status: ['Approved', 'Paid'],
          eventDate: DateTime(2025, 7, 8),
        ),
        AvailableEventModel(
          id: '5',
          title: 'Music Festival',
          location: 'Downtown Plaza',
          boothSize: '25*25',
          spaceNumber: '3',
          cost: '\$1200',
          startTime: '11:00 AM',
          endTime: '11:00 PM',
          status: ['Approved', 'Paid'],
          eventDate: DateTime(2025, 7, 12),
        ),
        AvailableEventModel(
          id: '6',
          title: 'Art Exhibition',
          location: 'Museum Gallery',
          boothSize: '8*8',
          spaceNumber: '20',
          cost: '\$300',
          startTime: '10:00 AM',
          endTime: '6:00 PM',
          status: ['Pending', 'Paid'],
          eventDate: DateTime(2025, 7, 15),
        ),
        AvailableEventModel(
          id: '7',
          title: 'Food Festival',
          location: 'City Park',
          boothSize: '18*18',
          spaceNumber: '7',
          cost: '\$800',
          startTime: '12:00 PM',
          endTime: '8:00 PM',
          status: ['Approved', 'Paid'],
          eventDate: DateTime(2025, 7, 15),
        ),
        AvailableEventModel(
          id: '8',
          title: 'Tech Conference',
          location: 'Tech Center',
          boothSize: '30*30',
          spaceNumber: '1',
          cost: '\$1500',
          startTime: '8:00 AM',
          endTime: '6:00 PM',
          status: ['Approved', 'Paid'],
          eventDate: DateTime(2025, 7, 25),
        ),
      ]);
      _isLoading = false;
      notifyListeners();
    });
  }

  // Check if a date has events
  bool hasEvents(DateTime day) {
    return _events.any((event) => isSameDay(event.eventDate, day));
  }

  // Get events for a specific date
  List<AvailableEventModel> getEventsForDate(DateTime day) {
    return _events.where((event) => isSameDay(event.eventDate, day)).toList();
  }

  // Calendar event loader
  List<AvailableEventModel> eventLoader(DateTime day) {
    return getEventsForDate(day);
  }

  // Handle day selection
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      notifyListeners();
    }
  }

  // Handle format change
  void onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      _calendarFormat = format;
      notifyListeners();
    }
  }

  // Handle page change
  void onPageChanged(DateTime focusedDay) {
    if (!isSameDay(_focusedDay, focusedDay)) {
      _focusedDay = focusedDay;
      notifyListeners();
    }
  }

  // Get status color
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFEEBC20); // Yellow background for Pending
      case 'approved':
        return const Color(0xFF00BF63); // Green background for Approved
      case 'paid':
        return const Color(0xFF00703A); // Dark green background for Paid
      case 'denied':
        return const Color(0xFFFF5151);
      case 'unpaid':
        return const Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }

  // Get selected day events
  List<AvailableEventModel> get selectedDayEvents {
    if (_selectedDay == null) return [];
    return getEventsForDate(_selectedDay!);
  }
}
