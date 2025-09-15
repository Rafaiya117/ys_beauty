import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/finance_history_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../core/router.dart';

class FinanceHistoryPage extends StatelessWidget {
  const FinanceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinanceHistoryViewModel()..loadFinanceHistory(),
      child: Consumer<FinanceHistoryViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.backgroundImagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Header
                    _buildHeader(context),
                    
                    SizedBox(height: 20.h),
                    
                    // Finance History List
                    Expanded(
                      child: _buildFinanceHistoryList(viewModel),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios,
              size: 24.sp,
              color: Colors.black,
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Title
          Text(
            'Finance History',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildFinanceHistoryList(FinanceHistoryViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (viewModel.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: const Color(0xFF757575),
            ),
            SizedBox(height: 16.h),
            Text(
              viewModel.error!,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF757575),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => viewModel.refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final filteredHistory = viewModel.financeHistory;

    if (filteredHistory.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48.sp,
              color: const Color(0xFF757575),
            ),
            SizedBox(height: 16.h),
            Text(
              'No transactions found',
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF757575),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.refresh(),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: filteredHistory.length,
        itemBuilder: (context, index) {
          final item = filteredHistory[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3C4),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 1.w,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.eventName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.date,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => AppRouter.navigateToFinancesView(eventId: item.id),
                      child: Icon(
                        Icons.visibility,
                        size: 20.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$${item.amount.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
