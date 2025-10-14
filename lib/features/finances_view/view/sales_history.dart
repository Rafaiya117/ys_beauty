import 'package:animation/features/finances_view/custom_widget/custom_history_card.dart';
import 'package:animation/features/finances_view/viewmodel/finances_view_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesHistoryPage extends StatelessWidget {
  const SalesHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FinancesViewViewModel()..loadFinancesView('1'),
      child: Consumer<FinancesViewViewModel>(
        builder: (context, viewModel, child) {
          return HistoryPage(
            title: 'Sales History',
            events: viewModel.salesEvents,
          );
        },
      ),
    );
  }
}
