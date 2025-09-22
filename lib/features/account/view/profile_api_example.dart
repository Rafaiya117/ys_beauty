import 'package:flutter/material.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../viewmodel/account_viewmodel.dart';

/// Example widget showing how to use the Profile API integration
/// This can be integrated into your existing account or profile screens
class ProfileApiExample extends StatefulWidget {
  const ProfileApiExample({Key? key}) : super(key: key);

  @override
  State<ProfileApiExample> createState() => _ProfileApiExampleState();
}

class _ProfileApiExampleState extends State<ProfileApiExample> {
  late ProfileViewModel _profileViewModel;
  late AccountViewModel _accountViewModel;

  @override
  void initState() {
    super.initState();
    _profileViewModel = ProfileViewModel();
    _accountViewModel = AccountViewModel();

    // Automatically fetch profile when widget loads
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    // You can use either ProfileViewModel or AccountViewModel
    // ProfileViewModel is more focused on profile data
    // AccountViewModel integrates with existing account screens

    await _profileViewModel.fetchProfile();
    await _accountViewModel.fetchAccountInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile API Integration Example'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadProfile),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile ViewModel Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile ViewModel (Direct API)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedBuilder(
                      animation: _profileViewModel,
                      builder: (context, child) {
                        if (_profileViewModel.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (_profileViewModel.errorMessage != null) {
                          return Column(
                            children: [
                              Text(
                                'Error: ${_profileViewModel.errorMessage}',
                                style: const TextStyle(color: Colors.red),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    _profileViewModel.fetchProfile(),
                                child: const Text('Retry'),
                              ),
                            ],
                          );
                        }

                        final profile = _profileViewModel.profileModel;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('First Name: ${profile.firstName}'),
                            Text('Email: ${profile.email}'),
                            Text('City: ${profile.city ?? 'Not set'}'),
                            Text(
                              'Date of Birth: ${profile.dateOfBirth ?? 'Not set'}',
                            ),
                            Text('Phone: ${profile.phone ?? 'Not set'}'),
                            Text(
                              'Profile Photo: ${profile.profilePhoto ?? 'Not set'}',
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Account ViewModel Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account ViewModel (Existing Integration)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedBuilder(
                      animation: _accountViewModel,
                      builder: (context, child) {
                        if (_accountViewModel.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (_accountViewModel.errorMessage != null) {
                          return Column(
                            children: [
                              Text(
                                'Error: ${_accountViewModel.errorMessage}',
                                style: const TextStyle(color: Colors.red),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    _accountViewModel.fetchAccountInformation(),
                                child: const Text('Retry'),
                              ),
                            ],
                          );
                        }

                        final account = _accountViewModel.accountModel;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${account.name}'),
                            Text('Email: ${account.email}'),
                            Text('Location: ${account.location}'),
                            Text('Date of Birth: ${account.dateOfBirth}'),
                            Text('Phone: ${account.phone ?? 'Not set'}'),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // API Usage Instructions
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'API Integration Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('✅ GET /user/profile/get - Implemented'),
                    Text('✅ JWT Authentication with Bearer token'),
                    Text('✅ Error handling for 401, 404 responses'),
                    Text('✅ Profile model matching API response structure'),
                    Text('✅ Integration with existing account system'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _profileViewModel.dispose();
    _accountViewModel.dispose();
    super.dispose();
  }
}
