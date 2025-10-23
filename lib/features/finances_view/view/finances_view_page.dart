import 'package:animation/features/edit_financial_details/view/edit_financial_details_page.dart';
import 'package:animation/features/finances_view/view/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/finances_view_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../core/router.dart';

// class FinancesViewPage extends StatelessWidget {
//   final String? eventId;
  
//   const FinancesViewPage({super.key, this.eventId});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => FinancesViewViewModel()..loadFinancesView(eventId ?? '1'),
//       child: Consumer<FinancesViewViewModel>(
//         builder: (context, viewModel, child) {
//           return Scaffold(
//             body: Container(
//               width: double.infinity,
//               height: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(AppConstants.backgroundImagePath),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: SafeArea(
//                 child: Column(
//                   children: [
//                     // Header
//                     _buildHeader(context),                    
//                     SizedBox(height: 20.h),                    
//                     // Content
//                     Expanded(
//                       child: _buildContent(viewModel),
//                     ),
//                     SizedBox(height: 20.h,),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//       child: Row(
//         children: [
//           // Back button
//           GestureDetector(
//             onTap: () => Navigator.of(context).pop(),
//             child: Icon(
//               Icons.arrow_back_ios,
//               size: 24.sp,
//               color: Colors.black,
//             ),
//           ),
          
//           // Title - Centered
//           Expanded(
//             child: Center(
//               child: Text(
//                 'Finances',
//                 style: TextStyle(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
          
//           // Spacer to balance the back button
//           SizedBox(width: 24.w),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent(FinancesViewViewModel viewModel) {
//     if (viewModel.isLoading) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }

