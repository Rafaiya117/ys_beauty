import 'package:animation/features/finances/viewmodel/finances_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
    final userImage = FinancesViewModel.instance.userProfileImage;
    final userName = FinancesViewModel.instance.userName ?? 'Guest';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          // App logo
          Center(
            child: GestureDetector(
              onTap: () => AppRouter.navigateToHome(),
              child: CircleAvatar(
                radius: 20.w,
                backgroundColor: Colors.transparent, 
                child: ClipOval(
                  child: userImage != null
                  ? Image.network(
                    'http://10.10.13.36$userImage',
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                  )
                  : Image.asset(
                    AppConstants.appLogoPath,
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                  ),
                ),
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
                  userName,
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
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Select a date → add an event.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
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
              // Custom Header (to match "July 2025" style)
              Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat.MMMM().format(viewModel.focusedDay),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat.y().format(viewModel.focusedDay),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            viewModel.onPageChanged(
                              DateTime(
                                viewModel.focusedDay.year,
                                viewModel.focusedDay.month - 1,
                              ),
                            );
                          },
                          child: Icon(
                            Icons.chevron_left,
                            size: 22.sp,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            viewModel.onPageChanged(
                              DateTime(
                                viewModel.focusedDay.year,
                                viewModel.focusedDay.month + 1,
                              ),
                            );
                          },
                          child: Icon(
                            Icons.chevron_right,
                            size: 22.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ✅ Fixed Calendar (no expand/unexpand)
              TableCalendar<dynamic>(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: viewModel.focusedDay,

                // 🔒 Fixed calendar format
                calendarFormat: CalendarFormat.month,

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
                    border: Border.all(color: Colors.black, width: 2.w),
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
                  titleTextFormatter: (_, __) => '',
                  titleCentered: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
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
                // 🚫 Removed onFormatChanged to prevent expansion
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
          height: 190.h,
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
                      eventId:event.id.toString() ,
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
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
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
  required String eventId, 
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
  final eventDate = DateTime.tryParse(date);
  final monthText = eventDate != null ? DateFormat('MMM').format(eventDate) : ''; // Abbreviated month
  final dayText = eventDate != null ? DateFormat.d().format(eventDate) : '';

  final startDateTime = DateTime.tryParse(startTime);
  final endDateTime = DateTime.tryParse(endTime);

  final formattedStartTime = startDateTime != null
      ? DateFormat('h:mm a').format(startDateTime)
      : startTime;
  final formattedEndTime = endDateTime != null
      ? DateFormat('h:mm a').format(endDateTime)
      : endTime;

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
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        _getStatusLabel(statusText),
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

            // 🔹 Circular date container
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    monthText,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  Text(
                    dayText,
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

        // 🔹 Booth Size + Space + Cost
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booth Size: $boothSize',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF424242),
              ),
            ),
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
                SizedBox(height: 4.h),
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

        // 🔹 Time row + Details button side by side
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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

            // Start & End time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start: $formattedStartTime',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF424242),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'End: $formattedEndTime',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF424242),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Details button (moved here)
            SizedBox(
              width:86.7.w,
              height: 28.64.h,
              child: GestureDetector(
                onTap: () => AppRouter.navigateToEventDetails(eventId),
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
                    textAlign: TextAlign.center,
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
      ],
    ),
  );
}


 Widget _buildUpcomingEventCard({
  required String eventId,
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
  final eventDate = DateTime.tryParse(date);
  final monthText =
      eventDate != null ? DateFormat('MMM').format(eventDate) : ''; // Abbreviated month
  final dayText = eventDate != null ? DateFormat.d().format(eventDate) : '';
  final startDateTime = DateTime.tryParse(startTime);
  final endDateTime = DateTime.tryParse(endTime);

  final formattedStartTime =
      startDateTime != null ? DateFormat('h:mm a').format(startDateTime) : startTime;
  final formattedEndTime =
      endDateTime != null ? DateFormat('h:mm a').format(endDateTime) : endTime;

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
        // 🔹 Header Row
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
                  ...status.map((statusText) {
                    Color statusColor = _getStatusColor(statusText);
                    return Container(
                      margin: EdgeInsets.only(right: 6.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        _getStatusLabel(statusText),
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
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    monthText,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    dayText,
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

        // 🔹 Location Row
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

        SizedBox(height: 6.h),

        // 🔹 Booth Size + Space Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Booth Size: $boothSize',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF424242),
              ),
            ),
            Text(
              'Space #: $spaceNumber',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF424242),
              ),
            ),
          ],
        ),

        SizedBox(height: 4.h),

        // 🔹 Cost below Space
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Cost: $cost',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B1B1B),
            ),
          ),
        ),

        SizedBox(height: 10.h),

        // 🔹 Start / End Time + Details Button Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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

            // Start and End times
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start: $formattedStartTime',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B1B1B),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'End: $formattedEndTime',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B1B1B),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Details button (in same row)
            SizedBox(
              width:96.86.w,
              height: 32.27.h,
              child: GestureDetector(
                onTap: () => AppRouter.navigateToEventDetails(eventId),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF1B1B1B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
      return const Color(0xFFEEBC20); 
    case 'app':
    case 'approved':
      return const Color(0xFF00BF63);
    case 'paid':
      return const Color(0xFF00703A);
    case 'den':
    case 'denied':
      return const Color(0xFFFF5151);
    case 'unpaid':
      return const Color(0xFFEF4444); 
    case 'transfer':
      return const Color(0xFF007AFF);
    default:
      return Colors.grey;
  }
}

String _getStatusLabel(String status) {
  final normalized = status.toLowerCase().trim();

  switch (normalized) {
    case 'pen':
    case 'pending':
      return 'Pending';
    case 'app':
    case 'approved':
      return 'Approved';
    case 'paid':
      return 'Paid';
    case 'den':
    case 'denied':
      return 'Denied';
    case 'unpaid':
      return 'Unpaid';
    case 'transfer':
      return 'Transfer';
    default:
      return status; 
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
                color: Color(0xFFFFFEF3), // Light yellow background
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
                              decoration:BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
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

