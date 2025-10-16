import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../viewmodel/available_event_viewmodel.dart';
import '../model/available_event_model.dart';
import '../../../core/router.dart';
import '../../../shared/constants/app_constants.dart';

class AvailableEventPage extends StatelessWidget {
  const AvailableEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize events when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AvailableEventViewModel>().initializeEvents();
    });
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7), // Light yellow/cream background
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Consumer<AvailableEventViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8A00)),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCalendar(viewModel),
                      SizedBox(height: 16.h),
                      _buildAvailableEventIndicator(),
                      SizedBox(height: 16.h),
                      _buildEventsList(viewModel),
                      SizedBox(height: 24.h),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      color: const Color(0xFFFFFDE7), // Light yellow/cream background
      child: Row(
        children: [
          // Back arrow
          IconButton(
            icon:SvgPicture.asset(
              'assets/icons/back_button.svg',
              width:16.w,
              height: 12.h,
            ),
            // Icon(
            //   Icons.arrow_back_ios,
            //   color: Color(0xFF1B1B1B),
            // ),
            onPressed: () => AppRouter.goBack(),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          SizedBox(width: 12.w),
          // Title
          Expanded(
            child: Text(
              'Available Event',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B1B1B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(AvailableEventViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5E7), // Light cream background
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: TableCalendar<AvailableEventModel>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: viewModel.focusedDay,
            calendarFormat: viewModel.calendarFormat,
            eventLoader: viewModel.eventLoader,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle(
                color: const Color(0xFF424242),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              defaultTextStyle: TextStyle(
                color: const Color(0xFF424242),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              // Selected date - just circle border, no background
              selectedDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.green,
                  width: 2.w,
                ),
              ),
              selectedTextStyle: TextStyle(
                color: const Color(0xFF424242),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              // Today - no special styling
              todayDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: const Color(0xFF424242),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              // Hide markers since we'll use background color for event dates
              markersMaxCount: 0,
            ),
            // Custom builder for dates with events
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // Check if this date has events
                if (viewModel.hasEvents(day)) {
                  return Container(
                    margin: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }
                return null; // Use default styling
              },
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF424242),
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                size: 24.sp,
                color: const Color(0xFF424242),
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                size: 24.sp,
                color: const Color(0xFF424242),
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF757575),
              ),
              weekendStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF757575),
              ),
            ),
            onDaySelected: viewModel.onDaySelected,
            onFormatChanged: viewModel.onFormatChanged,
            onPageChanged: viewModel.onPageChanged,
            selectedDayPredicate: (day) {
              return isSameDay(viewModel.selectedDay, day);
            },
          ),
    );
  }

  Widget _buildAvailableEventIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'Available Event',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList(AvailableEventViewModel viewModel) {
    final selectedEvents = viewModel.selectedDayEvents;
    
    if (viewModel.selectedDay == null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(20.w),
        child: Text(
          'Select a date to view available events',
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF757575),
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (selectedEvents.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(20.w),
        child: Text(
          'No events available for this date',
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF757575),
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: selectedEvents.map((event) => 
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: _buildEventCard(event, viewModel),
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildEventCard(AvailableEventModel event, AvailableEventViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(AppConstants.cardBgPath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title, status, and date
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B1B1B),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Status badges beside title
                    ...event.status.map((statusText) {
                      Color statusColor = viewModel.getStatusColor(statusText);
                      return Container(
                        margin: EdgeInsets.only(right: 6.w),
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Column(
                  children: [
                    Text(
                      'July',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${event.eventDate.day}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 6.h),
          
          // Location
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16.sp,
                color: const Color(0xFF1B1B1B),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  event.location,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF1B1B1B),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 4.h),
          
          // Booth size
          Text(
            'Booth Size: ${event.boothSize}',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF424242),
            ),
          ),
          
          SizedBox(height: 8.h),
          
          // Time and details row
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
                    width: 12.w,
                    height: 12.h,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start: ${event.startTime}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B1B1B),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'End: ${event.endTime}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B1B1B),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Space and cost
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Space #: ${event.spaceNumber}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B1B1B),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Cost: ${event.cost}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B1B1B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // Details button
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => AppRouter.navigateToEventDetails(event.id),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8A00), Color(0xFFFFC107)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF1B1B1B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvailableEventPageWrapper extends StatelessWidget {
  const AvailableEventPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AvailableEventViewModel(),
      child: const AvailableEventPage(),
    );
  }
}
