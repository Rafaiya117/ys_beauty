import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodel/search_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../core/router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(),
      child: Consumer<SearchViewModel>(
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
                    
                    // Search bar
                    _buildSearchBar(context, viewModel),
                    
                    SizedBox(height: 20.h),
                    
                    // Search results
                    Expanded(
                      child: _buildSearchResults(viewModel),
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
            child: Icon(
              Icons.arrow_back_ios,
              size: 24.sp,
              color: const Color(0xFF424242),
            ),
          ),
          
          SizedBox(width: 16.w),
          
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
          
          SizedBox(width: 8.w),
          
          // Greeting text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Search Events',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16.sp,
                    color: const Color(0xFF424242),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Empty space to balance the back button
          SizedBox(width: 40.w),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, SearchViewModel viewModel) {
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
                    child: TextField(
                      controller: viewModel.searchController,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF424242),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) {
                        viewModel.search(value);
                      },
                      autofocus: true,
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
                  //     color: Colors.black,
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
                      color: Colors.black,
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

  Widget _buildSearchResults(SearchViewModel viewModel) {
    if (viewModel.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            const Color(0xFFFF8A00),
          ),
        ),
      );
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: Colors.red,
            ),
            SizedBox(height: 16.h),
            Text(
              viewModel.errorMessage!,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => viewModel.clearError(),
              child: Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (viewModel.query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64.sp,
              color: const Color(0xFF9E9E9E),
            ),
            SizedBox(height: 16.h),
            Text(
              'Search for events, locations, or dates',
              style: TextStyle(
                fontSize: 18.sp,
                color: const Color(0xFF424242),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Type in the search bar above to find what you\'re looking for',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF757575),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (viewModel.results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64.sp,
              color: const Color(0xFF9E9E9E),
            ),
            SizedBox(height: 16.h),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 18.sp,
                color: const Color(0xFF424242),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Try searching with different keywords',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF757575),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${viewModel.results.length} result${viewModel.results.length == 1 ? '' : 's'} found',
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFF757575),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.results.length,
              itemBuilder: (context, index) {
                final result = viewModel.results[index];
                return _buildSearchResultItem(result);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(result) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8A00).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(
              Icons.event,
              size: 24.sp,
              color: const Color(0xFFFF8A00),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF424242),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  result.date,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  result.location,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF757575),
                  ),
                ),
                if (result.description != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    result.description!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF9E9E9E),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9E9E9E),
          ),
        ],
      ),
    );
  }

  void _showFilterModal(BuildContext context, SearchViewModel viewModel) {
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
                            isSelected: false,
                            onTap: () {
                              Navigator.of(context).pop();
                              // Handle Events filter
                            },
                          ),
                          _buildFilterOption(
                            icon: Icons.person_outline,
                            title: 'Coordinator',
                            isSelected: false,
                            onTap: () {
                              Navigator.of(context).pop();
                              // Handle Coordinator filter
                            },
                          ),
                          _buildFilterOption(
                            icon: Icons.calendar_today_outlined,
                            title: 'Date',
                            isSelected: false,
                            onTap: () {
                              Navigator.of(context).pop();
                              AppRouter.navigateToAvailableEvent();
                            },
                          ),
                          // _buildFilterOption(
                          //   icon: Icons.location_on_outlined,
                          //   title: 'Location',
                          //   isSelected: false,
                          //   onTap: () {
                          //     Navigator.of(context).pop();
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
                  color: isSelected ? const Color(0xFFFF8A00).withValues(alpha: 0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 24.sp,
                      color: isSelected ? const Color(0xFFFF8A00) : Colors.black,
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: isSelected ? const Color(0xFFFF8A00) : Colors.black,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
}
