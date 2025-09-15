import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../viewmodel/location_viewmodel.dart';
import '../model/location_model.dart';
import '../../../core/router.dart';
import '../../../shared/constants/app_constants.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize locations when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationViewModel>().initializeLocations();
    });
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7), // Light yellow/cream background
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Consumer<LocationViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8A00)),
                    ),
                  );
                }

                return _buildMapView(viewModel);
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
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF1B1B1B),
            ),
            onPressed: () => AppRouter.goBack(),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          SizedBox(width: 12.w),
          // Search field
          Expanded(
            child: _buildSearchBar(),
          ),
          SizedBox(width: 12.w),
          // Find button with gradient
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFE082), Color(0xFFFFB74D)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Handle find action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: const Color(0xFF1B1B1B),
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Find',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1B1B1B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Consumer<LocationViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22.r), // More rounded pill shape
            border: Border.all(
              color: const Color(0xFF1B1B1B),
              width: 1.w,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 18.sp,
                color: const Color(0xFF1B1B1B),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: viewModel.searchController,
                  onChanged: viewModel.setSearchQuery,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF1B1B1B),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF1B1B1B),
                  ),
                ),
              ),
              // Diamond icon (navigation/share icon)
              Icon(
                Icons.navigation,
                size: 18.sp,
                color: const Color(0xFF1B1B1B),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMapView(LocationViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConstants.mapImagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Search overlay
          if (viewModel.searchQuery.isNotEmpty)
            Positioned(
              top: 16.h,
              left: 16.w,
              right: 16.w,
              child: _buildSearchResults(viewModel),
            ),
          // Location markers
          ...viewModel.filteredLocations.map((location) => 
            _buildLocationMarker(location, viewModel)
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildSearchResults(LocationViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: viewModel.filteredLocations.map((location) => 
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: const Color(0xFFFF8A00),
              size: 20.sp,
            ),
            title: Text(
              location.name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1B1B1B),
              ),
            ),
            subtitle: Text(
              location.address,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF757575),
              ),
            ),
            onTap: () {
              viewModel.selectLocation(location);
              viewModel.clearSearch();
            },
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildLocationMarker(LocationModel location, LocationViewModel viewModel) {
    // Convert lat/lng to screen coordinates for the map
    // These are approximate positions based on the map image
    double left = _getMarkerX(location.longitude);
    double top = _getMarkerY(location.latitude);
    
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () => viewModel.selectLocation(location),
        child: Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: viewModel.selectedLocation?.id == location.id 
                ? const Color(0xFFFF8A00) 
                : Colors.red,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Icon(
            Icons.location_on,
            color: Colors.white,
            size: 10.sp,
          ),
        ),
      ),
    );
  }

  double _getMarkerX(double longitude) {
    // Convert longitude to X position on the map
    // Map longitude range: approximately -107.5 to -105.0
    double minLng = -107.5;
    double maxLng = -105.0;
    double normalizedLng = (longitude - minLng) / (maxLng - minLng);
    return 50.w + (normalizedLng * 250.w); // Adjust based on map width
  }

  double _getMarkerY(double latitude) {
    // Convert latitude to Y position on the map
    // Map latitude range: approximately 35.5 to 38.0
    double minLat = 35.5;
    double maxLat = 38.0;
    double normalizedLat = (latitude - minLat) / (maxLat - minLat);
    return 100.h + (normalizedLat * 300.h); // Adjust based on map height
  }
}

class LocationPageWrapper extends StatelessWidget {
  const LocationPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationViewModel(),
      child: const LocationPage(),
    );
  }
}
