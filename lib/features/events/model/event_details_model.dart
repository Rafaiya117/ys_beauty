import 'package:flutter/material.dart';

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

  factory EventDetailsModel.fromEvent(dynamic event) {
    return EventDetailsModel(
      id: event.id ?? '1',
      title: event.title ?? 'Event Title',
      description: event.description ?? 'Join us for an unforgettable evening as we celebrate John\'s milestone 30th birthday! This vibrant birthday party will feature an exciting mix of games, music, delicious food, and a cocktail bar. The night will kick off with a live DJ performance, followed by a birthday toast.',
      status: event.status ?? ['Pending', 'Unpaid'],
      date: event.date ?? 'July 25, 2025',
      location: event.location ?? 'Bardessono - Yountville, CA',
      fee: event.cost ?? '\$200',
      spaceNumber: event.spaceNumber ?? '12',
      boothSize: event.boothSize ?? '10*10',
      startTime: event.startTime ?? '12:00 PM',
      endTime: event.endTime ?? '6:00 PM',
    );
  }
}
