class AvailableEventModel {
  final String id;
  final String title;
  final String location;
  final String boothSize;
  final String spaceNumber;
  final String cost;
  final String startTime;
  final String endTime;
  final List<String> status;
  final DateTime eventDate;

  const AvailableEventModel({
    required this.id,
    required this.title,
    required this.location,
    required this.boothSize,
    required this.spaceNumber,
    required this.cost,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.eventDate,
  });

  AvailableEventModel copyWith({
    String? id,
    String? title,
    String? location,
    String? boothSize,
    String? spaceNumber,
    String? cost,
    String? startTime,
    String? endTime,
    List<String>? status,
    DateTime? eventDate,
  }) {
    return AvailableEventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      boothSize: boothSize ?? this.boothSize,
      spaceNumber: spaceNumber ?? this.spaceNumber,
      cost: cost ?? this.cost,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      eventDate: eventDate ?? this.eventDate,
    );
  }

  @override
  String toString() {
    return 'AvailableEventModel(id: $id, title: $title, location: $location, boothSize: $boothSize, spaceNumber: $spaceNumber, cost: $cost, startTime: $startTime, endTime: $endTime, status: $status, eventDate: $eventDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AvailableEventModel &&
        other.id == id &&
        other.title == title &&
        other.location == location &&
        other.boothSize == boothSize &&
        other.spaceNumber == spaceNumber &&
        other.cost == cost &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.status == status &&
        other.eventDate == eventDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        location.hashCode ^
        boothSize.hashCode ^
        spaceNumber.hashCode ^
        cost.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        status.hashCode ^
        eventDate.hashCode;
  }
}
