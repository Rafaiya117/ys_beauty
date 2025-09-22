# Profile API Integration Documentation

## Overview
This document explains the implementation of the user profile API integration using GET and PUT methods for profile management.

## API Specifications

### Get Profile
- **URL**: `http://10.10.13.36/user/profile/get`
- **Method**: GET
- **Authentication**: JWT Bearer token (from login)
- **Response Format**: JSON

### Update Profile  
- **URL**: `http://10.10.13.36/user/profile/update`
- **Method**: PUT
- **Authentication**: JWT Bearer token (from login)
- **Content-Type**: application/json
- **Request Format**: JSON

### API Response Structures

**Get Profile Response:**
```json
{
  "first_name": "",
  "email": "office.simantaroy@gmail.com",
  "city": null,
  "date_of_birth": null,
  "profile_photo": null,
  "phone": null
}
```

**Update Profile Request:**
```json
{
  "first_name": "Tousif",
  "email": "bocax95317@camjoint.com",
  "city": "Dhaka",
  "date_of_birth": "2025-09-21",
  "profile_photo": "https://example.com/image.jpg",
  "phone": "01641752424"
}
```

**Update Profile Success Response:**
```json
{
  "first_name": "Tousif",
  "email": "bocax95317@camjoint.com",
  "city": "Dhaka",
  "date_of_birth": "2025-09-21",
  "profile_photo": "https://example.com/image.jpg",
  "phone": "01641752424"
}
```

**Update Profile Error Response (400):**
```json
{
  "profile_photo": [
    "The submitted data was not a file. Check the encoding type on the form."
  ]
}
```

## Implementation Files

### 1. API Service Layer
**File**: `lib/api/auth_api_service.dart`
- Added `getUserProfile()` method for fetching profile data
- Added `updateUserProfile()` method for updating profile data
- Uses JWT authentication with Bearer token
- Handles error responses (401, 404, 400, etc.)
- Returns structured response with success/error status
- Special handling for profile_photo field validation

```dart
// Get Profile
Future<Map<String, dynamic>?> getUserProfile() async {
  final url = Uri.parse('$baseUrl/user/profile/get');
  final accessToken = await TokenStorage.getAccessToken();
  
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
  
  // ... API call and error handling
}

// Update Profile
Future<Map<String, dynamic>?> updateUserProfile({
  required String firstName,
  required String email,
  required String city,
  required String dateOfBirth,
  required String phone,
  String? profilePhoto,
}) async {
  final url = Uri.parse('$baseUrl/user/profile/update');
  // ... PUT request with JSON body
}
```

### 2. Data Models
**File**: `lib/features/account/model/profile_model.dart`
- New `ProfileModel` class matching API response structure
- Includes `fromJson()` factory constructor
- Supports nullable fields (city, date_of_birth, profile_photo, phone)

**File**: `lib/features/account/model/account_model.dart` (Updated)
- Added `fromProfile()` factory constructor
- Added phone field support
- Maintains compatibility with existing account system

### 3. Repository Layer
**File**: `lib/features/account/repository/profile_repository.dart` (Updated)
- Dedicated repository for profile operations
- Handles API errors with specific messages
- Implemented `getUserProfile()` for fetching profile data
- Implemented `updateUserProfile()` for updating profile data

**File**: `lib/features/account/repository/account_repository.dart` (Updated)
- Updated `fetchAccountInformation()` to use real API
- Updated `updateAccountInformation()` to use real API
- Integrated with ProfileModel for data conversion

### 4. ViewModel Layer
**File**: `lib/features/account/viewmodel/profile_viewmodel.dart` (Updated)
- Dedicated ViewModel for profile operations
- Loading state management
- Error handling with user-friendly messages
- Implemented `fetchProfile()` for getting profile data
- Implemented `updateProfile()` for updating profile data

**File**: `lib/features/account/viewmodel/account_viewmodel.dart` (Updated)
- Added phone field support
- Updated to use real API through repository
- Enhanced error handling
- Updated `saveChanges()` to use real update API

### 5. Example Usage
**File**: `lib/features/account/view/profile_api_example.dart`
- Demonstrates both ProfileViewModel and AccountViewModel usage
- Shows loading states and error handling
- Example integration patterns

**File**: `lib/features/account/view/profile_update_example.dart` (New)
- Complete profile update form example
- Form validation and error handling
- Real-time status updates
- Profile photo URL validation

## How to Use

### Option 1: Using ProfileViewModel (Recommended for profile screens)

**Fetch Profile:**
```dart
final profileViewModel = ProfileViewModel();
await profileViewModel.fetchProfile();

// Access profile data
final profile = profileViewModel.profileModel;
print('User: ${profile.firstName}');
print('Email: ${profile.email}');
```

**Update Profile:**
```dart
final profileViewModel = ProfileViewModel();

// Create updated profile
final updatedProfile = ProfileModel(
  firstName: 'Tousif',
  email: 'bocax95317@camjoint.com',
  city: 'Dhaka',
  dateOfBirth: '2025-09-21',
  phone: '01641752424',
  profilePhoto: 'https://example.com/image.jpg',
);

// Update profile
await profileViewModel.updateProfile(updatedProfile);

// Check result
if (profileViewModel.successMessage != null) {
  print('Success: ${profileViewModel.successMessage}');
} else if (profileViewModel.errorMessage != null) {
  print('Error: ${profileViewModel.errorMessage}');
}
```

### Option 2: Using AccountViewModel (For existing account screens)

