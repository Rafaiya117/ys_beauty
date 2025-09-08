import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/create_event_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateEventViewModel(),
      child: Consumer<CreateEventViewModel>(
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
                    
                    // Form content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Event/Coordinator field
                            _buildInputField(
                              label: 'Enter Event/ Coordinator',
                              icon: Icons.calendar_today_outlined,
                              controller: viewModel.eventController,
                            ),
                            
                            SizedBox(height: 20.h),
                            
                            // Start/End Times section
                            _buildTimeSection(viewModel),
                            
                            SizedBox(height: 20.h),
                            
                            // Location field
                            _buildInputField(
                              label: 'Choose Location',
                              icon: Icons.location_on_outlined,
                              controller: viewModel.locationController,
                              hasArrow: true,
                            ),
                            
                            SizedBox(height: 20.h),
                            
                            // Booth Fee and Booth Size row
                            Row(
                              children: [
                                Expanded(
                                  child: _buildInputField(
                                    label: 'Enter Booth Fee',
                                    icon: Icons.store_outlined,
                                    controller: viewModel.boothFeeController,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: _buildInputField(
                                    label: 'Enter Booth Size',
                                    icon: Icons.crop_square_outlined,
                                    controller: viewModel.boothSizeController,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 10.h),
                            
                            // Space # field
                            _buildInputField(
                              label: 'Enter Space #',
                              icon: Icons.place_outlined,
                              controller: viewModel.spaceNumberController,
                            ),
                            
                            SizedBox(height: 10.h),
                            
                            // Date field
                            _buildInputField(
                              label: 'Enter Date',
                              icon: Icons.calendar_today_outlined,
                              controller: viewModel.dateController,
                            ),
                            
                              SizedBox(height: 10.h),
                            
                            // Set Reminder field
                            _buildInputField(
                              label: 'Set Reminder',
                              icon: Icons.notifications_outlined,
                              controller: viewModel.reminderController,
                              hasDropdown: true,
                            ),
                            
                            SizedBox(height: 10.h),
                            
                            // Status section
                            _buildStatusSection(viewModel),
                            
                            SizedBox(height: 10.h),
                            
                            // Paid section
                            _buildPaidSection(viewModel),
                            
                            SizedBox(height: 10.h),
                            
                            // Description section
                            _buildDescriptionSection(viewModel),
                            
                            SizedBox(height: 32.h),
                            
                            // Save button
                            _buildSaveButton(viewModel),
                            
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
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: Colors.black,
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Title
          Expanded(
            child: Text(
              'Create Event',
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

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool hasArrow = false,
    bool hasDropdown = false,
  }) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: const Color(0xFF424242),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF424242),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (hasArrow)
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: const Color(0xFF9E9E9E),
            ),
          if (hasDropdown)
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.sp,
              color: const Color(0xFF9E9E9E),
            ),
        ],
      ),
    );
  }

  Widget _buildTimeSection(CreateEventViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.w,
        ),
      ),
      child: Stack(
        children: [
          // Dotted line connecting the dots
          Positioned(
            left: 4.w,
            top: 20.h,
            bottom: 20.h,
            child: Container(
              width: 2.w,
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
          ),
          Column(
            children: [
          // Start time
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Start dot
              Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8A00),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF424242),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Time:',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF424242),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3C4),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0xFFFF8A00),
                    width: 1.5.w,
                  ),
                ),
                child: Text(
                  '12:00 PM',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF424242),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12.h),
          
          // Divider line
          Container(
            height: 1.h,
            color: Colors.black.withValues(alpha: 0.3),
            margin: EdgeInsets.only(left: 24.w, right: 8.w),
          ),
          
          SizedBox(height: 12.h),
          
          // End time
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // End dot
              Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8A00),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  'End',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF424242),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Time:',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF424242),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3C4),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0xFFFF8A00),
                    width: 1.5.w,
                  ),
                ),
                child: Text(
                  '6:00 PM',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF424242),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          ],
        ),
      ],
      ),
    );
  }

  Widget _buildStatusSection(CreateEventViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Status',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: _getStatusColor(viewModel.selectedStatus ?? 'Pending'),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                viewModel.selectedStatus ?? 'Pending',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildStatusOption(
                'Pending',
                Colors.yellow,
                viewModel.selectedStatus == 'Pending',
                () => viewModel.setStatus('Pending'),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatusOption(
                'Denied',
                Colors.red,
                viewModel.selectedStatus == 'Denied',
                () => viewModel.setStatus('Denied'),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildStatusOption(
                'Approved',
                Colors.green,
                viewModel.selectedStatus == 'Approved',
                () => viewModel.setStatus('Approved'),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatusOption(
                'Transfer',
                Colors.blue,
                viewModel.selectedStatus == 'Transfer',
                () => viewModel.setStatus('Transfer'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusOption(String label, Color color, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.5.w,
              ),
              color: isSelected ? Colors.black : Colors.transparent,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF424242),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaidSection(CreateEventViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Paid',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: viewModel.isPaid == true ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                viewModel.isPaid == true ? 'Yes' : 'No',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildPaidOption(
                'Yes',
                Colors.green,
                viewModel.isPaid == true,
                () => viewModel.setPaid(true),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildPaidOption(
                'No',
                Colors.red,
                viewModel.isPaid == false,
                () => viewModel.setPaid(false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaidOption(String label, Color color, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.5.w,
              ),
              color: isSelected ? Colors.black : Colors.transparent,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF424242),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(CreateEventViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Description (Optional)',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3C4),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1.w,
            ),
          ),
          child: TextField(
            controller: viewModel.descriptionController,
            maxLines: 4,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF424242),
            ),
            decoration: InputDecoration(
              hintText: 'Parking details + Transfer details + etc.',
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9E9E9E),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(CreateEventViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A00), Color(0xFFFFC107)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: viewModel.isLoading ? null : viewModel.saveEvent,
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: viewModel.isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.yellow;
      case 'Denied':
        return Colors.red;
      case 'Approved':
        return Colors.green;
      case 'Transfer':
        return Colors.blue;
      default:
        return Colors.yellow;
    }
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF8A00)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const dashWidth = 4.0;
    const dashSpace = 3.0;
    double startY = 0.0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
