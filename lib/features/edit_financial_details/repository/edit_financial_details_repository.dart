import 'dart:convert';
import 'package:animation/core/token_storage.dart';
import 'package:http/http.dart' as http;
import '../model/edit_financial_details_model.dart';

class EditFinancialDetailsRepository {
  final String _baseUrl = 'http://10.10.13.36';

  Future<EditFinancialDetailsModel?> getFinancialDetailsById(String id) async {
    final accessToken = await TokenStorage.getAccessToken();
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/finance/finance/$id/"),
        headers: {
          'Content-Type': 'application/json',
          if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        double grossSales = 0.0;
        double expenses = 0.0;

        if (data['sales_list'] != null) {
          for (var sale in data['sales_list']) {
            grossSales += (sale['sales'] ?? 0).toDouble();
          }
        }

        if (data['expence_list'] != null) {
          for (var expense in data['expence_list']) {
            expenses += (expense['expence'] ?? 0).toDouble();
          }
        }

        double netProfit = grossSales - expenses;

        return EditFinancialDetailsModel(
          id: data['id'].toString(),
          event: data['name'] ?? '',
          date: data['date'] ?? '',
          boothSize: data['booth_size'] ?? '',
          boothFee: (data['booth_fee'] ?? 0).toDouble(),
          grossSales: grossSales,
          expenses: expenses,
          netProfit: netProfit,
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
  Future<EditFinancialDetailsModel?> updateFinancialDetails(EditFinancialDetailsModel financialDetails) async {
  final accessToken = await TokenStorage.getAccessToken();
  try {
    final response = await http.put(
      Uri.parse("$_baseUrl/finance/finance/edit/${financialDetails.id}/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "name": financialDetails.event,
        "date": financialDetails.date,
        "booth_size": financialDetails.boothSize,
        "booth_fee": financialDetails.boothFee,
        "gross_sale": financialDetails.grossSales,
        "expenses": financialDetails.expenses,
      }),
    );

    print("API Response Code: ${response.statusCode}");
    print("API Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final data = body['data'];
      return EditFinancialDetailsModel(
        id: data['id'].toString(),
        event: data['name']?.toString() ?? '',
        date: data['date']?.toString() ?? '',
        boothSize: data['booth_size']?.toString() ?? '',
        boothFee: (data['booth_fee'] as num).toDouble(),
        grossSales: (data['gross_sale'] != null ? (data['gross_sale'] as num).toDouble() : 0.0),
        expenses: (data['expenses'] != null ? (data['expenses'] as num).toDouble() : 0.0),
        netProfit: ((data['gross_sale'] != null ? (data['gross_sale'] as num).toDouble() : 0.0)
        - (data['expenses'] != null ? (data['expenses'] as num).toDouble() : 0.0)),
      );
    } else {
      return null;
    }
  } catch (e) {
    print("Update financial details error: $e");
    return null;
  }
}
}
