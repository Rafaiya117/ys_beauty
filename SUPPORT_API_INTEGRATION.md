# Support API Integration Documentation

## Overview
This document explains the implementation of the Help & Support API integration using the POST method for endpoint `http://10.10.13.36/user/support/create`.

## API Specification
- **URL**: `http://10.10.13.36/user/support/create`
- **Method**: POST
- **Content-Type**: application/json
- **Authentication**: None required (public endpoint)

### API Request Structure
```json
{
  "email": "user@example.com",
  "description": "string"
}
```

### API Response Structure

**Success Response (200/201):**
```json
{
  "message": "Support request submitted successfully",
  "data": {
    "id": 2,
    "email": "user@example.com",
    "description": "string"
  }
}
```

**Error Response (400):**
```json
{
  "email": ["Enter a valid email address."],
  "description": ["This field is required."]
}
```

## Implementation Files

### 1. API Service Layer
**File**: `lib/api/auth_api_service.dart`
- Added `createSupportRequest()` method
- Handles POST request to support endpoint
- No authentication required (public endpoint)
- Comprehensive error handling for all response codes

```dart
Future<Map<String, dynamic>?> createSupportRequest({
  required String email,
  required String description,
}) async {
  final url = Uri.parse('$baseUrl/user/support/create');
  
  final headers = {
    'Content-Type': 'application/json',
  };

  final requestBody = {
    'email': email,
    'description': description,
  };
  
  // ... API call and error handling
}
```

### 2. Data Models
**File**: `lib/features/help/model/support_request_model.dart`
- New `SupportRequestModel` class matching API response
- Includes `fromJson()` factory constructor
- Supports response data structure with id, email, description

### 3. Repository Layer
**File**: `lib/features/help/repository/support_repository.dart`
- Dedicated repository for support operations
- Handles API errors with specific messages
- Network error handling

```dart
Future<Map<String, dynamic>> submitSupportRequest({
  required String email,
  required String description,
}) async {
  // ... API integration with proper error handling
}
```

### 4. ViewModel Layer
**File**: `lib/features/help/viewmodel/help_support_viewmodel.dart` (Updated)
- Updated `submitRequest()` method to use real API
- Enhanced validation for email format and required fields
- Real-time error and success handling
- Form clearing after successful submission

```dart
Future<void> submitRequest() async {
  // Validation
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
      .hasMatch(emailController.text.trim())) {
    // Handle email validation error
  }
  
  // API call
  final result = await _supportRepository.submitSupportRequest(
    email: emailController.text.trim(),
    description: requestDetailsController.text.trim(),
  );
  
  // Handle response
}
```

### 5. Example Usage
**File**: `lib/features/help/view/support_api_example.dart`
- Demonstrates complete support request flow
- Shows loading states and error handling
- Example integration patterns

## How to Use

### Option 1: Using HelpSupportViewModel (Existing Integration)
```dart
final viewModel = HelpSupportViewModel();

// Set form data
viewModel.emailController.text = 'user@example.com';
viewModel.requestDetailsController.text = 'My support request description';

// Submit request
await viewModel.submitRequest();

// Check result
if (viewModel.successMessage != null) {
  print('Success: ${viewModel.successMessage}');
} else if (viewModel.errorMessage != null) {
  print('Error: ${viewModel.errorMessage}');
}
```

### Option 2: Direct Repository Usage
```dart
final supportRepository = SupportRepository();

final result = await supportRepository.submitSupportRequest(
  email: 'user@example.com',
  description: 'My support request description',
);

if (result['success'] == true) {
  print('Request ID: ${result['data']['id']}');
  print('Message: ${result['message']}');
} else {
  print('Error: ${result['error']}');
}
```

## Form Validation

### Client-Side Validation
- **Email**: Required field with format validation (regex pattern)
- **Description**: Required field, cannot be empty
- **Real-time feedback**: Immediate validation on form submission

### Server-Side Validation
- API returns field-specific errors in 400 responses
- Errors are parsed and displayed to users
- Multiple field errors are combined into readable messages

## Error Handling
The integration handles various error scenarios:

1. **400 Bad Request**: Field-specific validation errors
2. **401 Unauthorized**: Authentication errors (if endpoint becomes protected)
3. **Network Errors**: "Network error. Please check your connection."
4. **Validation Errors**: Client-side validation with immediate feedback

## User Experience Flow

### Before API Integration
1. ❌ Form submission was simulated
2. ❌ No real data persistence
3. ❌ Mock success messages

### After API Integration
1. ✅ Real API submission to backend
2. ✅ Actual support request creation with ID
3. ✅ Proper error handling and user feedback
4. ✅ Form validation with email format checking
5. ✅ Success confirmation with request details
6. ✅ Automatic navigation back to Settings screen

## Testing the Integration

### Manual Testing Steps
1. **Open Help & Support Page**
2. **Enter valid email** (e.g., user@example.com)
3. **Enter description** (any text)
4. **Click Submit**
   - Verify loading state shows
   - Verify success message appears
   - Verify form clears after success
   - Verify automatic navigation back to Settings screen
5. **Test validation**:
   - Leave email empty → Error message
   - Enter invalid email → Email format error
   - Leave description empty → Required field error

### Error Testing
1. **Invalid Email**: Enter "invalid-email" → Format validation error
2. **Empty Fields**: Leave fields empty → Required field errors
3. **Network Error**: Test with no internet → Network error message

## Console Output Examples

### Successful Submission
```
I/flutter: Calling AuthApiService.createSupportRequest...
I/flutter: Create Support Request URL: http://10.10.13.36/user/support/create
I/flutter: Request Body: {"email":"user@example.com","description":"Test support request"}
I/flutter: Response Status Code: 200
I/flutter: Response Body: {message: Support request submitted successfully, data: {id: 2, email: user@example.com, description: Test support request}}
I/flutter: Support request created successfully
I/flutter: Support request submitted successfully: {id: 2, email: user@example.com, description: Test support request}
```

### Validation Error
```
I/flutter: Response Status Code: 400
I/flutter: Support request failed - Bad request: {email: [Enter a valid email address.]}
I/flutter: Support request failed: email: Enter a valid email address.
```

## Integration Features

### Key Benefits
- ✅ Real API integration with POST /user/support/create
- ✅ No authentication required (public endpoint)
- ✅ Comprehensive form validation
- ✅ Real-time error handling
- ✅ Success confirmation with request ID
- ✅ Automatic form clearing after success
- ✅ User-friendly error messages
- ✅ Loading states for better UX
- ✅ Automatic navigation back to Settings screen

### Technical Features
- ✅ JSON request/response handling
- ✅ Field-specific error parsing
- ✅ Network error handling
- ✅ Email format validation
- ✅ Required field validation
- ✅ Clean architecture with repository pattern
- ✅ Proper state management
- ✅ Automatic navigation flow (Help & Support → Settings)

## File Structure
```
lib/
├── api/
│   └── auth_api_service.dart (Updated - added createSupportRequest)
├── features/help/
│   ├── model/
│   │   ├── help_support_model.dart (Existing)
│   │   └── support_request_model.dart (New)
│   ├── repository/
│   │   └── support_repository.dart (New)
│   ├── viewmodel/
│   │   └── help_support_viewmodel.dart (Updated - real API)
│   └── view/
│       ├── help_support_page.dart (Existing - unchanged)
│       └── support_api_example.dart (New - example usage)
```

## API Integration Complete ✅
- POST /user/support/create endpoint integrated
- Real-time form validation
- Comprehensive error handling
- Success response with request details
- User-friendly feedback messages
- Complete support request flow functional