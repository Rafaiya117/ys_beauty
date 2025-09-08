import '../model/finance_history_model.dart';

class FinanceHistoryRepository {
  // Mock data for finance history
  List<FinanceHistoryModel> _financeHistory = [
    FinanceHistoryModel(
      id: '1',
      eventName: 'Birthday Party',
      date: '01 July 2025',
      amount: 500.00,
      type: 'sale',
      description: 'Event sales revenue',
    ),
    FinanceHistoryModel(
      id: '2',
      eventName: 'Concert',
      date: '31 Jun 2025',
      amount: 200.00,
      type: 'sale',
      description: 'Concert ticket sales',
    ),
    FinanceHistoryModel(
      id: '3',
      eventName: 'Conference',
      date: '30 Jun 2025',
      amount: 100.00,
      type: 'expense',
      description: 'Conference setup costs',
    ),
    FinanceHistoryModel(
      id: '4',
      eventName: 'Friendly Party',
      date: '29 July 2025',
      amount: 400.00,
      type: 'sale',
      description: 'Party event revenue',
    ),
    FinanceHistoryModel(
      id: '5',
      eventName: 'Wedding Reception',
      date: '28 July 2025',
      amount: 750.00,
      type: 'sale',
      description: 'Wedding event sales',
    ),
    FinanceHistoryModel(
      id: '6',
      eventName: 'Corporate Event',
      date: '27 July 2025',
      amount: 150.00,
      type: 'booth_fee',
      description: 'Booth rental fee',
    ),
    FinanceHistoryModel(
      id: '7',
      eventName: 'Music Festival',
      date: '26 July 2025',
      amount: 300.00,
      type: 'expense',
      description: 'Equipment rental',
    ),
    FinanceHistoryModel(
      id: '8',
      eventName: 'Art Exhibition',
      date: '25 July 2025',
      amount: 250.00,
      type: 'sale',
      description: 'Exhibition ticket sales',
    ),
    FinanceHistoryModel(
      id: '9',
      eventName: 'Food Festival',
      date: '24 July 2025',
      amount: 180.00,
      type: 'booth_fee',
      description: 'Food booth rental',
    ),
    FinanceHistoryModel(
      id: '10',
      eventName: 'Charity Gala',
      date: '23 July 2025',
      amount: 600.00,
      type: 'sale',
      description: 'Gala event revenue',
    ),
    FinanceHistoryModel(
      id: '11',
      eventName: 'Tech Conference',
      date: '22 July 2025',
      amount: 120.00,
      type: 'expense',
      description: 'Conference materials',
    ),
    FinanceHistoryModel(
      id: '12',
      eventName: 'Sports Event',
      date: '21 July 2025',
      amount: 350.00,
      type: 'sale',
      description: 'Sports event tickets',
    ),
  ];

  Future<List<FinanceHistoryModel>> getFinanceHistory() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _financeHistory;
  }

  Future<FinanceHistoryModel?> getFinanceHistoryById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _financeHistory.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<FinanceHistoryModel>> getFinanceHistoryByType(String type) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _financeHistory.where((item) => item.type == type).toList();
  }
}
