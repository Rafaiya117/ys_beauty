import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../model/help_support_model.dart';
import '../repository/support_repository.dart';
import '../../../core/router.dart';

class HelpSupportViewModel extends ChangeNotifier {
  late HelpSupportModel _helpSupportModel;
  final SupportRepository _supportRepository = SupportRepository();

  // Text controllers for form fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController requestDetailsController =
      TextEditingController();

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
  Future<void> submitRequest() async {
    // Validate email
    if (emailController.text.trim().isEmpty) {
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

    // Basic email validation
    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(emailController.text.trim())) {
      _helpSupportModel = _helpSupportModel.copyWith(
        errorMessage: 'Please enter a valid email address',
      );
      notifyListeners();

      // Clear error after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        clearError();
      });
      return;
    }

    // Validate request details
    if (requestDetailsController.text.trim().isEmpty) {
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
    _helpSupportModel = _helpSupportModel.copyWith(
      isLoading: true,
      errorMessage: null,
    );
    notifyListeners();

    try {
      // Submit support request via API
      final result = await _supportRepository.submitSupportRequest(
        email: emailController.text.trim(),
        description: requestDetailsController.text.trim(),
      );

      if (result['success'] == true) {
        _helpSupportModel = _helpSupportModel.copyWith(
          isLoading: false,
          successMessage:
              result['message'] ??
              'Your request has been submitted successfully!',
        );

        // Clear form on success
        emailController.clear();
        requestDetailsController.clear();
        clearAllFiles();

        print('Support request submitted successfully: ${result['data']}');

        // Navigate back to Settings screen after a short delay
        Future.delayed(const Duration(seconds: 1), () {
          AppRouter.goBack();
        });
      } else {
        _helpSupportModel = _helpSupportModel.copyWith(
          isLoading: false,
          errorMessage:
              result['error'] ?? 'Failed to submit request. Please try again.',
        );
        print('Support request failed: ${result['error']}');
      }
    } catch (e) {
      _helpSupportModel = _helpSupportModel.copyWith(
        isLoading: false,
        errorMessage: 'An error occurred. Please try again.',
      );
      print('Support request exception: $e');
    }

    notifyListeners();

    // Clear messages after delay
    if (_helpSupportModel.successMessage != null) {
      Future.delayed(const Duration(seconds: 5), () {
        clearSuccess();
      });
    }

    if (_helpSupportModel.errorMessage != null) {
      Future.delayed(const Duration(seconds: 5), () {
        clearError();
      });
    }
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
