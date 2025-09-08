import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../model/help_support_model.dart';

class HelpSupportViewModel extends ChangeNotifier {
  late HelpSupportModel _helpSupportModel;
  
  // Text controllers for form fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController requestDetailsController = TextEditingController();
  
  // File picker instance
  final ImagePicker _picker = ImagePicker();
  
  // Selected files
  List<File> selectedFiles = [];

  // Constructor - initialize data immediately
  HelpSupportViewModel() {
    _initializeData();
  }

  // Getters
  HelpSupportModel get helpSupportModel => _helpSupportModel;
  bool get isLoading => _helpSupportModel.isLoading;
  String? get errorMessage => _helpSupportModel.errorMessage;
  String? get successMessage => _helpSupportModel.successMessage;
  List<HelpItem> get helpItems => _helpSupportModel.helpItems;
  List<ContactMethod> get contactMethods => _helpSupportModel.contactMethods;

  void _initializeData() {
    _helpSupportModel = const HelpSupportModel();
    notifyListeners();
  }

  // Handle file upload tap
  void onFileUploadTap() {
    _showFilePickerOptions();
  }

  // Show file picker options
  void _showFilePickerOptions() {
    // For now, we'll use a simple approach to pick files
    // In a real app, you might want to use file_picker package for more file types
    _pickFromGallery();
  }

  // Pick file from gallery
  Future<void> _pickFromGallery() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (file != null) {
        selectedFiles.add(File(file.path));
        notifyListeners();
        
        _helpSupportModel = _helpSupportModel.copyWith(
          successMessage: 'File added successfully!',
        );
        notifyListeners();
        
        // Clear message after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          clearSuccess();
        });
      }
    } catch (e) {
      _helpSupportModel = _helpSupportModel.copyWith(
        errorMessage: 'Failed to pick file: ${e.toString()}',
      );
      notifyListeners();
      
      // Clear error after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        clearError();
      });
    }
  }

  // Remove selected file
  void removeFile(int index) {
    if (index >= 0 && index < selectedFiles.length) {
      selectedFiles.removeAt(index);
      notifyListeners();
    }
  }

  // Clear all selected files
  void clearAllFiles() {
    selectedFiles.clear();
    notifyListeners();
  }

  // Submit request
  void submitRequest() {
    if (emailController.text.isEmpty) {
      _helpSupportModel = _helpSupportModel.copyWith(
        errorMessage: 'Please enter your email address',
      );
      notifyListeners();
      
      // Clear error after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        clearError();
      });
      return;
    }

    if (requestDetailsController.text.isEmpty) {
      _helpSupportModel = _helpSupportModel.copyWith(
        errorMessage: 'Please enter your request details',
      );
      notifyListeners();
      
      // Clear error after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        clearError();
      });
      return;
    }

    // Set loading state
    _helpSupportModel = _helpSupportModel.copyWith(isLoading: true);
    notifyListeners();

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      _helpSupportModel = _helpSupportModel.copyWith(
        isLoading: false,
        successMessage: 'Your request has been submitted successfully!',
      );
      notifyListeners();
      
      // Clear form
      emailController.clear();
      requestDetailsController.clear();
      clearAllFiles();
      
      // Clear success message after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        clearSuccess();
      });
    });
  }

  // Clear error message
  void clearError() {
    if (_helpSupportModel.errorMessage != null) {
      _helpSupportModel = _helpSupportModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_helpSupportModel.successMessage != null) {
      _helpSupportModel = _helpSupportModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    requestDetailsController.dispose();
    super.dispose();
  }
}
