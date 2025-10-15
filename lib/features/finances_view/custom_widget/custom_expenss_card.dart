import 'package:animation/features/finances_view/view/modal.dart';
import 'package:animation/features/finances_view/viewmodel/finances_view_viewmodel.dart';
import 'package:animation/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseHistoryPage extends StatelessWidget {
  final String title;
  final List<ExpenseEvent> events;

  const ExpenseHistoryPage({super.key, required this.title, required this.events});

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset(
                        'assets/icons/back_button.svg',
                        width: 16.w,
                        height: 16.h,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          title,
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
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: events.isEmpty
                      ? Center(
                          child: Text(
                            'No $title data found',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xFF757575),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            final event = events[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: _buildExpenseEventCard(
                                context,
                                title: event.title,
                                date: event.date,
                                amount: event.amount,
                                onEdit: () async {
                                  final updatedEvent = await showDialog<ExpenseEvent>(
                                    context: context,
                                    builder: (context) => EditExpenseEventDialog(event: event),
                                  );
                                  if (updatedEvent != null) {
                                    // Optional: handle update if needed
                                  }
                                },
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseEventCard(
    BuildContext context, {
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
            // Top row (title + edit)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                if (onEdit != null)
                  GestureDetector(
                    onTap: onEdit,
                    child: Icon(
                      Icons.edit,
                      size: 18.sp,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            // Bottom row (date + amount)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    date,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Text(
                  amount,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
