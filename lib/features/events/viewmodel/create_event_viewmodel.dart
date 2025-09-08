import 'package:flutter/material.dart';
import '../model/create_event_model.dart';
import '../repository/create_event_repository.dart';

class CreateEventViewModel extends ChangeNotifier {
  final CreateEventRepository _repository = CreateEventRepository();
  
  late CreateEventModel _createEventModel;
  
  // Text controllers
  final TextEditingController eventController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController boothFeeController = TextEditingController();
  final TextEditingController boothSizeController = TextEditingController();
  final TextEditingController spaceNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Constructor
  CreateEventViewModel() {
    _createEventModel = CreateEventModel();
    _initializeControllers();
  }

  // Getters
  CreateEventModel get createEventModel => _createEventModel;
  bool get isLoading => _createEventModel.isLoading;
  String? get errorMessage => _createEventModel.errorMessage;
  String? get selectedStatus => _createEventModel.selectedStatus;
  bool? get isPaid => _createEventModel.isPaid;

  void _initializeControllers() {
    // Add listeners to update model when text changes
    eventController.addListener(_updateEvent);
    locationController.addListener(_updateLocation);
    boothFeeController.addListener(_updateBoothFee);
    boothSizeController.addListener(_updateBoothSize);
    spaceNumberController.addListener(_updateSpaceNumber);
    dateController.addListener(_updateDate);
    reminderController.addListener(_updateReminder);
    descriptionController.addListener(_updateDescription);
  }

  void _updateEvent() {
    _createEventModel = _createEventModel.copyWith(event: eventController.text);
    notifyListeners();
  }

  void _updateLocation() {
    _createEventModel = _createEventModel.copyWith(location: locationController.text);
    notifyListeners();
  }

  void _updateBoothFee() {
    _createEventModel = _createEventModel.copyWith(boothFee: boothFeeController.text);
    notifyListeners();
  }

  void _updateBoothSize() {
    _createEventModel = _createEventModel.copyWith(boothSize: boothSizeController.text);
    notifyListeners();
  }

  void _updateSpaceNumber() {
    _createEventModel = _createEventModel.copyWith(spaceNumber: spaceNumberController.text);
    notifyListeners();
  }

  void _updateDate() {
    _createEventModel = _createEventModel.copyWith(date: dateController.text);
    notifyListeners();
  }

  void _updateReminder() {
    _createEventModel = _createEventModel.copyWith(reminder: reminderController.text);
    notifyListeners();
  }

  void _updateDescription() {
    _createEventModel = _createEventModel.copyWith(description: descriptionController.text);
    notifyListeners();
  }

  void setStatus(String status) {
    _createEventModel = _createEventModel.copyWith(selectedStatus: status);
    notifyListeners();
  }

  void setPaid(bool paid) {
    _createEventModel = _createEventModel.copyWith(isPaid: paid);
    notifyListeners();
  }

  Future<void> saveEvent() async {
    if (_validateForm()) {
      _createEventModel = _createEventModel.copyWith(isLoading: true, errorMessage: null);
      notifyListeners();

      try {
        await _repository.createEvent(_createEventModel);
        
        // Show success message
        _showSuccessMessage();
        
        // Reset form
        _resetForm();
        
      } catch (e) {
        _createEventModel = _createEventModel.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        );
        notifyListeners();
      }
    }
  }

  bool _validateForm() {
    if (eventController.text.trim().isEmpty) {
      _createEventModel = _createEventModel.copyWith(
        errorMessage: 'Please enter event/coordinator name',
      );
      notifyListeners();
      return false;
    }

    if (locationController.text.trim().isEmpty) {
      _createEventModel = _createEventModel.copyWith(
        errorMessage: 'Please choose a location',
      );
      notifyListeners();
      return false;
    }

    if (boothFeeController.text.trim().isEmpty) {
      _createEventModel = _createEventModel.copyWith(
        errorMessage: 'Please enter booth fee',
      );
      notifyListeners();
      return false;
    }

    if (boothSizeController.text.trim().isEmpty) {
      _createEventModel = _createEventModel.copyWith(
        errorMessage: 'Please enter booth size',
      );
      notifyListeners();
      return false;
    }

    if (spaceNumberController.text.trim().isEmpty) {
      _createEventModel = _createEventModel.copyWith(
        errorMessage: 'Please enter space number',
      );
      notifyListeners();
      return false;
    }

    if (dateController.text.trim().isEmpty) {
      _createEventModel = _createEventModel.copyWith(
        errorMessage: 'Please enter date',
      );
      notifyListeners();
      return false;
    }

    if (_createEventModel.selectedStatus == null) {
      _createEventModel = _createEventModel.copyWith(
        errorMessage: 'Please select a status',
      );
      notifyListeners();
      return false;
    }

    if (_createEventModel.isPaid == null) {
      _createEventModel = _createEventModel.copyWith(
        errorMessage: 'Please select payment status',
      );
      notifyListeners();
      return false;
    }

    return true;
  }

  void _showSuccessMessage() {
    // This would typically show a snackbar or dialog
    // For now, we'll just clear the error message
    _createEventModel = _createEventModel.copyWith(
      isLoading: false,
      errorMessage: null,
    );
    notifyListeners();
  }

  void _resetForm() {
    eventController.clear();
    locationController.clear();
    boothFeeController.clear();
    boothSizeController.clear();
    spaceNumberController.clear();
    dateController.clear();
    reminderController.clear();
    descriptionController.clear();
    
    _createEventModel = CreateEventModel();
    notifyListeners();
  }

  void clearError() {
    _createEventModel = _createEventModel.copyWith(errorMessage: null);
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
