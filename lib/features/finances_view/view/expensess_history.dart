import 'package:animation/features/finances_view/custom_widget/custom_expenss_card.dart';
import 'package:animation/features/finances_view/viewmodel/finances_view_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesHistoryPage extends StatelessWidget {
  const ExpensesHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FinancesViewViewModel()..loadFinancesView('1'),
      child: Consumer<FinancesViewViewModel>(
        builder: (context, viewModel, child) {
          return ExpenseHistoryPage(
            title: 'Expenses History',
            events: viewModel.expensesEvents,
          );
        },
      ),
    );
  }
}
