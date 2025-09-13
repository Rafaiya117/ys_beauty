class CreateEventModel {
  final bool isLoading;
  final String? errorMessage;
  final String event;
  final String location;
  final String boothFee;
  final String boothSize;
  final String spaceNumber;
  final String date;
  final String reminder;
  final String? selectedStatus;
  final bool? isPaid;
  final String description;
  final String startTime;
  final String endTime;

  CreateEventModel({
    this.isLoading = false,
    this.errorMessage,
    this.event = '',
    this.location = '',
    this.boothFee = '',
    this.boothSize = '',
    this.spaceNumber = '',
    this.date = '',
    this.reminder = '',
    this.selectedStatus,
    this.isPaid,
    this.description = '',
    this.startTime = '12:00 PM',
    this.endTime = '6:00 PM',
  });

  CreateEventModel copyWith({
    bool? isLoading,
    String? errorMessage,
    String? event,
    String? location,
    String? boothFee,
    String? boothSize,
    String? spaceNumber,
    String? date,
    String? reminder,
    String? selectedStatus,
    bool? isPaid,
    String? description,
    String? startTime,
    String? endTime,
  }) {
    return CreateEventModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      event: event ?? this.event,
      location: location ?? this.location,
      boothFee: boothFee ?? this.boothFee,
      boothSize: boothSize ?? this.boothSize,
      spaceNumber: spaceNumber ?? this.spaceNumber,
      date: date ?? this.date,
      reminder: reminder ?? this.reminder,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isPaid: isPaid ?? this.isPaid,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
