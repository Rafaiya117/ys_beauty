import '../model/finances_view_model.dart';

class FinancesViewRepository {
  // Mock data for finances view
  List<FinancesViewModel> _financesData = [
    FinancesViewModel(
      id: '1',
      eventName: 'Birthday Party',
      date: '01 July 2025',
      boothSize: '10*10',
      boothFee: 100.00,
      eventSales: 200.00,
      eventExpenses: 200.00,
      netProfit: 100.00,
    ),
    FinancesViewModel(
      id: '2',
      eventName: 'Concert',
      date: '31 Jun 2025',
      boothSize: '15*15',
      boothFee: 150.00,
      eventSales: 300.00,
      eventExpenses: 100.00,
      netProfit: 200.00,
    ),
    FinancesViewModel(
      id: '3',
      eventName: 'Conference',
      date: '30 Jun 2025',
      boothSize: '20*20',
      boothFee: 200.00,
      eventSales: 500.00,
      eventExpenses: 300.00,
      netProfit: 200.00,
    ),
    FinancesViewModel(
      id: '4',
      eventName: 'Friendly Party',
      date: '29 July 2025',
      boothSize: '12*12',
      boothFee: 120.00,
      eventSales: 400.00,
      eventExpenses: 150.00,
      netProfit: 250.00,
    ),
    FinancesViewModel(
      id: '5',
      eventName: 'Wedding Reception',
      date: '28 July 2025',
      boothSize: '25*25',
      boothFee: 250.00,
      eventSales: 750.00,
      eventExpenses: 200.00,
      netProfit: 550.00,
    ),
    FinancesViewModel(
      id: '6',
      eventName: 'Corporate Event',
      date: '27 July 2025',
      boothSize: '18*18',
      boothFee: 180.00,
      eventSales: 600.00,
      eventExpenses: 250.00,
      netProfit: 350.00,
    ),
    FinancesViewModel(
      id: '7',
      eventName: 'Music Festival',
      date: '26 July 2025',
      boothSize: '30*30',
      boothFee: 300.00,
      eventSales: 800.00,
      eventExpenses: 400.00,
      netProfit: 400.00,
    ),
    FinancesViewModel(
      id: '8',
      eventName: 'Art Exhibition',
      date: '25 July 2025',
      boothSize: '16*16',
      boothFee: 160.00,
      eventSales: 350.00,
      eventExpenses: 100.00,
      netProfit: 250.00,
    ),
    FinancesViewModel(
      id: '9',
      eventName: 'Food Festival',
      date: '24 July 2025',
      boothSize: '14*14',
      boothFee: 140.00,
      eventSales: 450.00,
      eventExpenses: 180.00,
      netProfit: 270.00,
    ),
    FinancesViewModel(
      id: '10',
      eventName: 'Charity Gala',
      date: '23 July 2025',
      boothSize: '22*22',
      boothFee: 220.00,
      eventSales: 600.00,
      eventExpenses: 150.00,
      netProfit: 450.00,
    ),
  ];

  Future<FinancesViewModel?> getFinancesView(String id) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _financesData.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<FinancesViewModel>> getAllFinancesView() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _financesData;
  }
}
