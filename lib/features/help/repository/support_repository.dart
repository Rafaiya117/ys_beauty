import '../../../api/auth_api_service.dart';

class SupportRepository {
  // Submit support request via API
  Future<Map<String, dynamic>> submitSupportRequest({
    required String email,
    required String description,
  }) async {
    try {
      print('Calling AuthApiService.createSupportRequest...');
      final authApiService = AuthApiService();
      
      final result = await authApiService.createSupportRequest(
        email: email,
        description: description,
      );
      
      if (result != null && result['success'] == true) {
        print('Support request success: ${result['message']}');
        return {
          'success': true,
          'message': result['message'],
          'data': result['data'],
        };
      } else {
        final errorMessage = result?['error'] ?? 'Failed to submit support request';
        print('Support request failed: $errorMessage');
        return {
          'success': false,
          'error': errorMessage,
        };
      }
    } catch (e) {
      print('Support repository error: $e');
      if (e.toString().contains('Network')) {
        return {
          'success': false,
          'error': 'Network error. Please check your connection.',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to submit support request. Please try again.',
        };
      }
    }
  }
}