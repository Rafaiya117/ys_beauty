import '../model/reminders_model.dart';
import 'dart:ui';

class RemindersRepository {
  Future<List<ReminderItem>> getReminders() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      ReminderItem(
        id: '1',
        title: 'Birthday Party',
        date: '01 July 2025',
        status: 'Pending',
        cardColor: const Color(0xFFFFF3C7), // Light yellow
      ),
      ReminderItem(
        id: '2',
        title: 'Friendly Party',
        date: '01 July 2025',
        status: 'Approved',
        cardColor: const Color(0xFFE8F5E8), // Light green
      ),
      ReminderItem(
        id: '3',
        title: 'Conference',
        date: '01 July 2025',
        status: 'Denied',
        cardColor: const Color(0xFFFFE8E8), // Light red
      ),
      ReminderItem(
        id: '4',
        title: 'Birthday Party',
        date: '30 Jun 2025',
        status: 'Pending',
        cardColor: const Color(0xFFF5F5F5), // Light gray
      ),
      ReminderItem(
        id: '5',
        title: 'Friendly Party',
        date: '29 Jun 2025',
        status: 'Approved',
        cardColor: const Color(0xFFF5F5F5), // Light gray
      ),
      ReminderItem(
        id: '6',
        title: 'Conference',
        date: '28 Jun 2025',
        status: 'Denied',
        cardColor: const Color(0xFFF5F5F5), // Light gray
      ),
    ];
  }
}
