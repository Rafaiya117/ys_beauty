import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/finances_view_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../core/router.dart';

class FinancesViewPage extends StatelessWidget {
  final String? eventId;
  
  const FinancesViewPage({super.key, this.eventId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinancesViewViewModel()..loadFinancesView(eventId ?? '1'),
      child: Consumer<FinancesViewViewModel>(
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
                    
                    // Content
                    Expanded(
                      child: _buildContent(viewModel),
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
          
          // Title - Centered
          Expanded(
            child: Center(
              child: Text(
                'Finances',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          
          // Spacer to balance the back button
          SizedBox(width: 24.w),
        ],
      ),
    );
  }

  Widget _buildContent(FinancesViewViewModel viewModel) {
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

    if (viewModel.financesData == null) {
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
              'No finance data found',
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF757575),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: _buildFinanceCard(viewModel.financesData!),
    );
  }

  Widget _buildFinanceCard(financesData) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(AppConstants.cardBgPath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Title and Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                financesData.eventName,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Date: ${financesData.date}',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Event Details - Two Column Layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Booth Size:', financesData.boothSize),
                    SizedBox(height: 16.h),
                    _buildDetailRow('Booth Fee:', '\$${financesData.boothFee.toStringAsFixed(0)}'),
                    SizedBox(height: 24.h),
                    Text(
                      'Net Profit: \$${financesData.netProfit.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 20.w),
              
              // Right Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Event Sales:', '\$${financesData.eventSales.toStringAsFixed(0)}'),
                    SizedBox(height: 16.h),
                    _buildDetailRow('Event Expenses:', '\$${financesData.eventExpenses.toStringAsFixed(0)}'),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 32.h),
          
          // Edit Button - Centered
          Center(
            child: _buildEditButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton() {
    return GestureDetector(
      onTap: () {
        // Navigate to Edit Financial Details screen
        AppRouter.navigateToEditFinancialDetails(financialDetailsId: eventId);
      },
      child: Container(
        width: 400.w,
        height: 60.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF8A00), Color(0xFFFFC107)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF8A00).withValues(alpha: 0.3),
              blurRadius: 6.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Edit',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
