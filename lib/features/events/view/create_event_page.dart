import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Show error/success messages
                            if (viewModel.errorMessage != null)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12.w),
                                margin: EdgeInsets.only(bottom: 16.h),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        viewModel.errorMessage!,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: viewModel.clearError,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Event/Coordinator field
                            _buildInputField(
                              label: 'Enter Event/ Coordinator',
                              iconPath: 'assets/icons/create_event_name.svg',
                              controller: viewModel.eventController,
                            ),

                            SizedBox(height: 20.h),

                            // Start/End Times section
                            _buildTimeSection(context, viewModel),

                            SizedBox(height: 20.h),

                            // Location field
                            _buildInputField(
                              label: 'Enter Location',
                              iconPath: 'assets/icons/create_location.svg',
                              controller: viewModel.locationController,
                              hasArrow: false,
                            ),

                            SizedBox(height: 20.h),

                            // Booth Fee and Booth Size row
                            Row(
                              children: [
                                Expanded(
                                  child: _buildInputField(
                                    label: 'Enter Booth Fee',
                                    iconPath: 'assets/icons/create_event_booth.svg',
                                    controller: viewModel.boothFeeController,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: _buildInputField(
                                    label: 'Enter Booth Size',
                                    iconPath: 'assets/icons/create_booth_size.svg',
                                    controller: viewModel.boothSizeController,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10.h),

                            // Space # field
                            _buildInputField(
                              label: 'Enter Space #',
                              iconPath: 'assets/icons/create_event_space.svg',
                              controller: viewModel.spaceNumberController,
                            ),

                            SizedBox(height: 10.h),

                            // Date field
                            _buildDateField(
                              context: context,
                              label: 'Enter Date',
                              iconPath: 'assets/icons/create_event_date.svg',
                              controller: viewModel.dateController,
                              viewModel: viewModel,
                            ),

                            SizedBox(height: 10.h),

                            // Set Reminder field
                            _buildReminderField(
                              context: context,
                              label: 'Set Reminder',
                              iconPath: 'assets/icons/create_reminder.svg',
                              controller: viewModel.reminderController,
                              viewModel: viewModel,
                            ),

                            SizedBox(height: 20.h),

                            // Status section
                            _buildStatusSection(viewModel),

                            SizedBox(height: 20.h),

                            // Paid section
                            _buildPaidSection(viewModel),

                            SizedBox(height: 20.h),

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
            child:SvgPicture.asset(
              'assets/icons/back_button.svg',
              width:16.w,
              height: 12.h,
            ),
            //Icon(Icons.arrow_back_ios, size: 24.sp, color: Colors.black),
          ),
          SizedBox(width: 16.w),
          // Title
          Expanded(
            child: Text(
              'Create Event',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
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
  required String iconPath, // changed from IconData
  required TextEditingController controller,
  bool hasArrow = false,
  bool hasDropdown = false,
}) {
  return Container(
    height: 48.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3C4),
      borderRadius: BorderRadius.circular(12.r),
      //border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
    ),
    child: Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 18.w,
          height: 18.h,
          // ignore: deprecated_member_use
          color: Color(0xFF363636), 
          // ignore: deprecated_member_use
          colorBlendMode: BlendMode.modulate,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: TextField(
            controller: controller,
            style: GoogleFonts.roboto(
              fontSize: 16.sp,
              // color: const Color(0xFF424242),
              color:Colors.black,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black
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


  Widget _buildDateField({
  required BuildContext context,
  required String label,
  required String iconPath, 
  required TextEditingController controller,
  required CreateEventViewModel viewModel,
}) {
  return GestureDetector(
    onTap: () => _showDatePicker(context, viewModel),
    child: Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C4),
        borderRadius: BorderRadius.circular(12.r),
        //border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 18.w,
            height: 18.h,
            color: const Color(0xFF363636),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              controller.text.isEmpty ? label : controller.text,
              style: TextStyle(
                fontSize: 14.sp,
                color: controller.text.isEmpty
                  ? Colors.black
                  : Colors.black,
                fontWeight: controller.text.isEmpty
                  ? FontWeight.w400
                  : FontWeight.w500,
              ),
            ),
          ),
          Icon(
            Icons.calendar_today,
            size: 18.sp,
            color: const Color(0xFF9E9E9E),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildReminderField({
  required BuildContext context,
  required String label,
  required String iconPath, // changed from IconData
  required TextEditingController controller,
  required CreateEventViewModel viewModel,
}) {
  return GestureDetector(
    onTap: () => _showReminderDropdown(context, viewModel),
    child: Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C4),
        borderRadius: BorderRadius.circular(12.r),
        //border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 18.w,
            height: 18.h,
            color: const Color(0xFF363636),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              controller.text.isEmpty ? label : controller.text,
              style: TextStyle(
                fontSize: 14.sp,
                color: controller.text.isEmpty
                    ? Colors.black
                    : Colors.black,
                fontWeight: controller.text.isEmpty
                    ? FontWeight.w400
                    : FontWeight.w500,
              ),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 18.sp,
            color: const Color(0xFF9E9E9E),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildTimeSection(
    BuildContext context,
    CreateEventViewModel viewModel,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
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
              child: CustomPaint(painter: DottedLinePainter()),
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
                        // color: const Color(0xFF424242),
                        color:Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Time:',
                    style: TextStyle(
                      fontSize: 14.sp,
                      // color: const Color(0xFF424242),
                      color:Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => _showTimePicker(context, true, viewModel),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3C4),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: const Color(0xFFFF8A00),
                          width: 1.5.w,
                        ),
                      ),
                      child: Text(
                        viewModel.startTime,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF424242),
                          fontWeight: FontWeight.w500,
                        ),
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
                    width: 10.w,
                    height: 10.h,
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
                        // color: const Color(0xFF424242),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Time:',
                    style: TextStyle(
                      fontSize: 14.sp,
                      // color: const Color(0xFF424242),
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => _showTimePicker(context, false, viewModel),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3C4),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: const Color(0xFFFF8A00),
                          width: 1.5.w,
                        ),
                      ),
                      child: Text(
                        viewModel.endTime,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF424242),
                          fontWeight: FontWeight.w500,
                        ),
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
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
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
              child: Row(
                mainAxisSize: MainAxisSize.min, 
                children: [
                  Container(
                    width: 8.w, 
                    height: 8.w, 
                    margin: EdgeInsets.only(right: 4.w,), 
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9A825), 
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    viewModel.selectedStatus ?? 'Pending',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // <-- CHANGE: Use black text color
                    ),
                  ),
                ],
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

  Widget _buildStatusOption(
    String label,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
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
              border: Border.all(color: Colors.black, width: 1.5.w),
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
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14.sp,
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
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 8.w),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            //   decoration: BoxDecoration(
            //     color: viewModel.isPaid == true ? Colors.green : Colors.red,
            //     borderRadius: BorderRadius.circular(12.r),
            //   ),
            //   child: Text(
            //     viewModel.isPaid == true ? 'Yes' : 'No',
            //     style: TextStyle(
            //       fontSize: 10.sp,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: viewModel.isPaid == true
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    margin: EdgeInsets.only(right: 4.w),
                    decoration: BoxDecoration(
                      // Use the solid color for the dot
                      color: viewModel.isPaid == true
                          ? Colors.green
                          : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    viewModel.isPaid == true ? 'Yes' : 'No',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
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

  Widget _buildPaidOption(
    String label,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
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
              border: Border.all(color: Colors.black, width: 1.5.w),
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
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
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
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3C4),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
          ),
          child: TextField(
            controller: viewModel.descriptionController,
            maxLines: 4,
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF424242)),
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
          colors: [Color(0xFFFFA167), Color(0xFFFFDF6F)],
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
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
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
         return Color(0xFFFFE8A2);
        // return Colors.yellow;
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

  Future<void> _showTimePicker(
  BuildContext context,
  bool isStartTime,
  CreateEventViewModel viewModel,
) async {
  // Parse current time to get initial time for picker
  String currentTime = isStartTime ? viewModel.startTime : viewModel.endTime;
  TimeOfDay initialTime = _parseTimeString(currentTime);

  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime,
    initialEntryMode: TimePickerEntryMode.input, // ✅ Added this line
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: const Color(0xFFFF8A00),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    String formattedTime = _formatTimeOfDay(picked);
    if (isStartTime) {
      viewModel.setStartTime(formattedTime);
    } else {
      viewModel.setEndTime(formattedTime);
    }
  }
}


  TimeOfDay _parseTimeString(String timeString) {
    try {
      // Handle formats like "12:00 PM" or "6:00 PM"
      final parts = timeString.split(' ');
      if (parts.length == 2) {
        final timePart = parts[0];
        final period = parts[1];
        final timeComponents = timePart.split(':');

        if (timeComponents.length == 2) {
          int hour = int.parse(timeComponents[0]);
          int minute = int.parse(timeComponents[1]);

          if (period == 'PM' && hour != 12) {
            hour += 12;
          } else if (period == 'AM' && hour == 12) {
            hour = 0;
          }

          return TimeOfDay(hour: hour, minute: minute);
        }
      }
    } catch (e) {
      // If parsing fails, return default time
    }

    // Default fallback
    return const TimeOfDay(hour: 12, minute: 0);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;

    String period = hour >= 12 ? 'PM' : 'AM';
    int displayHour = hour;

    if (hour == 0) {
      displayHour = 12;
    } else if (hour > 12) {
      displayHour = hour - 12;
    }

    return '${displayHour.toString().padLeft(1)}:${minute.toString().padLeft(2, '0')} $period';
  }

  Future<void> _showDatePicker(
    BuildContext context,
    CreateEventViewModel viewModel,
  ) async {
    // Parse current date to get initial date for picker
    DateTime initialDate = _parseDateString(viewModel.dateController.text);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFFFF8A00),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String formattedDate = _formatDate(picked);
      viewModel.dateController.text = formattedDate;
    }
  }

  DateTime _parseDateString(String dateString) {
    try {
      // Handle common date formats
      if (dateString.isEmpty) {
        return DateTime.now();
      }

      // Try parsing different date formats
      List<String> possibleFormats = [
        'MM/dd/yyyy',
        'dd/MM/yyyy',
        'yyyy-MM-dd',
        'MM-dd-yyyy',
        'dd-MM-yyyy',
      ];

      for (String format in possibleFormats) {
        try {
          // Simple parsing for common formats
          if (format == 'MM/dd/yyyy' && dateString.contains('/')) {
            final parts = dateString.split('/');
            if (parts.length == 3) {
              return DateTime(
                int.parse(parts[2]), // year
                int.parse(parts[0]), // month
                int.parse(parts[1]), // day
              );
            }
          } else if (format == 'dd/MM/yyyy' && dateString.contains('/')) {
            final parts = dateString.split('/');
            if (parts.length == 3) {
              return DateTime(
                int.parse(parts[2]), // year
                int.parse(parts[1]), // month
                int.parse(parts[0]), // day
              );
            }
          }
        } catch (e) {
          continue;
        }
      }
    } catch (e) {
      // If parsing fails, return current date
    }

    // Default fallback
    return DateTime.now();
  }

  String _formatDate(DateTime date) {
    // Format as MM/dd/yyyy
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _showReminderDropdown(
    BuildContext context,
    CreateEventViewModel viewModel,
  ) async {
    final List<String> reminderOptions = [
      'No Reminder',
      '1 day before',
      '2 days before',
      '3 days before',
      '1 week before',
      '2 weeks before',
      '1 month before',
    ];

    final String? selectedReminder = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text(
                  'Select Reminder',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              // Options list - Made scrollable
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: reminderOptions
                        .map(
                          (option) => _buildReminderOption(
                            context: context,
                            option: option,
                            onTap: () {
                              Navigator.pop(context, option);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );

    if (selectedReminder != null) {
      viewModel.reminderController.text = selectedReminder;
    }
  }

  Widget _buildReminderOption({
    required BuildContext context,
    required String option,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          children: [
            Icon(
              Icons.notifications_outlined,
              size: 20.sp,
              color: const Color(0xFF424242),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF424242),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (option == 'No Reminder')
              Icon(Icons.close, size: 18.sp, color: const Color(0xFF9E9E9E))
            else
              Icon(Icons.schedule, size: 18.sp, color: const Color(0xFFFF8A00)),
          ],
        ),
      ),
    );
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
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
