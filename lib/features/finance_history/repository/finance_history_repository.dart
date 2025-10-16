import '../model/finance_history_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animation/core/token_storage.dart';


class FinanceHistoryRepository {
  final String _baseUrl = 'http://10.10.13.36'; 
  Future<List<FinanceHistoryModel>> getFinanceHistory() async {
    final accessToken = await TokenStorage.getAccessToken();

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/finance/finance/list/'),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        print('Finance history response: ${response.body}');

        return jsonData.map((e) => FinanceHistoryModel.fromJson(e)).toList();
      } else {
        print('Failed to load finance history: ${response.statusCode}');
        throw Exception('Failed to load finance history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching finance history: $e');
      throw Exception('Error fetching finance history: $e');
    }
  }

  Future<FinanceHistoryModel?> getFinanceHistoryById(String id) async {
    final accessToken = await TokenStorage.getAccessToken();
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/event/finance/history/$id/'),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return FinanceHistoryModel.fromJson(data);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load finance history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading finance history by ID: $e');
    }
  }

  Future<List<FinanceHistoryModel>> getFinanceHistoryByType(String type) async {
    final accessToken = await TokenStorage.getAccessToken();

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/event/finance/history/?type=$type'),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((e) => FinanceHistoryModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
