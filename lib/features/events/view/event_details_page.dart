import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/event_details_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../core/router.dart';

class EventDetailsPage extends StatelessWidget {
  final String eventId;
  
  const EventDetailsPage({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventDetailsViewModel()..loadEventDetails(eventId),
      child: Consumer<EventDetailsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
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
                    
                    // Content
                    Expanded(
                      child: viewModel.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8A00)),
                              ),
                            )
                          : viewModel.errorMessage != null
                              ? Center(
                                  child: Text(
                                    viewModel.errorMessage!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : viewModel.eventDetails != null
                                  ? _buildEventDetails(viewModel.eventDetails!, viewModel)
                                  : const SizedBox(),
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
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
          
          SizedBox(width: 16.w),
          
          // Title
          Expanded(
            child: Text(
              'Event Details',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          SizedBox(width: 40.w), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildEventDetails(eventDetails, EventDetailsViewModel viewModel) {
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event title
              Text(
                eventDetails.title,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 16.h),

              // Description
              Text(
                eventDetails.description,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 16.h),

              // Date + Status row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem('Date', eventDetails.date),
                  Row(
                    children: eventDetails.status.map<Widget>((statusText) {
                      Color statusColor = viewModel.getStatusColor(statusText);
                      return Container(
                        margin: EdgeInsets.only(left: 8.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: statusText.toLowerCase() == 'pending'
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              // Space (right-aligned, below date & status)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: _buildDetailItem('Space #:', eventDetails.spaceNumber,alignRight: true),
                ),
              ),

              SizedBox(height: 10.h),

              // Location + Booth Size Row
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(alignment: Alignment.centerLeft,child: _buildDetailItem('Location', eventDetails.location)),
                  ),
                  SizedBox(width: 50.w),
                  Expanded(
                    child:Align(alignment:Alignment.centerRight ,child: _buildDetailItem('Booth Size', eventDetails.boothSize,alignRight: true)),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Fee + Time Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildDetailItem('Fee', eventDetails.fee,isFee: true),
                  ),
                  SizedBox(width: 30.w),
                  Expanded(
                    child: _buildTimeDetails(eventDetails.startTime, eventDetails.endTime),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              // Edit Event button
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () => AppRouter.navigateToEditEvent(eventDetails.id),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFA167), Color(0xFFFFDF6F)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Edit Event',
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
      ],
    ),
  );
}


  Widget _buildDetailItem(String label,String value, {bool isFee = false,bool alignRight = false,}) {
  final isInline = label.toLowerCase().contains('space');

  if (isInline) {
    return Row(
      mainAxisAlignment:
          alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: alignRight ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: isFee ? 18.sp : 14.sp,
              fontWeight: isFee ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  // Default column layout for other items
  return Column(
    crossAxisAlignment:
        alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      SizedBox(height: 4.h),
      Text(
        value,
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        style: TextStyle(
          fontSize: isFee ? 18.sp : 14.sp,
          fontWeight: isFee ? FontWeight.bold : FontWeight.normal,
          color: Colors.black,
        ),
      ),
    ],
  );
}


  Widget _buildTimeDetails(String startTime, String endTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Time',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            // Time stepper
            Column(
              children: [
                Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 1.w,
                  height: 20.h,
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            
            SizedBox(width: 12.w),
            
            // Time details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Start: $startTime',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'End: $endTime',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
