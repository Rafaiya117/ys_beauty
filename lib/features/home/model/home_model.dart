import 'package:animation/features/home/model/event_model.dart';

class HomeModel {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final List<Event> events; // Today events
  final List<Event> upcomingEvents; // Upcoming events

  const HomeModel({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.events = const [],
    this.upcomingEvents = const [],
  });

  HomeModel copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    List<Event>? events,
    List<Event>? upcomingEvents,
  }) {
    return HomeModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      events: events ?? this.events,
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
    );
  }
}


