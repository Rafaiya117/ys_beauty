import 'package:flutter/material.dart';

class RemindersModel {
  final bool isLoading;
  final String? errorMessage;
  final List<ReminderItem> reminders;

  RemindersModel({
    this.isLoading = false,
    this.errorMessage,
    this.reminders = const [],
  });

  RemindersModel copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ReminderItem>? reminders,
  }) {
    return RemindersModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      reminders: reminders ?? this.reminders,
    );
  }
}

class ReminderItem {
  final String id;
  final String title;
  final String date;
  final String status;
  final Color cardColor;

  ReminderItem({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.cardColor,
  });
}
