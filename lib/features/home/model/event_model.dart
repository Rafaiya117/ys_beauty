class Event {
  final int id;
  final String eventName;
  final String startTimeDate;
  final String endTimeDate;
  final String? address;
  final double boothFee;
  final String boothSize;
  final String boothSpace;
  final String date;
  final bool paid;
  final String? status;

  Event({
    required this.id,
    required this.eventName,
    required this.startTimeDate,
    required this.endTimeDate,
    this.address,
    required this.boothFee,
    required this.boothSize,
    required this.boothSpace,
    required this.date,
    required this.paid,
    this.status,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      eventName: json['event_name'] ?? '',
      startTimeDate: json['start_time_date'] ?? '',
      endTimeDate: json['end_time_date'] ?? '',
      address: json['address'],
      boothFee: (json['booth_fee'] as num?)?.toDouble() ?? 0,
      boothSize: json['booth_size'] ?? '',
      boothSpace: json['booth_space'] ?? '',
      date: json['date'] ?? '',
      paid: json['paid'] ?? false,
      status: json['status'],
    );
  }
}
