import '../model/feedback_model.dart';

class FeedbackRepository {
  // Mock data for feedback submissions
  List<FeedbackModel> _feedbackList = [
    FeedbackModel(
      id: '1',
      feedback: 'Great app! The interface is very user-friendly and intuitive.',
      email: 'user1@example.com',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      status: 'reviewed',
    ),
    FeedbackModel(
      id: '2',
      feedback: 'Would love to see more customization options for the calendar view.',
      email: 'user2@example.com',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      status: 'pending',
    ),
    FeedbackModel(
      id: '3',
      feedback: 'The notification system works perfectly. Keep up the good work!',
      email: 'user3@example.com',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      status: 'reviewed',
    ),
  ];

  Future<bool> submitFeedback(String feedback, String email) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 1000));
    
    try {
      // Create new feedback entry
      final newFeedback = FeedbackModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        feedback: feedback,
        email: email,
        createdAt: DateTime.now(),
        status: 'pending',
      );
      
      // Add to mock list
      _feedbackList.insert(0, newFeedback);
      
      // Simulate success
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<FeedbackModel>> getAllFeedback() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _feedbackList;
  }

  Future<FeedbackModel?> getFeedbackById(String id) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _feedbackList.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateFeedbackStatus(String id, String status) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      final index = _feedbackList.indexWhere((item) => item.id == id);
      if (index != -1) {
        _feedbackList[index] = _feedbackList[index].copyWith(status: status);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
