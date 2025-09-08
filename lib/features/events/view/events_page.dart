import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodel/events_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../shared/widgets/global_drawer.dart';
import '../../../shared/utils/greeting_utils.dart';
import '../../../core/router.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventsViewModel()..loadEvents(),
      child: Consumer<EventsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            drawer: const GlobalDrawer(),
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
                    
                    SizedBox(height: 16.h),
                    
                    // Search bar
                    _buildSearchBar(context, viewModel),
                    
                    SizedBox(height: 24.h),
                    
                    // Category tabs
                    _buildCategoryTabs(viewModel),
                    
                    SizedBox(height: 24.h),
                    
                    // Scrollable content (Events + Reminders)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Events list
                            _buildEventsList(viewModel),
                            
                            SizedBox(height: 24.h),
                            
                            // Reminders & Notifications section
                            _buildRemindersSection(),
                            
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
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
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF424242),
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
                child: Icon(
                  Icons.notifications_outlined,
                  size: 24.sp,
                  color: const Color(0xFF424242),
                ),
              ),
              SizedBox(width: 16.w),
              Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    size: 24.sp,
                    color: const Color(0xFF424242),
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

  Widget _buildSearchBar(BuildContext context, EventsViewModel viewModel) {
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
                    color: Colors.black,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => AppRouter.navigateToSearch(),
                      child: Container(
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    size: 20.sp,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20.sp,
                    color: Colors.black,
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
            ),
          ),
          
          SizedBox(width: 12.w),
          
          // Filter button
          GestureDetector(
            onTap: () => _showFilterModal(context),
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.black,
                  width: 1.w,
                ),
              ),
              child: Icon(
                Icons.tune,
                size: 20.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(EventsViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton('Today', viewModel.selectedTab == 'Today', () => viewModel.setSelectedTab('Today')),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildTabButton('Upcoming', viewModel.selectedTab == 'Upcoming', () => viewModel.setSelectedTab('Upcoming')),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildTabButton('Past', viewModel.selectedTab == 'Past', () => viewModel.setSelectedTab('Past')),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF8A00) : const Color(0xFF424242),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventsList(EventsViewModel viewModel) {
    if (viewModel.isLoading) {
      return Container(
        height: 200.h,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8A00)),
          ),
        ),
      );
    }

    if (viewModel.errorMessage != null) {
      return Container(
        height: 200.h,
        child: Center(
          child: Text(
            viewModel.errorMessage!,
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final filteredEvents = viewModel.filteredEvents;

    if (filteredEvents.isEmpty) {
      return Container(
        height: 200.h,
        child: Center(
          child: Text(
            'No events found',
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFF424242),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: filteredEvents.map((event) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: _buildEventCard(event, viewModel),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEventCard(event, EventsViewModel viewModel) {
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
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF424242),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    // Status badges beside title
                    ...event.status.map((statusText) {
                      Color statusColor = viewModel.getStatusColor(statusText);
                      return Container(
                        margin: EdgeInsets.only(right: 4.w),
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 9.sp,
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
                        fontSize: 9.sp,
                        color: const Color(0xFF757575),
                      ),
                    ),
                    Text(
                      '25',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF424242),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 8.h),
          
          // Location
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 14.sp,
                color: const Color(0xFF424242),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  event.location,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF424242),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 6.h),
          
          // Booth size
          Text(
            'Booth Size: ${event.boothSize}',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
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
                    height: 15.h,
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
                      'Start: ${event.startTime}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF424242),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'End: ${event.endTime}',
                      style: TextStyle(
                        fontSize: 11.sp,
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
                    'Space #: ${event.spaceNumber}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF424242),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Cost: ${event.cost}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF424242),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 10.h),
          
          // Details button
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => AppRouter.navigateToEventDetails('1'),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8A00), Color(0xFFFFC107)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterModal(BuildContext context) {
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
                            icon: Icons.event_outlined,
                            title: 'Events',
                            onTap: () {
                              Navigator.of(context).pop();
                              // Handle Events filter
                            },
                          ),
                          _buildFilterOption(
                            icon: Icons.person_outline,
                            title: 'Coordinator',
                            onTap: () {
                              Navigator.of(context).pop();
                              // Handle Coordinator filter
                            },
                          ),
                          _buildFilterOption(
                            icon: Icons.calendar_today_outlined,
                            title: 'Date',
                            onTap: () {
                              Navigator.of(context).pop();
                              // Handle Date filter
                            },
                          ),
                          _buildFilterOption(
                            icon: Icons.location_on_outlined,
                            title: 'Location',
                            onTap: () {
                              Navigator.of(context).pop();
                              // Handle Location filter
                            },
                            showDivider: false,
                          ),
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
    required IconData icon,
    required String title,
    required VoidCallback onTap,
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
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showDivider)
          Container(
            height: 1.h,
            color: const Color(0xFFE0E0E0), // Light gray divider
            margin: EdgeInsets.symmetric(horizontal: 12.w),
          ),
      ],
    );
  }

  Widget _buildRemindersSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Reminders & Notifications',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Reminder cards
          Column(
            children: [
              _buildReminderCard(
                title: 'Birthday Party',
                date: '01 July 2025',
                status: 'Pending',
                cardColor: const Color(0xFFFFF8E1), // Light yellow
                statusColor: Colors.yellow,
              ),
              SizedBox(height: 12.h),
              _buildReminderCard(
                title: 'Friendly Party',
                date: '01 July 2025',
                status: 'Approved',
                cardColor: const Color(0xFFE8F5E8), // Light green
                statusColor: Colors.green,
              ),
              SizedBox(height: 12.h),
              _buildReminderCard(
                title: 'Conference',
                date: '01 July 2025',
                status: 'Denied',
                cardColor: const Color(0xFFFFE8E8), // Light red
                statusColor: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard({
    required String title,
    required String date,
    required String status,
    required Color cardColor,
    required Color statusColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          
          // Status badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12.sp,
                color: status == 'Pending' ? Colors.black : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
