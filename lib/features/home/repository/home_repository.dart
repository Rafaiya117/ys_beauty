import 'dart:convert';
import 'package:animation/core/token_storage.dart';
import 'package:animation/features/home/model/event_model.dart';
import 'package:animation/features/home/model/home_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:animation/core/token_storage.dart';
import 'package:animation/features/home/model/event_model.dart';
import 'package:animation/features/home/model/home_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  final _baseUrl = "http://10.10.13.36";

  Future<HomeModel> getHomeData() async {
    final accessToken = await TokenStorage.getAccessToken();
    debugPrint("Fetching today's events...");
    debugPrint("Access token: $accessToken");

    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/event/events/today_event_list"),
        headers: {
          "Content-Type": "application/json",
          'accept': 'application/json',
          if (accessToken != null) "Authorization": "Bearer $accessToken",
        },
      );

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final events = jsonData.map((e) => Event.fromJson(e)).toList();
        debugPrint("Parsed ${events.length} today events");

        return HomeModel(
          successMessage: 'Home data loaded successfully',
          events: events,
        );
      } else {
        debugPrint("Failed to load today's events: ${response.statusCode}");
        return HomeModel(
          errorMessage: 'Failed to load home data: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Error fetching today's events: $e");
      return HomeModel(
        errorMessage: 'Failed to load home data: $e',
      );
    }
  }

  Future<List<Event>> getUpcomingEvents() async {
  final accessToken = await TokenStorage.getAccessToken();
  debugPrint("Fetching upcoming events...");
  debugPrint("Access token: $accessToken");

  try {
    final response = await http.get(
      Uri.parse("$_baseUrl/event/events/upcomming_event_list"), // ✅ correct spelling
      headers: {
        "Content-Type": "application/json",
        'accept': 'application/json',
        if (accessToken != null) "Authorization": "Bearer $accessToken",
      },
    );

    debugPrint("Response Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final events = jsonData.map((e) => Event.fromJson(e)).toList();
      debugPrint("Parsed ${events.length} upcoming events");
      return events;
    } else {
      debugPrint("Failed to load upcoming events: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    debugPrint("Error fetching upcoming events: $e");
    return [];
  }
}
}