import 'package:animation/features/finances/viewmodel/finances_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final userName = FinancesViewModel.instance.userName ?? 'Guest';
  final userImage = FinancesViewModel.instance.userProfileImage;
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
                backgroundColor: Colors.transparent, // keep transparency
                child: ClipOval(
                  child: userImage != null
                      ? Image.network(
                          'http://10.10.13.36$userImage',
                          width: 40.w,
                          height: 40.w,
                          fit: BoxFit.cover, // fills circle, may crop
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
                child: 
                SvgPicture.asset(
                  'assets/icons/notification.svg',
                  width: 18.w,
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

  Widget _buildSearchBar(BuildContext context, EventsViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          // Search bar
          Expanded(
            child: Container(
              height: 48.h,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(24.r),
              //   border: Border.all(
              //     color: viewModel.searchFilterType != null
              //         ? const Color(0xFFFF8A00)
              //         : Colors.black,
              //     width: 1.5.w,
              //   ),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.black.withValues(alpha: 0.05),
              //       blurRadius: 8.r,
              //       offset: Offset(0, 2.h),
              //     ),
              //   ],
              // ),
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
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
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
              // decoration: BoxDecoration(
              //   color: viewModel.searchFilterType != null
              //       ? const Color(0xFFFF8A00)
              //       : Colors.white,
              //   borderRadius: BorderRadius.circular(24.r),
              //   border: Border.all(
              //     color: viewModel.searchFilterType != null
              //         ? const Color(0xFFFF8A00)
              //         : Colors.black,
              //     width: 1.5.w,
              //   ),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.black.withValues(alpha: 0.05),
              //       blurRadius: 8.r,
              //       offset: Offset(0, 2.h),
              //     ),
              //   ],
              // ),
              child: SvgPicture.asset(
                'assets/icons/settings.svg',
                width:40.w ,
                height:40.h ,
                // ignore: deprecated_member_use
                color:viewModel.searchFilterType != null ? Colors.white:Colors.black ,
              ),
              // Icon(
              //   Icons.tune,
              //   size: 20.sp,
              //   color: viewModel.searchFilterType != null
              //       ? Colors.white
              //       : Colors.black,
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

  Widget _buildCategoryTabs(EventsViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              'Today',
              viewModel.selectedTab == 'Today',
              () => viewModel.setSelectedTab('Today'),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildTabButton(
              'Upcoming',
              viewModel.selectedTab == 'Upcoming',
              () => viewModel.setSelectedTab('Upcoming'),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildTabButton(
              'Past',
              viewModel.selectedTab == 'Past',
              () => viewModel.setSelectedTab('Past'),
            ),
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
            style: TextStyle(color: Colors.red, fontSize: 16.sp),
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
            style: TextStyle(fontSize: 16.sp, color: const Color(0xFF424242)),
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
      // REDUCED: Padding from 12.w to 10.w
      padding: EdgeInsets.all(10.w),
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
                        padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.h,),
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
                width: 40.w,
                height: 40.w,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center, 
                  children: [
                    Text(
                      _getEventMonth(event.date),
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: const Color(0xFF757575),
                      ),
                    ),
                    Text(
                      _getEventDay(event.date),
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

          // REDUCED: Spacing from 8.h to 6.h
          SizedBox(height: 6.h),

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
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Booth size
              Text(
                'Booth Size: ${event.boothSize}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B1B1B),
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
                  SizedBox(height: 2.h),
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
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end, 
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
                    height: 12.h,
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.3),
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
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B1B1B),
                      ),
                    ),
                    SizedBox(height: 4.h),
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

              // Details button
              SizedBox(
                width: 96.86.w,
                height: 32.27.h,
                child: GestureDetector(
                  onTap: () => AppRouter.navigateToEventDetails(event.id),
                  child: Container(
                    // REDUCED: Horizontal padding from 12.w to 10.w
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
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
        ],
      ),
    );
  }
  void _showFilterModal(BuildContext context, EventsViewModel viewModel) {
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
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                )
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
                            icon: Icons.event_outlined,
                            title: 'Events',
                            isSelected: viewModel.searchFilterType == 'Events',
                            onTap: () {
                              Navigator.of(context).pop();
                              viewModel.setSearchFilterType('Events');
                            },
                          ),
                          _buildFilterOption(
                            icon: Icons.person_outline,
                            title: 'Coordinator',
                            isSelected:
                                viewModel.searchFilterType == 'Coordinator',
                            onTap: () {
                              Navigator.of(context).pop();
                              viewModel.setSearchFilterType('Coordinator');
                            },
                          ),
                          _buildFilterOption(
                            icon: Icons.calendar_today_outlined,
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
          position:
              Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
          child: child,
        );
      },
    );
  }

  Widget _buildFilterOption({
    required IconData icon,
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
                    Icon(
                      icon,
                      size: 24.sp,
                      color: isSelected
                          ? const Color(0xFFFF8A00)
                          : Colors.black,
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: isSelected
                            ? const Color(0xFFFF8A00)
                            : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
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
          ChangeNotifierProvider(
            create: (_) => EventsViewModel()..loadEvents(), 
            child: Consumer<EventsViewModel>(
              builder: (context, viewModel, _) {
                if (viewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (viewModel.errorMessage != null) {
                  return Center(child: Text(viewModel.errorMessage!));
                }
                final events = viewModel.filteredEvents;
                if (events.isEmpty) {
                  return Center(child: Text('No events found.'));
                }
                return Column(
                  children: events
                      .map(
                        (event) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 12.0,
                          ), // space between cards
                          child: _buildReminderCard(
                            title: event.title,
                            date: event.date,
                            status: event.status.first,
                            cardColor: viewModel.getStatusColor(event.status.first)
                                // ignore: deprecated_member_use
                            .withOpacity(0.3),
                            statusColor: viewModel.getStatusColor(
                              event.status.first,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
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
                //SizedBox(height: 4.h),
                Text(
                  date,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
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

  String _getEventMonth(String eventDate) {
    try {
      // Try to parse as 'MMMM d' format first (like "September 22")
      if (eventDate.contains(' ')) {
        final parts = eventDate.split(' ');
        if (parts.length >= 2) {
          return parts[0].substring(0, 3); // First 3 letters of month
        }
      }

      // Try to parse as date string
      final parsedDate = DateTime.parse(eventDate);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return months[parsedDate.month - 1];
    } catch (e) {
      // Fallback to current month if parsing fails
      final now = DateTime.now();
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return months[now.month - 1];
    }
  }

  String _getEventDay(String eventDate) {
    try {
      // Try to parse as 'MMMM d' format first (like "September 22")
      if (eventDate.contains(' ')) {
        final parts = eventDate.split(' ');
        if (parts.length >= 2) {
          return parts[1]; // Day part
        }
      }

      // Try to parse as date string
      final parsedDate = DateTime.parse(eventDate);
      return parsedDate.day.toString();
    } catch (e) {
      // Fallback to current day if parsing fails
      return DateTime.now().day.toString();
    }
  }
}
