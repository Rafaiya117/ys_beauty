class EditEventModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String location;
  final String fee;
  final String spaceNumber;
  final String boothSize;
  final String startTime;
  final String endTime;
  final List<String> status;
  final bool isPaid;
  final String reminder;

  EditEventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.fee,
    required this.spaceNumber,
    required this.boothSize,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.isPaid,
    required this.reminder,
  });

  factory EditEventModel.fromEventDetails(dynamic eventDetails) {
    return EditEventModel(
      id: eventDetails.id,
      title: eventDetails.title,
      description: eventDetails.description,
      date: eventDetails.date,
      location: eventDetails.location,
      fee: eventDetails.fee,
      spaceNumber: eventDetails.spaceNumber,
      boothSize: eventDetails.boothSize,
      startTime: eventDetails.startTime,
      endTime: eventDetails.endTime,
      status: eventDetails.status,
      isPaid: eventDetails.status.contains('Paid'),
      reminder: 'Set Reminder', // Default value
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'location': location,
      'fee': fee,
      'spaceNumber': spaceNumber,
      'boothSize': boothSize,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'isPaid': isPaid,
      'reminder': reminder,
    };
  }
}
