import 'package:flutter/material.dart';

// class EventDetailsModel {
//   final String id;
//   final String title;
//   final String description;
//   final List<String> status;
//   final String date;
//   final String location;
//   final String fee;
//   final String spaceNumber;
//   final String boothSize;
//   final String startTime;
//   final String endTime;

//   EventDetailsModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.status,
//     required this.date,
//     required this.location,
//     required this.fee,
//     required this.spaceNumber,
//     required this.boothSize,
//     required this.startTime,
//     required this.endTime,
//   });

//   factory EventDetailsModel.fromEvent(dynamic event) {
//     return EventDetailsModel(
//       id: event.id ?? '1',
//       title: event.title ?? 'Event Title',
//       description: event.description ?? 'Join us for an unforgettable evening as we celebrate John\'s milestone 30th birthday! This vibrant birthday party will feature an exciting mix of games, music, delicious food, and a cocktail bar. The night will kick off with a live DJ performance, followed by a birthday toast.',
//       status: event.status ?? ['Pending', 'Unpaid'],
//       date: event.date ?? 'July 25, 2025',
//       location: event.location ?? 'Bardessono - Yountville, CA',
//       fee: event.cost ?? '\$200',
//       spaceNumber: event.spaceNumber ?? '12',
//       boothSize: event.boothSize ?? '10*10',
//       startTime: event.startTime ?? '12:00 PM',
//       endTime: event.endTime ?? '6:00 PM',
//     );
//   }
// }
class EventDetailsModel {
  final String id;
  final String title;
  final String description;
  final List<String> status;
  final String date;
  final String location;
  final String fee;
  final String spaceNumber;
  final String boothSize;
  final String startTime;
  final String endTime;

  EventDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.location,
    required this.fee,
    required this.spaceNumber,
    required this.boothSize,
    required this.startTime,
    required this.endTime,
  });

  /// ✅ Correctly maps JSON response keys
  factory EventDetailsModel.fromEvent(Map<String, dynamic> event) {
    // Defensive parsing in case response fields are null
    final startTimeRaw = event['start_time_date'];
    final endTimeRaw = event['end_time_date'];

    return EventDetailsModel(
      id: event['id']?.toString() ?? '',
      title: event['event_name'] ?? 'Untitled Event',
      description: (event['description']?.toString().trim().isNotEmpty ?? false)
          ? event['description']
          : 'No description available.',
      status: _mapStatus(event['status'], event['paid']), 
      date: event['date'] ?? '',
      location: event['address'] ?? 'No location provided',
      fee: event['booth_fee'] != null ? event['booth_fee'].toString() : '0',
      spaceNumber: event['booth_space']?.toString() ?? 'N/A',
      boothSize: event['booth_size'] ?? 'N/A',
      startTime: _formatTime(startTimeRaw),
      endTime: _formatTime(endTimeRaw),
    );
  }

  /// ✅ Show both “Paid” + “Pending” when applicable
  static List<String> _mapStatus(dynamic status, dynamic paid) {
  List<String> statuses = [];

  // Always show event status first
  switch (status?.toString().toUpperCase()) {
    case 'PEN':
      statuses.add('Pending');
      break;
    case 'APP':
      statuses.add('Approved');
      break;
    case 'DEN':
      statuses.add('Denied');
      break;
    case 'UNP':
      statuses.add('Unpaid');
      break;
    default:
      if (status != null) statuses.add(status.toString());
  }

  // Then add payment info
  if (paid == true) {
    statuses.add('Paid');
  }

  return statuses;
}



  static String _formatTime(dynamic isoString) {
    if (isoString == null || isoString == '') return 'N/A';
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = dateTime.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    } catch (e) {
      return isoString.toString();
    }
  }
}