//     if (viewModel.error != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 48.sp,
//               color: const Color(0xFF757575),
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               viewModel.error!,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: const Color(0xFF757575),
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16.h),
//             ElevatedButton(
//               onPressed: () => viewModel.refresh(),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     if (viewModel.financesData == null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.receipt_long_outlined,
//               size: 48.sp,
//               color: const Color(0xFF757575),
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               'No finance data found',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: const Color(0xFF757575),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Column(
//         children: [
//            _buildFinanceCard(viewModel.financesData!),
//            SizedBox(height: 20.h,),
//            Column(
//              children: [
//                Text(
//                 'Sales',
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color:Colors.black
//                 ),
//               ),
//               //!----------------Event Cards -----------------!
//               SizedBox(height: 20.h,),
//               _buildSalesEventCard(
//                 amount: '\$500', 
//                 title: 'Birthday Party', 
//                 date: '01 June,2025',
//                 onEdit: () {
                  
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _buildFinanceCard(financesData) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         image: const DecorationImage(
//           image: AssetImage(AppConstants.cardBgPath),
//           fit: BoxFit.cover,
//         ),
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 10.r,
//             offset: Offset(0, 4.h),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Event Title and Date
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 financesData.eventName,
//                 style: TextStyle(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 'Date: ${financesData.date}',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
          
//           SizedBox(height: 24.h),
          
//           // Event Details - Two Column Layout
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Left Column
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildDetailRow('Booth Size:', financesData.boothSize),
//                     SizedBox(height: 16.h),
//                     _buildDetailRow('Booth Fee:', '\$${financesData.boothFee.toStringAsFixed(0)}'),
//                     SizedBox(height: 24.h),
//                     Text(
//                       'Net Profit: \$${financesData.netProfit.toStringAsFixed(0)}',
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
              
//               SizedBox(width: 20.w),
              
//               // Right Column
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildDetailRow('Event Sales:', '\$${financesData.eventSales.toStringAsFixed(0)}'),
//                     SizedBox(height: 16.h),
//                     _buildDetailRow('Event Expenses:', '\$${financesData.eventExpenses.toStringAsFixed(0)}'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
          
//           SizedBox(height: 32.h),
          
//           // Edit Button - Centered
//           Center(
//             child: _buildEditButton(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Colors.black.withValues(alpha: 0.7),
//           ),
//         ),
//         SizedBox(height: 4.h),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEditButton() {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to Edit Financial Details screen
//         AppRouter.navigateToEditFinancialDetails(financialDetailsId: eventId);
//       },
//       child: Container(
//         width: 400.w,
//         height: 60.h,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFFFF8A00), Color(0xFFFFC107)],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           borderRadius: BorderRadius.circular(12.r),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFFFF8A00).withValues(alpha: 0.3),
//               blurRadius: 6.r,
//               offset: Offset(0, 3.h),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             'Edit',
//             style: TextStyle(
//               fontSize: 22.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//  Widget _buildSalesEventCard({
//   required String title,
//   required String date,
//   required String amount,
//   VoidCallback? onEdit,
//   Color? backgroundColor,
// }) {
//   return Container(
//     width: double.infinity,
//     decoration: BoxDecoration(
//       color: backgroundColor ?? const Color(0xFFFEF4D3),
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: const Color(0xFFFFE9A3), width: 1),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           // Top row (title + edit icon)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                   fontSize: 14.sp,
//                 ),
//               ),
//               if (onEdit != null)
//                 GestureDetector(
//                   onTap: onEdit,
//                   child: SvgPicture.asset(
//                     'assets/icons/edit_icon.svg',
//                     width: 12.w,
//                     height: 12.h,
//                   ),
//                 ),
//             ],
//           ),

//           // Bottom row (date + amount)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   date,
//                   style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 10.sp,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               Text(
//                 amount,
//                 style: GoogleFonts.poppins(
//                   fontSize: 16.sp,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }
class FinancesViewPage extends StatelessWidget {
  final String eventId;

  const FinancesViewPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>FinancesViewViewModel()..loadFinancesView(eventId),
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
                    _buildHeader(context),
                    SizedBox(height: 20.h),
                    Expanded(child: _buildContent(viewModel)),
                    SizedBox(height: 20.h),
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
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child:SvgPicture.asset(
              'assets/icons/back_button.svg',
              width:16.w,
              height: 12.h,
            ),
            //Icon(Icons.arrow_back_ios, size: 24.sp, color: Colors.black),
          ),
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
          SizedBox(width: 24.w),
        ],
      ),
    );
  }

  Widget _buildContent(FinancesViewViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
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
          _buildFinanceCard(viewModel.financesData!,viewModel),
          SizedBox(height: 20.h),

          // ------------------ SALES SECTION ------------------
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sales',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      AppRouter.navigateToSalesHistory();
                    },
                    child:Text(
                      'See all',
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black, 
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.salesEvents.length,
                itemBuilder: (context, index) {
                  final event = viewModel.salesEvents[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: _buildSalesEventCard(
                      title: event.title,
                      date: event.date,
                      amount: event.amount,
                      onEdit: () async {
                        final updatedEvent = await showDialog<SalesEvent>(
                          context: context,
                          builder: (context) => EditSalesEventDialog(event: event),
                        );
                        if (updatedEvent != null) {
                          viewModel.updateSalesEvent(index, updatedEvent);
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),

          SizedBox(height: 30.h),

          // ------------------ EXPENSES SECTION ------------------
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expenses',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      AppRouter.navigateToExpenssHistory();
                    },
                    child:Text(
                      'See all',
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black, 
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.expensesEvents.length,
                itemBuilder: (context, index) {
                  final event = viewModel.expensesEvents[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: _buildSalesEventCard(
                      title: event.title,
                      date: event.date,
                      amount: event.amount,
                      onEdit: () async {
                        // Show dialog for editing ExpenseEvent
                        final updatedEvent = await showDialog<ExpenseEvent>(
                          context: context,
                          builder: (context) =>EditExpenseEventDialog(event: event),
                        );
                        if (updatedEvent != null) {
                          viewModel.updateExpenseEvent(index, updatedEvent);
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------- EXISTING METHODS UNCHANGED -----------------------
  Widget _buildFinanceCard(financesData, FinancesViewViewModel viewModel) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.w), // slightly smaller padding
    decoration: BoxDecoration(
      color: const Color(0xFFFFF4CC), // ✅ soft yellow background like the image
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: const Color(0xFFFFF3C9), width: 1), // subtle yellow border
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8.r,
          offset: Offset(0, 3.h),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row (Event Name + Date)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              financesData.eventName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              'Date: ${financesData.date}',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Two-column details
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Booth Size:', financesData.boothSize),
                  SizedBox(height: 8.h),
                  _buildDetailRow('Booth Fee:',
                      '\$${financesData.boothFee.toStringAsFixed(0)}'),
                ],
              ),
            ),

            // Right Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Event Sales:',
                      '\$${financesData.eventSales.toStringAsFixed(0)}'),
                  SizedBox(height: 8.h),
                  _buildDetailRow('Event Expenses:',
                      '\$${financesData.eventExpenses.toStringAsFixed(0)}'),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Net Profit
        Text(
          'Net Profit: \$${financesData.netProfit.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 16.h),

        // Edit Button
        Container(
          width: double.infinity,
          height: 38.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            gradient: const LinearGradient(
              colors: [Color(0xFFFFA167), Color(0xFFFFDF6F)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: TextButton(
            onPressed: () => _buildEditButton(viewModel),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              "Edit",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(width: 4.w),
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

  // Widget _buildEditButton() {
  //   return 
  //   GestureDetector(
  //     onTap: () {
  //       AppRouter.navigateToEditFinancialDetails(financialDetailsId: eventId);
  //     },
  //     child: Container(
  //       width: 400.w,
  //       height: 60.h,
  //       decoration: BoxDecoration(
  //         gradient: const LinearGradient(
  //           colors: [Color(0xFFFF8A00), Color(0xFFFFC107)],
  //           begin: Alignment.centerLeft,
  //           end: Alignment.centerRight,
  //         ),
  //         borderRadius: BorderRadius.circular(12.r),
  //         boxShadow: [
  //           BoxShadow(
  //             color: const Color(0xFFFF8A00).withValues(alpha: 0.3),
  //             blurRadius: 6.r,
  //             offset: Offset(0, 3.h),
  //           ),
  //         ],
  //       ),
  //       child: Center(
  //         child: Text(
  //           'Edit',
  //           style: TextStyle(
  //             fontSize: 22.sp,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
 Widget _buildEditButton(FinancesViewViewModel viewModel) {
  return GestureDetector(
    onTap: () {
      AppRouter.navigateToEditFinancialDetails(
        financialDetailsId: viewModel.financesData?.id ?? eventId,
        onUpdate: () async {
          await viewModel.refresh(); 
        },
      );
    },
    child: Container(
      width: 400.w,
      height: 60.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFA167), Color(0xFFFFDF6F)],
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


  Widget _buildSalesEventCard({
    required String title,
    required String date,
    required String amount,
    VoidCallback? onEdit,
    Color? backgroundColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFFEF4D3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE9A3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                if (onEdit != null)
                  GestureDetector(
                    onTap: onEdit,
                    child: SvgPicture.asset(
                      'assets/icons/edit_icon.svg',
                      width: 12.w,
                      height: 12.h,
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    date,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  amount,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
