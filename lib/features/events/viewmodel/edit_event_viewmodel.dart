import 'package:flutter/material.dart';
import '../model/edit_event_model.dart';
import '../repository/edit_event_repository.dart';

class EditEventViewModel extends ChangeNotifier {
  final EditEventRepository _repository = EditEventRepository();
  
  // Form controllers
  final TextEditingController eventController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController boothFeeController = TextEditingController();
  final TextEditingController boothSizeController = TextEditingController();
  final TextEditingController spaceNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  // State variables
  bool _isLoading = false;
  bool _isSaving = false;
  String? _errorMessage;
  String? _successMessage;
  EditEventModel? _eventData;
  String? _selectedStatus;
  bool? _isPaid;
  String? _startTime;
  String? _endTime;
  
  // Getters
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  EditEventModel? get eventData => _eventData;
  String? get selectedStatus => _selectedStatus;
  bool? get isPaid => _isPaid;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  
  // Load event data for editing
  Future<void> loadEventForEdit(String eventId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      _eventData = await _repository.fetchEventForEdit(eventId);
      _populateFormFields();
    } catch (e) {
      _errorMessage = 'Failed to load event data: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Populate form fields with loaded data
  void _populateFormFields() {
    if (_eventData != null) {
      eventController.text = _eventData!.title;
      locationController.text = _eventData!.location;
      boothFeeController.text = _eventData!.fee.replaceAll('\$', '');
      boothSizeController.text = _eventData!.boothSize;
      spaceNumberController.text = _eventData!.spaceNumber;
      dateController.text = _eventData!.date;
      reminderController.text = _eventData!.reminder;
      descriptionController.text = _eventData!.description;
      
      // Set status and paid state
      _selectedStatus = _eventData!.status.first;
      _isPaid = _eventData!.isPaid;
      _startTime = _eventData!.startTime;
      _endTime = _eventData!.endTime;
    }
  }
  
  // Set status
  void setStatus(String status) {
    _selectedStatus = status;
    notifyListeners();
  }
  
  // Set paid status
  void setPaid(bool paid) {
    _isPaid = paid;
    notifyListeners();
  }
  
  // Set start time
  void setStartTime(String time) {
    _startTime = time;
    notifyListeners();
  }
  
  // Set end time
  void setEndTime(String time) {
    _endTime = time;
    notifyListeners();
  }
  
  // Validate form
  bool _validateForm() {
    if (eventController.text.trim().isEmpty) {
      _errorMessage = 'Event/Coordinator is required';
      return false;
    }
    if (locationController.text.trim().isEmpty) {
      _errorMessage = 'Location is required';
      return false;
    }
    if (boothFeeController.text.trim().isEmpty) {
      _errorMessage = 'Booth fee is required';
      return false;
    }
    if (boothSizeController.text.trim().isEmpty) {
      _errorMessage = 'Booth size is required';
      return false;
    }
    if (spaceNumberController.text.trim().isEmpty) {
      _errorMessage = 'Space number is required';
      return false;
    }
    if (dateController.text.trim().isEmpty) {
      _errorMessage = 'Date is required';
      return false;
    }
    if (_selectedStatus == null) {
      _errorMessage = 'Status is required';
      return false;
    }
    if (_isPaid == null) {
      _errorMessage = 'Paid status is required';
      return false;
    }
    if (_startTime == null || _endTime == null) {
      _errorMessage = 'Start and end times are required';
      return false;
    }
    return true;
  }
  
  // Save event
  Future<void> saveEvent() async {
    if (!_validateForm()) {
      notifyListeners();
      return;
    }
    
    _isSaving = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
    
    try {
      // Create updated event model
      final updatedEvent = EditEventModel(
        id: _eventData?.id ?? '',
        title: eventController.text.trim(),
        description: descriptionController.text.trim(),
        date: dateController.text.trim(),
        location: locationController.text.trim(),
        fee: '\$${boothFeeController.text.trim()}',
        spaceNumber: spaceNumberController.text.trim(),
        boothSize: boothSizeController.text.trim(),
        startTime: _startTime!,
        endTime: _endTime!,
        status: _isPaid! ? [_selectedStatus!, 'Paid'] : [_selectedStatus!, 'Unpaid'],
        isPaid: _isPaid!,
        reminder: reminderController.text.trim(),
      );
      
      // Update event
      final success = await _repository.updateEvent(updatedEvent);
      
      if (success) {
        _successMessage = 'Event updated successfully!';
        _eventData = updatedEvent;
      } else {
        _errorMessage = 'Failed to update event';
      }
    } catch (e) {
      _errorMessage = 'Error updating event: ${e.toString()}';
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
  
  // Get status color
  Color getStatusColor(String status) {
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
  
  // Clear messages
  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
  
  @override
  void dispose() {
    eventController.dispose();
    locationController.dispose();
    boothFeeController.dispose();
    boothSizeController.dispose();
    spaceNumberController.dispose();
    dateController.dispose();
    reminderController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
