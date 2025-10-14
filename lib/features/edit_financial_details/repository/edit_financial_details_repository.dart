import 'dart:convert';

import 'package:animation/core/token_storage.dart';
import 'package:http/http.dart' as http;

import '../model/edit_financial_details_model.dart';

class EditFinancialDetailsRepository {
  final String _baseUrl = 'http://10.10.13.36'; 

  // Load financial details by ID
  Future<EditFinancialDetailsModel?> getFinancialDetailsById(String id) async {
    final accessToken = await TokenStorage.getAccessToken();
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/event/events/$id/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return EditFinancialDetailsModel(
          id: data['id'].toString(),
          event: data['event_name'] ?? '',
          date: data['date'] ?? '',
          boothSize: data['booth_size'] ?? '',
          boothFee: (data['booth_fee'] ?? 0).toDouble(),
          grossSales: (data['gross_sales'] ?? 0).toDouble(),
          expenses: (data['expenses'] ?? 0).toDouble(),
          netProfit: (data['net_profit'] ?? 0).toDouble(),
        );
      } else if (response.statusCode == 404) {
        return null; 
      } else {
        throw Exception('Failed to fetch financial details. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch financial details: $e');
    }
  }

  // Update financial details
  Future<bool> updateFinancialDetails(EditFinancialDetailsModel financialDetails) async {
    final accessToken = await TokenStorage.getAccessToken();
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/event/events/${financialDetails.id}/update/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', 
        },
        body: jsonEncode({
          "event": financialDetails.event,
          "date": financialDetails.date,
          "booth_size": financialDetails.boothSize,
          "booth_fee": financialDetails.boothFee,
          "gross_sales": financialDetails.grossSales,
          "expenses": financialDetails.expenses,
          "net_profit": financialDetails.netProfit,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}