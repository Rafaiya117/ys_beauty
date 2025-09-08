import 'package:flutter/material.dart';
import '../model/feedback_model.dart';
import '../repository/feedback_repository.dart';

class FeedbackViewModel extends ChangeNotifier {
  final FeedbackRepository _repository = FeedbackRepository();
  
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  bool _isSubmitting = false;
  bool _isSuccess = false;
  String? _error;
  List<FeedbackModel> _feedbackList = [];

  // Getters
  TextEditingController get feedbackController => _feedbackController;
  TextEditingController get emailController => _emailController;
  bool get isSubmitting => _isSubmitting;
  bool get isSuccess => _isSuccess;
  String? get error => _error;
  List<FeedbackModel> get feedbackList => _feedbackList;

  // Load feedback list
  Future<void> loadFeedback() async {
    try {
      _feedbackList = await _repository.getAllFeedback();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load feedback: ${e.toString()}');
    }
  }

  // Submit feedback
  Future<void> submitFeedback() async {
    if (_feedbackController.text.trim().isEmpty) {
      _setError('Please enter your feedback');
      return;
    }

    _setSubmitting(true);
    _clearError();
    _clearSuccess();
    
    try {
      final success = await _repository.submitFeedback(
        _feedbackController.text.trim(),
        _emailController.text.trim(),
      );
      
      if (success) {
        _setSuccess(true);
        _clearForm();
        await loadFeedback(); // Refresh the list
      } else {
        _setError('Failed to submit feedback. Please try again.');
      }
    } catch (e) {
      _setError('Failed to submit feedback: ${e.toString()}');
    } finally {
      _setSubmitting(false);
    }
  }

  // Clear form
  void _clearForm() {
    _feedbackController.clear();
    _emailController.clear();
  }

  // Clear error
  void clearError() {
    _clearError();
  }

  // Clear success
  void clearSuccess() {
    _clearSuccess();
  }

  // Helper methods
  void _setSubmitting(bool submitting) {
    _isSubmitting = submitting;
    notifyListeners();
  }

  void _setSuccess(bool success) {
    _isSuccess = success;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  void _clearSuccess() {
    _isSuccess = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
