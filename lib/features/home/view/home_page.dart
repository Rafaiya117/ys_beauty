import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodel/home_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../shared/widgets/global_drawer.dart';
import '../../../shared/utils/greeting_utils.dart';
import '../../../core/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            drawer: const GlobalDrawer(),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header with bee logo, greeting, and icons
                      _buildHeader(context),
                      
                      SizedBox(height: 16.h),
                      
                      // Search bar
                      _buildSearchBar(context, viewModel),
                      
                      SizedBox(height: 24.h),
                      
                       // My Booking Calendar section
                       _buildBookingCalendar(viewModel),
                       
                       SizedBox(height: 16.h),
                       
                       // Add New Event button
                       _buildAddNewEventButton(),
                       
                       SizedBox(height: 24.h),
                       
                       // Today Events section
                       _buildTodayEvents(viewModel),
                      
                      SizedBox(height: 24.h),
                      
                      // Upcoming Events section
                      _buildUpcomingEvents(viewModel),
                      
                       SizedBox(height: 24.h),
                      
                      // Loading indicator
                      if (viewModel.isLoading) ...[
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFFFF8A00),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                                            
                      // Error message
                      if (viewModel.errorMessage != null) ...[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.w),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            viewModel.errorMessage!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ],
                  ),
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
          // App logo
          Center(
            child: Container(
              child: Image.asset(
                AppConstants.appLogoPath,
                width: 40.w,
                height: 40.h,
              ),
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Greeting text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  GreetingUtils.getGreeting(),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16.sp,
                    color: const Color(0xFF424242),
                    fontWeight: FontWeight.bold,
                    
                  ),
                ),
                // Name
                Text(
                  'Nicolas Smith',
                  style: GoogleFonts.greatVibes(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          
          // Notification and menu icons
          Row(
            children: [
              GestureDetector(
                onTap: () => AppRouter.navigateToReminders(),
                child: 
                SvgPicture.asset(
                  'assets/icons/notification.svg',
                  width: 16.w,
                  height: 20.h,
                ),
              ),
              //SizedBox(width: 16.w),
              Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon:SvgPicture.asset(
                    'assets/icons/menu.svg',
                    width: 16.w,
                    height: 18.h,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          // Search bar
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.black,
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  Icon(
                    Icons.search,
                    size: 20.sp,
                    color: viewModel.searchFilterType != null 
                      ? const Color(0xFFFF8A00) 
                      : Colors.black,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      controller: viewModel.searchController,
                      onChanged: viewModel.setSearchQuery,
                      onTap: () {
                        // Navigate to search page when search bar is tapped (only if no filter is selected)
                        if (viewModel.searchFilterType == null) {
                          AppRouter.navigateToSearch();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: _getSearchHint(viewModel.searchFilterType),
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFF757575),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Clear search button
                  if (viewModel.searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: viewModel.clearSearch,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        child: Icon(
                          Icons.clear,
                          size: 18.sp,
                          color: const Color(0xFF757575),
                        ),
                      ),
                    ),
                  // Location icon
                  // GestureDetector(
                  //   onTap: () {
                  //     AppRouter.navigateToLocation();
                  //   },
                  //   child: Icon(
                  //     Icons.location_on_outlined,
                  //     size: 20.sp,
                  //     color: viewModel.searchFilterType != null 
                  //       ? const Color(0xFFFF8A00) 
                  //       : Colors.black,
                  //   ),
                  // ),
                  SizedBox(width: 8.w),
                  // Calendar icon
                  GestureDetector(
                    onTap: () {
                      AppRouter.navigateToAvailableEvent();
                    },
                    child: Icon(
                      Icons.calendar_today_outlined,
                      size: 20.sp,
                      color: viewModel.searchFilterType != null 
                        ? const Color(0xFFFF8A00) 
                        : Colors.black,
                    ),
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
            ),
          ),
          
          SizedBox(width: 12.w),
          
          // Filter button
          GestureDetector(
            onTap: () => _showFilterModal(context, viewModel),
            child: Container(
              width: 48.w,
              height: 48.h,            
              child: SvgPicture.asset(
                'assets/icons/settings.svg',
                width:40.w ,
                height:40.h ,
              ),
              // Icon(
              //   Icons.tune,
              //   size: 20.sp,
              //   color: viewModel.searchFilterType != null 
              //     ? Colors.white 
              //     : Colors.black,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSearchHint(String? filterType) {
    switch (filterType) {
      case 'Events':
        return 'Search events...';
      case 'Coordinator':
        return 'Search coordinator...';
      case 'Date':
        return 'Select date...';
      case 'Location':
        return 'Search location...';
      default:
        return 'Search...';
    }
  }


  Widget _buildBookingCalendar(HomeViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and has event indicator
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Booking Calendar',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF424242),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Select a date → add an event.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3C4),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Has Event',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF424242),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
           // Calendar widget
           Container(
             width: double.infinity,
             padding: EdgeInsets.all(20.w),
             decoration: BoxDecoration(
               color: const Color(0xFFFAF5E7),
               borderRadius: BorderRadius.circular(16.r),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withValues(alpha: 0.05),
                   blurRadius: 8.r,
                   offset: Offset(0, 2.h),
                 ),
               ],
             ),
            child: Column(
              children: [
                 // Dynamic Calendar
                 TableCalendar<dynamic>(
                   firstDay: DateTime.utc(2020, 1, 1),
                   lastDay: DateTime.utc(2030, 12, 31),
                   focusedDay: viewModel.focusedDay,
                   calendarFormat: viewModel.calendarFormat,
                   eventLoader: (day) {
                     return viewModel.hasEvents(day) ? [day] : [];
                   },
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
                     selectedDecoration: BoxDecoration(
                       color: Colors.transparent,
                       shape: BoxShape.circle,
                       border: Border.all(
                         color: Colors.black,
                         width: 2.w,
                       ),
                     ),
                     selectedTextStyle: TextStyle(
                       color: Colors.black,
                       fontSize: 14.sp,
                       fontWeight: FontWeight.w500,
                     ),
                     todayDecoration: BoxDecoration(
                       color: Colors.green.withValues(alpha: 0.3),
                       shape: BoxShape.circle,
                     ),
                     markersMaxCount: 1,
                     markerDecoration: BoxDecoration(
                       color: const Color(0xFFFFF3C4),
                       shape: BoxShape.circle,
                     ),
                     markerMargin: EdgeInsets.symmetric(horizontal: 1.w),
                     markerSize: 6.w,
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
                SizedBox(height: 16.h),                
                // Legend
                _buildCalendarLegend(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCalendarLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem(Colors.yellow, 'Pending'),
        _buildLegendItem(Colors.green, 'Approved'),
        _buildLegendItem(Colors.red, 'Denied'),
        _buildLegendItem(Colors.blue, 'Transfer'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: const Color(0xFF424242),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayEvents(HomeViewModel viewModel) {
  final events = viewModel.events;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today Events',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF424242),
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFFFF8A00),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Event cards
        SizedBox(
          height: 180.h,
          child: events.isEmpty
              ? Center(child: Text('No events today', style: TextStyle(fontSize: 14.sp)))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Container(
                      width: 266.w,
                      margin: EdgeInsets.only(right: 16.w),
                      child: _buildEventCard(
                        eventId: event.id.toString(),
                        title: event.eventName,
                        status: [event.status ?? 'Pending', event.paid ? 'Paid' : 'Unpaid'],
                        date: event.date,
                        location: event.address??'',
                        boothSize: event.boothSize,
                        spaceNumber: event.boothSpace,
                        cost: '\$${event.boothFee}',
                        startTime: event.startTimeDate,
                        endTime: event.endTimeDate,
                      ),
                    );
                  },
                ),
        ),
      ],
    ),
  );
}


  Widget _buildUpcomingEvents(HomeViewModel viewModel) {
  final events = viewModel.upcomingEvents;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF424242),
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFFFF8A00),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Event cards
        events.isEmpty
            ? Center(child: Text('No upcoming events', style: TextStyle(fontSize: 14.sp)))
            : Column(
                children: events.map((event) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: _buildUpcomingEventCard(
                      title: event.eventName,
                      status: [event.status ?? 'Pending', event.paid ? 'Paid' : 'Unpaid'],
                      date: event.date,
                      location: event.address??'',
                      boothSize: event.boothSize,
                      spaceNumber: event.boothSpace,
                      cost: '\$${event.boothFee}',
                      startTime: event.startTimeDate,
                      endTime: event.endTimeDate,
                    ),
                  );
                }).toList(),
              ),
      ],
    ),
  );
}

  Widget _buildAddNewEventButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => AppRouter.navigateToCreateEvent(),
          borderRadius: BorderRadius.circular(40.r),
          child: Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFA167), Color(0xFFFFDF6F)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Add New Event',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard({
  required String eventId, // ✅ Added eventId
  required String title,
  required List<String> status,
  required String date,
  required String location,
  required String boothSize,
  required String spaceNumber,
  required String cost,
  required String startTime,
  required String endTime,
}) {
  return Container(
    padding: EdgeInsets.all(12.w),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with title, status, and date
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF424242),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Status badges beside title
                  ...status.map((statusText) {
                    Color statusColor = _getStatusColor(statusText);
                    return Container(
                      margin: EdgeInsets.only(right: 4.w),
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 8.sp,
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
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Column(
                children: [
                  Text(
                    'July',
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  Text(
                    '22',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 2.h),

        // Location
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 14.sp,
              color: const Color(0xFF1B1B1B),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                location,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: const Color(0xFF1B1B1B),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        SizedBox(height: 3.h),

        // Booth size
        Text(
          'Booth Size: $boothSize',
          style: TextStyle(
            fontSize: 12.sp,
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
                  width: 6.w,
                  height: 6.h,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 1.w,
                  height: 16.h,
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                Container(
                  width: 6.w,
                  height: 6.h,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),

            SizedBox(width: 8.w),

            // Time details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start: $startTime',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF424242),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'End: $endTime',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF424242),
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
                  'Space #: $spaceNumber',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF424242),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Cost: $cost',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Details button
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => AppRouter.navigateToEventDetails(eventId), // ✅ Updated
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFA167), Color(0xFFFFDF6F)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                'Details',
                style: TextStyle(
                  fontSize: 12.sp,
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

  Widget _buildUpcomingEventCard({
    required String title,
    required List<String> status,
    required String date,
    required String location,
    required String boothSize,
    required String spaceNumber,
    required String cost,
    required String startTime,
    required String endTime,
  }) {
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
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B1B1B),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Status badges beside title
                    ...status.map((statusText) {
                      Color statusColor = _getStatusColor(statusText);
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
                      '25',
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
                  location,
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
            'Booth Size: $boothSize',
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
                      'Start: $startTime',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B1B1B),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'End: $endTime',
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
                    'Space #: $spaceNumber',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B1B1B),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Cost: $cost',
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
              onTap: () => AppRouter.navigateToEventDetails('1'),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA167), Color(0xFFFFDF6F)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF1B1B1B),
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

 Color _getStatusColor(String status) {
  final normalized = status.toLowerCase().trim();

  switch (normalized) {
    case 'pen':
    case 'pending':
      return const Color(0xFFEEBC20); // Yellow background for Pending
    case 'app':
    case 'approved':
      return const Color(0xFF00BF63); // Green background for Approved
    case 'paid':
      return const Color(0xFF00703A); // Dark green background for Paid
    case 'den':
    case 'denied':
      return const Color(0xFFFF5151); // Red background for Denied
    case 'unpaid':
      return const Color(0xFFEF4444); // Red background for Unpaid
    case 'transfer':
      return const Color(0xFF007AFF); // Blue background for Transfer
    default:
      return Colors.grey;
  }
}

  void _showFilterModal(BuildContext context, HomeViewModel viewModel) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF8E1), // Light yellow background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Close button
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Filter title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 32.h),
                    
                    // Filter options
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        children: [
                          _buildFilterOption(
                            iconPath:'assets/icons/filter_events.svg',
                            title: 'Events',
                            isSelected: viewModel.searchFilterType == 'Events',
                            onTap: () {
                              Navigator.of(context).pop();
                              viewModel.setSearchFilterType('Events');
                              AppRouter.navigateToMain(initialIndex: 1); // Navigate to Events tab
                            },
                          ),
                          _buildFilterOption(
                            iconPath: 'assets/icons/filter_coordinator.svg',
                            title: 'Coordinator',
                            isSelected: viewModel.searchFilterType == 'Coordinator',
                            onTap: () {
                              Navigator.of(context).pop();
                              viewModel.setSearchFilterType('Coordinator');
                              AppRouter.navigateToSearch();
                            },
                          ),
                          _buildFilterOption(
                            iconPath: 'assets/icons/filter_date.svg',
                            title: 'Date',
                            isSelected: viewModel.searchFilterType == 'Date',
                            onTap: () {
                              Navigator.of(context).pop();
                              viewModel.setSearchFilterType('Date');
                              AppRouter.navigateToAvailableEvent();
                            },
                          ),
                          // _buildFilterOption(
                          //   icon: Icons.location_on_outlined,
                          //   title: 'Location',
                          //   isSelected: viewModel.searchFilterType == 'Location',
                          //   onTap: () {
                          //     Navigator.of(context).pop();
                          //     viewModel.setSearchFilterType('Location');
                          //     AppRouter.navigateToLocation();
                          //   },
                          //   showDivider: false,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
    );
  }

  Widget _buildFilterOption({
  required String iconPath, // ← change IconData to String path
  required String title,
  required VoidCallback onTap,
  bool isSelected = false,
  bool showDivider = true,
}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFF8A00).withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    iconPath,
                    width: 14.w,
                    height: 14.h,
                    color: isSelected
                        ? const Color(0xFFFF8A00)
                        : Colors.black,
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: isSelected
                        ? const Color(0xFFFF8A00)
                        : Colors.black,
                      fontWeight:isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  if (isSelected) ...[
                    const Spacer(),
                    Icon(
                      Icons.check_circle,
                      size: 20.sp,
                      color: const Color(0xFFFF8A00),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      if (showDivider)
        Container(
          height: 1.h,
          color: const Color(0xFFE0E0E0),
          margin: EdgeInsets.symmetric(horizontal: 12.w),
        ),
    ],
  );
}
}