**Fetch Account:**
```dart
final accountViewModel = AccountViewModel();
await accountViewModel.fetchAccountInformation();

// Access account data (converted from profile)
final account = accountViewModel.accountModel;
print('Name: ${account.name}');
print('Email: ${account.email}');
```

**Update Account:**
```dart
final accountViewModel = AccountViewModel();

// Update form controllers
accountViewModel.nameController.text = 'Tousif';
accountViewModel.emailController.text = 'bocax95317@camjoint.com';
accountViewModel.locationController.text = 'Dhaka';
accountViewModel.dateOfBirthController.text = '2025-09-21';
accountViewModel.phoneController.text = '01641752424';

// Enable edit mode and save
accountViewModel.toggleEditMode();
await accountViewModel.saveChanges();
```

## Authentication Requirements
- User must be logged in (JWT tokens stored)
- Access token automatically retrieved from TokenStorage
- Handles authentication expiry with proper error messages

## Error Handling
The integration handles various error scenarios:

### Get Profile Errors
1. **401 Unauthorized**: "Authentication expired. Please login again."
2. **404 Not Found**: "Profile not found."
3. **Network Errors**: "Network error. Please try again."
4. **No Token**: "User not authenticated"

### Update Profile Errors
1. **400 Bad Request**: Detailed field-specific error messages
   - Example: "profile_photo: The submitted data was not a file. Check the encoding type on the form."
2. **401 Unauthorized**: "Authentication expired. Please login again."
3. **404 Not Found**: "Profile not found."
4. **Network Errors**: "Network error. Please try again."
5. **Validation Errors**: Form validation errors for required fields and formats

### Special Handling
- **Profile Photo**: Only accepts valid URLs (http:// or https://)
- **Date Format**: Validates YYYY-MM-DD format
- **Email Format**: Validates email pattern
- **Field Errors**: Parses API response to show specific field errors

## Integration with Existing Code
The implementation maintains compatibility with existing account management features:

- Existing account screens continue to work
- Added phone field support throughout the system
- Error handling follows existing patterns
- UI components can use either ViewModel

## Testing the Integration

### Manual Testing
1. Ensure user is logged in (JWT tokens available)
2. Call `fetchProfile()` or `fetchAccountInformation()`
3. Check console logs for API requests/responses
4. Verify data appears correctly in UI

### Example Test Code
```dart
// Test profile fetching
final profileViewModel = ProfileViewModel();
await profileViewModel.fetchProfile();

if (profileViewModel.errorMessage != null) {
  print('Error: ${profileViewModel.errorMessage}');
} else {
  print('Success: ${profileViewModel.profileModel}');
}
```

## Console Output Examples

### Successful API Call
```
I/flutter: Get Profile Request URL: http://10.10.13.36/user/profile/get
I/flutter: Headers: {Content-Type: application/json, Authorization: Bearer <token>}
I/flutter: Response Status Code: 200
I/flutter: Response Body: {first_name: , email: office.simantaroy@gmail.com, city: null, ...}
I/flutter: Get Profile success
I/flutter: Profile fetch success: ProfileModel(firstName: , email: office.simantaroy@gmail.com, ...)
```

### Error Case
```
I/flutter: Response Status Code: 401
I/flutter: Get Profile failed - Unauthorized: {detail: Token expired}
I/flutter: Profile loading error: Authentication expired. Please login again.
```

## Future Enhancements
The implementation is prepared for:
- Profile update API (PUT/POST)
- Profile picture upload
- Additional profile fields
- Caching strategies

## File Structure Summary
```
lib/
├── api/
│   └── auth_api_service.dart (Updated - added getUserProfile)
├── features/account/
│   ├── model/
│   │   ├── account_model.dart (Updated - added phone, fromProfile)
│   │   └── profile_model.dart (New)
│   ├── repository/
│   │   ├── account_repository.dart (Updated - real API)
│   │   └── profile_repository.dart (New)
│   ├── viewmodel/
│   │   ├── account_viewmodel.dart (Updated - phone support)
│   │   └── profile_viewmodel.dart (New)
│   └── view/
│       └── profile_api_example.dart (New - example usage)
└── core/
    └── token_storage.dart (Already exists - used for JWT)
```

## API Integration Complete ✅
- GET /user/profile/get endpoint integrated ✅
- PUT /user/profile/update endpoint integrated ✅
- JWT authentication implemented ✅
- Error handling for all response codes ✅
- Data models matching API structure ✅
- ViewModels for state management ✅
- Form validation and field-specific errors ✅
- Profile photo URL validation ✅
- Compatible with existing account system ✅
- Example usage provided ✅
- Comprehensive documentation ✅

### Key Features
- **Complete CRUD Operations**: Fetch and update profile data
- **Real-time Validation**: Form validation with immediate feedback
- **Error Handling**: Detailed error messages for better UX
- **JWT Security**: Secure API calls with token authentication
- **URL Validation**: Profile photo accepts only valid URLs
- **Field Mapping**: Seamless conversion between API and UI models
- **Loading States**: Visual feedback during API operations
- **Success Messages**: Confirmation of successful operations

### Profile Photo Handling
- **JSON Requests**: Use profile photo URLs (https://example.com/image.jpg)
- **File Upload**: Requires separate multipart/form-data implementation
- **Validation**: Automatic URL format validation
- **Error Handling**: Specific errors for invalid photo data

The profile API integration supports both fetching and updating user profiles with comprehensive error handling, validation, and user feedback.