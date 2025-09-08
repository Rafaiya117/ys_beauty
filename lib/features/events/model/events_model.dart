import 'package:flutter/material.dart';

class EventsModel {
  final bool isLoading;
  final String? errorMessage;
  final List<EventItem> events;
  final String selectedTab;
  final String searchQuery;

  EventsModel({
    this.isLoading = false,
    this.errorMessage,
    this.events = const [],
    this.selectedTab = 'Today',
    this.searchQuery = '',
  });

  EventsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    List<EventItem>? events,
    String? selectedTab,
    String? searchQuery,
  }) {
    return EventsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
      selectedTab: selectedTab ?? this.selectedTab,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class EventItem {
  final String id;
  final String title;
  final String location;
  final String boothSize;
  final String spaceNumber;
  final String cost;
  final String startTime;
  final String endTime;
  final String date;
  final List<String> status;
  final String category; // Today, Upcoming, Past

  EventItem({
    required this.id,
    required this.title,
    required this.location,
    required this.boothSize,
    required this.spaceNumber,
    required this.cost,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.status,
    required this.category,
  });
}
