import '../../../shared/utils/datetime_helper.dart';

class EventModel {
  final int? id;
  final String? user;
  final String eventName;
  final String startTimeDate;
  final String endTimeDate;
  final String address;
  final int boothFee;
  final String boothSize;
  final String boothSpace;
  final String date;
  final bool paid;
  final String status;
  final bool isActive;
  final String description;

  const EventModel({
    this.id,
    this.user,
    required this.eventName,
    required this.startTimeDate,
    required this.endTimeDate,
    required this.address,
    required this.boothFee,
    required this.boothSize,
    required this.boothSpace,
    required this.date,
    required this.paid,
    required this.status,
    required this.isActive,
    required this.description,
  });

  /// Factory constructor to create EventModel from API JSON response
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as int?,
      user: json['user'] as String?,
      eventName: json['event_name'] as String,
      startTimeDate: json['start_time_date'] as String,
      endTimeDate: json['end_time_date'] as String,
      address: json['address'] as String,
      boothFee: _parseToInt(json['booth_fee']),
      boothSize: json['booth_size'] as String,
      boothSpace: json['booth_space'] as String,
      date: json['date'] as String,
      paid: json['paid'] as bool,
      status: json['status'] as String,
      isActive: json['is_active'] as bool,
      description: json['description'] as String,
    );
  }

  /// Helper method to safely parse numeric values to int
  static int _parseToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }

  /// Convert EventModel to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'event_name': eventName,
      'start_time_date': startTimeDate,
      'end_time_date': endTimeDate,
      'address': address,
      'booth_fee': boothFee,
      'booth_size': boothSize,
      'booth_space': boothSpace,
      'date': date,
      'paid': paid,
      'status': status,
      'is_active': isActive,
      'description': description,
    };
  }

 
  factory EventModel.fromCreateEventModel({
    required String eventName,
    required String startTime,
    required String endTime,
    required String address,
    required String boothFee,
    required String boothSize,
    required String boothSpace,
    required String uiDate,
    required bool paid,
    required String status,
    required String description,
  }) {
    // Convert UI date/time to ISO UTC format
    final startTimeIso = DateTimeHelper.convertToIsoUtc(uiDate, startTime);
    final endTimeIso = DateTimeHelper.convertToIsoUtc(uiDate, endTime);

    // Convert UI date to API date format
    final apiDate = DateTimeHelper.convertUiToApiDate(uiDate);

    return EventModel(
      eventName: eventName,
      startTimeDate: startTimeIso,
      endTimeDate: endTimeIso,
      address: address,
      boothFee: int.tryParse(boothFee) ?? 0,
      boothSize: boothSize,
      boothSpace: boothSpace,
      date: apiDate,
      paid: paid,
      status: status,
      isActive: true, // Default to active
      description: description,
    );
  }

  /// Get start time in UI format (hh:mm a)
  String get startTimeUi {
    try {
      return DateTimeHelper.convertIsoToUiTime(startTimeDate);
    } catch (e) {
      return '12:00 PM'; // Fallback
    }
  }

  /// Get end time in UI format (hh:mm a)
  String get endTimeUi {
    try {
      return DateTimeHelper.convertIsoToUiTime(endTimeDate);
    } catch (e) {
      return '6:00 PM'; // Fallback
    }
  }

  /// Get date in UI format (MM/DD/YYYY)
  String get dateUi {
    try {
      return DateTimeHelper.convertApiToUiDate(date);
    } catch (e) {
      return DateTimeHelper.getCurrentUiDate(); // Fallback to current date
    }
  }

  /// Copy with method for updating EventModel
  EventModel copyWith({
    int? id,
    String? user,
    String? eventName,
    String? startTimeDate,
    String? endTimeDate,
    String? address,
    int? boothFee,
    String? boothSize,
    String? boothSpace,
    String? date,
    bool? paid,
    String? status,
    bool? isActive,
    String? description,
  }) {
    return EventModel(
      id: id ?? this.id,
      user: user ?? this.user,
      eventName: eventName ?? this.eventName,
      startTimeDate: startTimeDate ?? this.startTimeDate,
      endTimeDate: endTimeDate ?? this.endTimeDate,
      address: address ?? this.address,
      boothFee: boothFee ?? this.boothFee,
      boothSize: boothSize ?? this.boothSize,
      boothSpace: boothSpace ?? this.boothSpace,
      date: date ?? this.date,
      paid: paid ?? this.paid,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'EventModel(id: $id, user: $user, eventName: $eventName, address: $address, date: $date, paid: $paid, status: $status)';
  }
}
