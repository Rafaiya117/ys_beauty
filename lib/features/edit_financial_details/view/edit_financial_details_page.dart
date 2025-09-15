import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/edit_financial_details_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class EditFinancialDetailsPage extends StatelessWidget {
  final String? financialDetailsId;
  
  const EditFinancialDetailsPage({super.key, this.financialDetailsId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditFinancialDetailsViewModel()..loadFinancialDetails(financialDetailsId ?? '1'),
      child: Consumer<EditFinancialDetailsViewModel>(
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
                'Edit Financial Details',
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

  Widget _buildContent(EditFinancialDetailsViewModel viewModel) {
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

    if (viewModel.financialDetails == null) {
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
              'No financial details found',
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
      child: Column(
        children: [
          // Form Fields
          _buildInputField(
            icon: Icons.event,
            hintText: 'Enter Event',
            controller: viewModel.eventController,
            isRequired: true,
          ),
          
          SizedBox(height: 16.h),
          
          _buildInputField(
            icon: Icons.calendar_today,
            hintText: 'Enter Date',
            controller: viewModel.dateController,
          ),
          
          SizedBox(height: 16.h),
          
          _buildInputField(
            icon: Icons.aspect_ratio,
            hintText: 'Enter Booth Size',
            controller: viewModel.boothSizeController,
          ),
          
          SizedBox(height: 16.h),
          
          _buildInputField(
            icon: Icons.storefront,
            hintText: 'Enter Booth Fee',
            controller: viewModel.boothFeeController,
            keyboardType: TextInputType.number,
          ),
          
          SizedBox(height: 16.h),
          
          _buildInputField(
            icon: Icons.trending_up,
            hintText: 'Enter Gross Sales',
            controller: viewModel.grossSalesController,
            keyboardType: TextInputType.number,
            onChanged: (value) => viewModel.calculateNetProfit(),
          ),
          
          SizedBox(height: 16.h),
          
          _buildInputField(
            icon: Icons.receipt,
            hintText: 'Enter Expenses',
            controller: viewModel.expensesController,
            keyboardType: TextInputType.number,
            onChanged: (value) => viewModel.calculateNetProfit(),
          ),
          
          SizedBox(height: 16.h),
          
          _buildInputField(
            icon: Icons.account_balance_wallet,
            hintText: 'Enter Net Profit',
            controller: viewModel.netProfitController,
            keyboardType: TextInputType.number,
          ),
          
          SizedBox(height: 32.h),
          
          // Save Button
          _buildSaveButton(viewModel),
          
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
    bool isRequired = false,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8A00).withValues(alpha: 0.1),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: const Color(0xFFB8860B),
              ),
              if (isRequired)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Icon(
                    Icons.star,
                    size: 8.sp,
                    color: const Color(0xFFFF8A00),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.text,
              textAlignVertical: TextAlignVertical.center,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF424242),
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFFB8860B),
                  height: 1.2,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(EditFinancialDetailsViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 56.h,
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
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: viewModel.isSaving ? null : () => viewModel.saveFinancialDetails(),
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: viewModel.isSaving
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
