import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/token_storage.dart';

class AuthApiService {
  final String baseUrl = 'http://10.10.13.36';

  Future<bool> registerUser(Map<String, dynamic> formValues) async {
    final url = Uri.parse('$baseUrl/auth/user_registration/');
    final headers = {'Content-Type': 'application/json'};
    final postBody = json.encode(formValues);

    print("SignUp Request URL: $url");
    print("Headers: $headers");
    print("Form data being sent: $postBody");

    try {
      final response = await http.post(url, headers: headers, body: postBody);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 201) {
        print("SignUp success: ${resultBody['message']}");
        return true;
      } else if (response.statusCode == 406) {
        print(
          "SignUp failed - Missing required fields: ${resultBody['error']}",
        );
        return false;
      } else if (response.statusCode == 400) {
        print("SignUp failed - Bad request: ${resultBody['error']}");
        return false;
      } else {
        print("SignUp failed with status ${response.statusCode}: $resultBody");
        return false;
      }
    } catch (e) {
      print('Error during user registration: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login/');
    final headers = {'Content-Type': 'application/json'};
    final postBody = json.encode({'email': email, 'password': password});

    print("Login Request URL: $url");
    print("Headers: $headers");
    print("Form data being sent: $postBody");

    try {
      final response = await http.post(url, headers: headers, body: postBody);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Login success!");
        return {
          'success': true,
          'access_token': resultBody['access'],
          'refresh_token': resultBody['refresh'],
        };
      } else if (response.statusCode == 401) {
        print("Login failed - Invalid credentials: ${resultBody}");
        // Extract the actual error message from the API response
        final errorMessage =
            resultBody['detail'] ?? 'Invalid email or password';
        return {'success': false, 'error': errorMessage};
      } else if (response.statusCode == 400) {
        print("Login failed - Bad request: ${resultBody}");
        // Extract the actual error message from the API response
        final errorMessage =
            resultBody['detail'] ??
            resultBody['error'] ??
            'Invalid request format';
        return {'success': false, 'error': errorMessage};
      } else {
        print("Login failed with status ${response.statusCode}: $resultBody");
        return {'success': false, 'error': 'Login failed. Please try again.'};
      }
    } catch (e) {
      print('Error during user login: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> forgotPassword(String email) async {
    final url = Uri.parse('$baseUrl/auth/forget_passord');
    final headers = {'Content-Type': 'application/json'};
    final postBody = json.encode({'email': email});

    print("Forgot Password Request URL: $url");
    print("Headers: $headers");
    print("Form data being sent: $postBody");

    try {
      final response = await http.post(url, headers: headers, body: postBody);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Forgot Password success: ${resultBody['message']}");
        return {'success': true, 'message': resultBody['message']};
      } else if (response.statusCode == 404) {
        print("Forgot Password failed - Email not found: ${resultBody}");
        return {'success': false, 'error': 'Email address not found'};
      } else if (response.statusCode == 400) {
        print("Forgot Password failed - Bad request: ${resultBody}");
        return {'success': false, 'error': 'Invalid email format'};
      } else {
        print(
          "Forgot Password failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to send OTP. Please try again.',
        };
      }
    } catch (e) {
      print('Error during forgot password: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> verifyOtp(String email, String otp) async {
    final url = Uri.parse('$baseUrl/auth/veryfy_otp/');
    final headers = {'Content-Type': 'application/json'};
    final postBody = json.encode({'email': email, 'otp': otp});

    print("OTP Verification Request URL: $url");
    print("Headers: $headers");
    print("Form data being sent: $postBody");

    try {
      final response = await http.post(url, headers: headers, body: postBody);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("OTP Verification success: ${resultBody['message']}");
        return {
          'success': true,
          'message': resultBody['message'],
          'reset_token': resultBody['reset_token'],
        };
      } else if (response.statusCode == 400) {
        print("OTP Verification failed - Invalid OTP: ${resultBody}");
        return {
          'success': false,
          'error': 'Invalid OTP code. Please try again.',
        };
      } else if (response.statusCode == 404) {
        print("OTP Verification failed - Email not found: ${resultBody}");
        return {'success': false, 'error': 'Email address not found.'};
      } else {
        print(
          "OTP Verification failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'OTP verification failed. Please try again.',
        };
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> resetPassword({
    required String email,
    required String resetToken,
    required String password,
    required String retypePassword,
  }) async {
    final url = Uri.parse('$baseUrl/auth/reset_password/');
    final headers = {'Content-Type': 'application/json'};
    final postBody = json.encode({
      'email': email,
      'reset_token': resetToken,
      'password': password,
      'retype_password': retypePassword,
    });

    print("Reset Password Request URL: $url");
    print("Headers: $headers");
    print("Form data being sent: $postBody");

    try {
      final response = await http.post(url, headers: headers, body: postBody);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Reset Password success: ${resultBody['message']}");
        return {'success': true, 'message': resultBody['message']};
      } else if (response.statusCode == 400) {
        print("Reset Password failed - Invalid data: ${resultBody}");
        return {
          'success': false,
          'error': 'Invalid password or token. Please try again.',
        };
      } else if (response.statusCode == 404) {
        print("Reset Password failed - Token not found: ${resultBody}");
        return {'success': false, 'error': 'Reset token expired or invalid.'};
      } else {
        print(
          "Reset Password failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Password reset failed. Please try again.',
        };
      }
    } catch (e) {
      print('Error during password reset: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    final url = Uri.parse('$baseUrl/user/profile/get');

    // Get access token from storage
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken == null) {
      print('No access token found');
      return {'success': false, 'error': 'User not authenticated'};
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    print("Get Profile Request URL: $url");
    print("Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Get Profile success");
        return {'success': true, 'profile': resultBody};
      } else if (response.statusCode == 401) {
        print("Get Profile failed - Unauthorized: ${resultBody}");
        return {
          'success': false,
          'error': 'Authentication expired. Please login again.',
        };
      } else if (response.statusCode == 404) {
        print("Get Profile failed - Profile not found: ${resultBody}");
        return {'success': false, 'error': 'Profile not found.'};
      } else {
        print(
          "Get Profile failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to fetch profile. Please try again.',
        };
      }
    } catch (e) {
      print('Error during profile fetch: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> updateUserProfile({
    required String firstName,
    required String email,
    required String city,
    required String dateOfBirth,
    required String phone,
    String? profilePhoto,
  }) async {
    final url = Uri.parse('$baseUrl/user/profile/update');

    // Get access token from storage
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken == null) {
      print('No access token found');
      return {'success': false, 'error': 'User not authenticated'};
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final requestBody = {
      'first_name': firstName,
      'email': email,
      'city': city,
      'date_of_birth': dateOfBirth,
      'phone': phone,
    };

    // Only include profile_photo if it's provided and is a URL
    if (profilePhoto != null && profilePhoto.isNotEmpty) {
      if (profilePhoto.startsWith('http://') ||
          profilePhoto.startsWith('https://')) {
        requestBody['profile_photo'] = profilePhoto;
      }
    }

    final postBody = json.encode(requestBody);

    print("Update Profile Request URL: $url");
    print("Headers: $headers");
    print("Request Body: $postBody");

    try {
      final response = await http.put(url, headers: headers, body: postBody);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Update Profile success");
        return {
          'success': true,
          'profile': resultBody,
          'message': 'Profile updated successfully',
        };
      } else if (response.statusCode == 400) {
        print("Update Profile failed - Bad request: ${resultBody}");
        // Handle field-specific errors
        if (resultBody is Map<String, dynamic>) {
          final errors = <String>[];
          resultBody.forEach((key, value) {
            if (value is List) {
              errors.addAll(value.map((e) => '$key: $e'));
            } else {
              errors.add('$key: $value');
            }
          });
          return {'success': false, 'error': errors.join(', ')};
        }
        return {
          'success': false,
          'error': 'Invalid profile data. Please check your inputs.',
        };
      } else if (response.statusCode == 401) {
        print("Update Profile failed - Unauthorized: ${resultBody}");
        return {
          'success': false,
          'error': 'Authentication expired. Please login again.',
        };
      } else if (response.statusCode == 404) {
        print("Update Profile failed - Profile not found: ${resultBody}");
        return {'success': false, 'error': 'Profile not found.'};
      } else {
        print(
          "Update Profile failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to update profile. Please try again.',
        };
      }
    } catch (e) {
      print('Error during profile update: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> uploadProfilePhoto(String filePath) async {
    final url = Uri.parse('$baseUrl/user/profile/photo/');

    // Get access token from storage
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken == null) {
      print('No access token found');
      return {'success': false, 'error': 'User not authenticated'};
    }

    print("Upload Profile Photo Request URL: $url");
    print("File Path: $filePath");

    try {
      // Create multipart request
      final request = http.MultipartRequest('PUT', url);

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $accessToken';

      // Add the file
      final file = await http.MultipartFile.fromPath('profile_photo', filePath);
      request.files.add(file);

      print("Request Headers: ${request.headers}");
      print(
        "Request Files: ${request.files.map((f) => '${f.field}: ${f.filename}')}",
      );

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Profile photo upload success");
        return {
          'success': true,
          'message':
              resultBody['message'] ?? 'Profile photo updated successfully',
          'photo': resultBody['photo'], // Pass the entire photo object
        };
      } else if (response.statusCode == 400) {
        print("Profile photo upload failed - Bad request: ${resultBody}");
        return {
          'success': false,
          'error': 'Invalid file format or size. Please try a different image.',
        };
      } else if (response.statusCode == 401) {
        print("Profile photo upload failed - Unauthorized: ${resultBody}");
        return {
          'success': false,
          'error': 'Authentication expired. Please login again.',
        };
      } else {
        print(
          "Profile photo upload failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to upload profile photo. Please try again.',
        };
      }
    } catch (e) {
      print('Error during profile photo upload: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> createSupportRequest({
    required String email,
    required String description,
  }) async {
    final url = Uri.parse('$baseUrl/user/support/create');

    final headers = {'Content-Type': 'application/json'};

    final requestBody = {'email': email, 'description': description};

    final postBody = json.encode(requestBody);

    print("Create Support Request URL: $url");
    print("Headers: $headers");
    print("Request Body: $postBody");

    try {
      final response = await http.post(url, headers: headers, body: postBody);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Support request created successfully");
        return {
          'success': true,
          'message':
              resultBody['message'] ?? 'Support request submitted successfully',
          'data': resultBody['data'],
        };
      } else if (response.statusCode == 400) {
        print("Support request failed - Bad request: ${resultBody}");
        // Handle field-specific errors
        if (resultBody is Map<String, dynamic>) {
          final errors = <String>[];
          resultBody.forEach((key, value) {
            if (key != 'message' && value is List) {
              errors.addAll(value.map((e) => '$key: $e'));
            } else if (key != 'message') {
              errors.add('$key: $value');
            }
          });
          if (errors.isNotEmpty) {
            return {'success': false, 'error': errors.join(', ')};
          }
        }
        return {
          'success': false,
          'error': 'Invalid request data. Please check your inputs.',
        };
      } else if (response.statusCode == 401) {
        print("Support request failed - Unauthorized: ${resultBody}");
        return {'success': false, 'error': 'Authentication required.'};
      } else {
        print(
          "Support request failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to submit support request. Please try again.',
        };
      }
    } catch (e) {
      print('Error during support request creation: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> changePassword({
    required String oldPassword,
    required String newPassword,
    required String retypePassword,
  }) async {
    final url = Uri.parse('$baseUrl/user/auth/change_password');

    // Get access token from storage
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken == null) {
      print('No access token found');
      return {'success': false, 'error': 'User not authenticated'};
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final requestBody = {
      'old_password': oldPassword,
      'new_password': newPassword,
      'retype_password': retypePassword,
    };

    final postBody = json.encode(requestBody);

    print("Change Password Request URL: $url");
    print("Headers: $headers");
    print("Request Body: $postBody");

    try {
      final response = await http.post(url, headers: headers, body: postBody);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Change password success: ${resultBody['message']}");
        return {
          'success': true,
          'message': resultBody['message'] ?? 'Password changed successfully',
        };
      } else if (response.statusCode == 400) {
        print("Change password failed - Bad request: ${resultBody}");
        // Handle field-specific errors
        if (resultBody is Map<String, dynamic>) {
          final errors = <String>[];
          resultBody.forEach((key, value) {
            if (value is List) {
              errors.addAll(value.map((e) => '$key: $e'));
            } else if (key != 'message') {
              errors.add('$key: $value');
            }
          });
          if (errors.isNotEmpty) {
            return {'success': false, 'error': errors.join(', ')};
          }
        }
        return {
          'success': false,
          'error': 'Invalid password data. Please check your inputs.',
        };
      } else if (response.statusCode == 401) {
        print("Change password failed - Unauthorized: ${resultBody}");
        return {'success': false, 'error': 'Current password is incorrect.'};
      } else {
        print(
          "Change password failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to change password. Please try again.',
        };
      }
    } catch (e) {
      print('Error during password change: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> createEvent(
    Map<String, dynamic> eventData,
  ) async {
    final url = Uri.parse('$baseUrl/event/events/create/');

    // Get access token from storage
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken == null) {
      print('No access token found');
      return {'success': false, 'error': 'User not authenticated'};
    }

    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final postBody = json.encode(eventData);

    print("Create Event Request URL: $url");
    print("Headers: $headers");
    print("Request Body: $postBody");

    try {
      final response = await http.post(url, headers: headers, body: postBody);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Create event success");
        return {
          'success': true,
          'event': resultBody,
          'message': 'Event created successfully',
        };
      } else if (response.statusCode == 400) {
        print("Create event failed - Bad request: ${resultBody}");
        // Handle field-specific errors
        if (resultBody is Map<String, dynamic>) {
          final errors = <String>[];
          resultBody.forEach((key, value) {
            if (value is List) {
              errors.addAll(value.map((e) => '$key: $e'));
            } else if (key != 'message') {
              errors.add('$key: $value');
            }
          });
          if (errors.isNotEmpty) {
            return {'success': false, 'error': errors.join(', ')};
          }
        }
        return {
          'success': false,
          'error': 'Invalid event data. Please check your inputs.',
        };
      } else if (response.statusCode == 401) {
        print("Create event failed - Unauthorized: ${resultBody}");
        return {
          'success': false,
          'error': 'Authentication expired. Please login again.',
        };
      } else {
        print(
          "Create event failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to create event. Please try again.',
        };
      }
    } catch (e) {
      print('Error during event creation: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> getTodayEvents() async {
    final url = Uri.parse('$baseUrl/event/events/today_event_list');

    // Get access token from storage
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken == null) {
      print('No access token found');
      return {'success': false, 'error': 'User not authenticated'};
    }

    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    print("Get Today Events Request URL: $url");
    print("Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Get today events success");
        return {'success': true, 'events': resultBody};
      } else if (response.statusCode == 401) {
        print("Get today events failed - Unauthorized: ${resultBody}");
        return {
          'success': false,
          'error': 'Authentication expired. Please login again.',
        };
      } else if (response.statusCode == 404) {
        print("Get today events failed - Not found: ${resultBody}");
        return {
          'success': true,
          'events': [],
          'message': 'No events found for today',
        };
      } else {
        print(
          "Get today events failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to fetch today\'s events. Please try again.',
        };
      }
    } catch (e) {
      print('Error during fetching today events: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> getEventById(String eventId) async {
    final url = Uri.parse('$baseUrl/event/events/$eventId/');

    // Get access token from storage
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken == null) {
      print('No access token found');
      return {'success': false, 'error': 'User not authenticated'};
    }

    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    print("Get Event By ID Request URL: $url");
    print("Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Get event by ID success");
        return {'success': true, 'event': resultBody};
      } else if (response.statusCode == 401) {
        print("Get event by ID failed - Unauthorized: ${resultBody}");
        return {
          'success': false,
          'error': 'Authentication expired. Please login again.',
        };
      } else if (response.statusCode == 404) {
        print("Get event by ID failed - Not found: ${resultBody}");
        return {'success': false, 'error': 'Event not found.'};
      } else {
        print(
          "Get event by ID failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to fetch event details. Please try again.',
        };
      }
    } catch (e) {
      print('Error during fetching event by ID: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> getUpcomingEvents() async {
    final url = Uri.parse('$baseUrl/event/events/upcomming_event_list');

    // Get access token from storage
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken == null) {
      print('No access token found');
      return {'success': false, 'error': 'User not authenticated'};
    }

    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    print("Get Upcoming Events Request URL: $url");
    print("Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Get upcoming events success");
        return {'success': true, 'events': resultBody};
      } else if (response.statusCode == 401) {
        print("Get upcoming events failed - Unauthorized: ${resultBody}");
        return {
          'success': false,
          'error': 'Authentication expired. Please login again.',
        };
      } else if (response.statusCode == 404) {
        print("Get upcoming events failed - Not found: ${resultBody}");
        return {
          'success': true,
          'events': [],
          'message': 'No upcoming events found',
        };
      } else {
        print(
          "Get upcoming events failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to fetch upcoming events. Please try again.',
        };
      }
    } catch (e) {
      print('Error during fetching upcoming events: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }

  Future<Map<String, dynamic>?> getPastEvents() async {
    final url = Uri.parse('$baseUrl/event/events/past_event_list');

    // Get access token from storage
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken == null) {
      print('No access token found');
      return {'success': false, 'error': 'User not authenticated'};
    }

    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    print("Get Past Events Request URL: $url");
    print("Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);

      print("Response Status Code: ${response.statusCode}");
      final resultBody = json.decode(response.body);
      print("Response Body: $resultBody");

      if (response.statusCode == 200) {
        print("Get past events success");
        return {'success': true, 'events': resultBody};
      } else if (response.statusCode == 401) {
        print("Get past events failed - Unauthorized: ${resultBody}");
        return {
          'success': false,
          'error': 'Authentication expired. Please login again.',
        };
      } else if (response.statusCode == 404) {
        print("Get past events failed - Not found: ${resultBody}");
        return {
          'success': true,
          'events': [],
          'message': 'No past events found',
        };
      } else {
        print(
          "Get past events failed with status ${response.statusCode}: $resultBody",
        );
        return {
          'success': false,
          'error': 'Failed to fetch past events. Please try again.',
        };
      }
    } catch (e) {
      print('Error during fetching past events: $e');
      return {'success': false, 'error': 'Network error. Please try again.'};
    }
  }
}
