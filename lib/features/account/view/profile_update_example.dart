import 'package:flutter/material.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../model/profile_model.dart';

/// Example widget showing how to use the Update Profile API integration
/// This demonstrates the complete profile update flow with form validation
class ProfileUpdateExample extends StatefulWidget {
  const ProfileUpdateExample({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateExample> createState() => _ProfileUpdateExampleState();
}

class _ProfileUpdateExampleState extends State<ProfileUpdateExample> {
  late ProfileViewModel _profileViewModel;
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _profilePhotoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileViewModel = ProfileViewModel();
    _loadCurrentProfile();
  }

  Future<void> _loadCurrentProfile() async {
    await _profileViewModel.fetchProfile();
    if (_profileViewModel.errorMessage == null) {
      _populateForm();
    }
  }

  void _populateForm() {
    final profile = _profileViewModel.profileModel;
    _firstNameController.text = profile.firstName;
    _emailController.text = profile.email;
    _cityController.text = profile.city ?? '';
    _dateOfBirthController.text = profile.dateOfBirth ?? '';
    _phoneController.text = profile.phone ?? '';
    _profilePhotoController.text = profile.profilePhoto ?? '';
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final updatedProfile = ProfileModel(
        firstName: _firstNameController.text.trim(),
        email: _emailController.text.trim(),
        city: _cityController.text.trim().isEmpty
            ? null
            : _cityController.text.trim(),
        dateOfBirth: _dateOfBirthController.text.trim().isEmpty
            ? null
            : _dateOfBirthController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        profilePhoto: _profilePhotoController.text.trim().isEmpty
            ? null
            : _profilePhotoController.text.trim(),
      );

      await _profileViewModel.updateProfile(updatedProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCurrentProfile,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _profileViewModel,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Status Messages
                if (_profileViewModel.isLoading)
                  const LinearProgressIndicator(),

                if (_profileViewModel.errorMessage != null)
                  Card(
                    color: Colors.red.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _profileViewModel.errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _profileViewModel.clearError(),
                            child: const Text('Dismiss'),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (_profileViewModel.successMessage != null)
                  Card(
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _profileViewModel.successMessage!,
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Profile Update Form
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // First Name
                          TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name *',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'First name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Email
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email *',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // City
                          TextFormField(
                            controller: _cityController,
                            decoration: const InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Date of Birth
                          TextFormField(
                            controller: _dateOfBirthController,
                            decoration: const InputDecoration(
                              labelText: 'Date of Birth (YYYY-MM-DD)',
                              border: OutlineInputBorder(),
                              hintText: '2025-09-21',
                            ),
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (!RegExp(
                                  r'^\d{4}-\d{2}-\d{2}$',
                                ).hasMatch(value)) {
                                  return 'Use format: YYYY-MM-DD';
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Phone
                          TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Profile Photo URL
                          TextFormField(
                            controller: _profilePhotoController,
                            decoration: const InputDecoration(
                              labelText: 'Profile Photo URL (optional)',
                              border: OutlineInputBorder(),
                              hintText: 'https://example.com/image.jpg',
                            ),
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (!value.startsWith('http://') &&
                                    !value.startsWith('https://')) {
                                  return 'Profile photo must be a valid URL';
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Update Button
                          ElevatedButton(
                            onPressed: _profileViewModel.isLoading
                                ? null
                                : _updateProfile,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _profileViewModel.isLoading
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text('Updating...'),
                                    ],
                                  )
                                : const Text('Update Profile'),
                          ),

                          const SizedBox(height: 16),

                          // API Information
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'API Integration Details',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text('✅ PUT /user/profile/update'),
                                  const Text('✅ JWT Authentication'),
                                  const Text('✅ Field validation'),
                                  const Text(
                                    '✅ Error handling for profile_photo',
                                  ),
                                  const Text('✅ Success/Error messages'),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Note: profile_photo accepts URLs only. File upload requires multipart/form-data which is handled separately.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _dateOfBirthController.dispose();
    _phoneController.dispose();
    _profilePhotoController.dispose();
    _profileViewModel.dispose();
    super.dispose();
  }
}
