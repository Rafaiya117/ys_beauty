import 'package:animation/features/edit_financial_details/model/edit_financial_details_model.dart';
import 'package:animation/features/edit_financial_details/repository/edit_financial_details_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/edit_financial_details_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class EditFinancialDetailsPage extends StatelessWidget {
  final String? financialDetailsId;
  
  const EditFinancialDetailsPage({super.key, this.financialDetailsId});

  @override
  Widget build(BuildContext context) {
    // Get arguments safely
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final onUpdate = args?['onUpdate'] as Function?;
    final financialDetailsId = args?['financialDetailsId'] as String?;

    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = EditFinancialDetailsViewModel();
        if (financialDetailsId != null) {
          viewModel.loadFinancialDetailsById(financialDetailsId);
        }
        return viewModel;
      },
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
                      child: _buildContent(viewModel, context, onUpdate: onUpdate),
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
            child:SvgPicture.asset(
              'assets/icons/back_button.svg',
              width:16.w,
              height: 12.h,
            ),
            // Icon(
            //   Icons.arrow_back_ios,
            //   size: 24.sp,
            //   color: Colors.black,
            // ),
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

  Widget _buildContent(EditFinancialDetailsViewModel viewModel, BuildContext context ,{Function? onUpdate}) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: const Color(0xFF757575)),
            SizedBox(height: 16.h),
            Text(viewModel.error!,
              style: TextStyle(fontSize: 16.sp, color: const Color(0xFF757575)),
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
            Icon(Icons.receipt_long_outlined, size: 48.sp, color: const Color(0xFF757575)),
            SizedBox(height: 16.h),
            Text('No financial details found',
              style: TextStyle(fontSize: 16.sp, color: const Color(0xFF757575)),
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
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enter Event',
              style:GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Colors.black
              )
            ),
          ),
          SizedBox(height: 5.h,),
          _buildInputField(
            icon: 'assets/icons/edit_eventname.svg',
            hintText: 'Event',
            controller: viewModel.eventController,
            readOnly: false, // Editable now
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Event Date',
              style:GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Colors.black
              )
            ),
          ),
          SizedBox(height: 5.h,),
          _buildInputField(
            icon: 'assets/icons/create_event_date.svg',
            hintText: 'Date',
            controller: viewModel.dateController,
            readOnly: false, // Editable now
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enter Booth Size',
              style:GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Colors.black
              )
            ),
          ),
          SizedBox(height: 5.h,),
          _buildInputField(
            icon:'assets/icons/create_booth_size.svg',
            hintText: 'Booth Size',
            controller: viewModel.boothSizeController,
            readOnly: false, // Editable now
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enter Booth Fee',
              style:GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Colors.black
              )
            ),
          ),
          SizedBox(height: 5.h,),
          _buildInputField(
            icon: 'assets/icons/create_event_booth.svg',
            hintText: 'Booth Fee',
            controller: viewModel.boothFeeController,
            keyboardType: TextInputType.number,
            readOnly: false, // Editable now
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enter Gross Sale',
              style:GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Colors.black
              )
            ),
          ),
          SizedBox(height: 5.h,),
          _buildInputField(
            icon: 'assets/icons/gross_sale.svg',
            hintText: 'Gross Sales',
            controller: viewModel.grossSalesController,
            keyboardType: TextInputType.number,
            readOnly: false, // Editable
            onChanged: (value) => viewModel.calculateNetProfit(),
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enter Expenses',
              style:GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Colors.black
              )
            ),
          ),
          SizedBox(height: 5.h,),
          _buildInputField(
            icon: 'assets/icons/expenses.svg',
            hintText: 'Expenses',
            controller: viewModel.expensesController,
            keyboardType: TextInputType.number,
            readOnly: false, // Editable
            onChanged: (value) => viewModel.calculateNetProfit(),
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enter Net Profit',
              style:GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Colors.black
              )
            ),
          ),
          SizedBox(height: 5.h,),
          _buildInputField(
            icon: 'assets/icons/net_profit.svg',
            hintText: 'Net Profit',
            controller: viewModel.netProfitController,
            keyboardType: TextInputType.number,
            readOnly: false,
          ),
          SizedBox(height: 32.h),
          // Save Button
          _buildSaveButton(viewModel, onUpdate: onUpdate, context: context),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildInputField({
  required dynamic icon, // can be IconData or SVG asset path
  required String hintText,
  required TextEditingController controller,
  bool readOnly = false,
  TextInputType? keyboardType,
  Function(String)? onChanged,
}) {
  return Container(
    height: 56.h,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3C4),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: const Color(0xFFFFE793), width: 1.w),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 👇 Only this part changed
        if (icon is IconData)
          Icon(icon, size: 20.sp, color: const Color(0xFF363636))
        else if (icon is String)
          SvgPicture.asset(
            icon,
            width: 20.w,
            height: 20.h,
            colorFilter: const ColorFilter.mode(Color(0xFF363636), BlendMode.srcIn),
          ),

        SizedBox(width: 12.w),

        Expanded(
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            keyboardType: keyboardType ?? TextInputType.text,
            onChanged: onChanged,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: readOnly
                  ? const Color(0xFFB8860B)
                  : const Color(0xFF424242), // Orange for readonly
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

Widget _buildSaveButton(
  EditFinancialDetailsViewModel viewModel, {
  Function? onUpdate,
  required BuildContext context,
}) {
  return Container(
    width: double.infinity,
    height: 56.h,
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFFFFA267), Color(0xFFFFDF6F)]),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () async {
          await viewModel.saveFinancialDetails(); // ✅ Use existing function
          if (viewModel.isSuccess) {                // ✅ Use your existing success flag
            Navigator.of(context).pop();
            if (onUpdate != null) onUpdate();
          } else if (viewModel.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(viewModel.error!)),
            );
          }
        },
        child: Center(
          child: Text(
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