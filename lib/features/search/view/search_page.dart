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
                    _buildSearchBar(viewModel),
                    
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
              Icons.arrow_back,
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
          
          SizedBox(width: 16.w),
          
          // Greeting text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Search',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16.sp,
                    color: const Color(0xFF424242),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Find Events',
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
          
          // Empty space to balance the back button
          SizedBox(width: 40.w),
        ],
      ),
    );
  }

  Widget _buildSearchBar(SearchViewModel viewModel) {
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
            onTap: () {
              // Handle filter functionality
            },
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
}
