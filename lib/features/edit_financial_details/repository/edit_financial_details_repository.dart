import '../model/edit_financial_details_model.dart';

class EditFinancialDetailsRepository {
  // Mock data for edit financial details
  List<EditFinancialDetailsModel> _financialDetails = [
    EditFinancialDetailsModel(
      id: '1',
      event: 'Birthday Party',
      date: '01 July 2025',
      boothSize: '10*10',
      boothFee: 100.00,
      grossSales: 200.00,
      expenses: 200.00,
      netProfit: 100.00,
    ),
    EditFinancialDetailsModel(
      id: '2',
      event: 'Concert',
      date: '31 Jun 2025',
      boothSize: '15*15',
      boothFee: 150.00,
      grossSales: 300.00,
      expenses: 100.00,
      netProfit: 200.00,
    ),
    EditFinancialDetailsModel(
      id: '3',
      event: 'Conference',
      date: '30 Jun 2025',
      boothSize: '20*20',
      boothFee: 200.00,
      grossSales: 500.00,
      expenses: 300.00,
      netProfit: 200.00,
    ),
    EditFinancialDetailsModel(
      id: '4',
      event: 'Friendly Party',
      date: '29 July 2025',
      boothSize: '12*12',
      boothFee: 120.00,
      grossSales: 400.00,
      expenses: 150.00,
      netProfit: 250.00,
    ),
    EditFinancialDetailsModel(
      id: '5',
      event: 'Wedding Reception',
      date: '28 July 2025',
      boothSize: '25*25',
      boothFee: 250.00,
      grossSales: 600.00,
      expenses: 200.00,
      netProfit: 400.00,
    ),
  ];

  Future<EditFinancialDetailsModel?> getFinancialDetailsById(String id) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _financialDetails.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateFinancialDetails(EditFinancialDetailsModel financialDetails) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 800));
    try {
      final index = _financialDetails.indexWhere((item) => item.id == financialDetails.id);
      if (index != -1) {
        _financialDetails[index] = financialDetails;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<EditFinancialDetailsModel>> getAllFinancialDetails() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _financialDetails;
  }
}
