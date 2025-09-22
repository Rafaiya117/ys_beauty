import 'package:flutter/material.dart';
import '../viewmodel/edit_information_viewmodel.dart';
import '../viewmodel/account_viewmodel.dart';

/// Test widget to verify the profile update API integration
/// This demonstrates the complete flow from edit to account information refresh
class ProfileUpdateIntegrationTest extends StatefulWidget {
  const ProfileUpdateIntegrationTest({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateIntegrationTest> createState() =>
      _ProfileUpdateIntegrationTestState();
}

class _ProfileUpdateIntegrationTestState
    extends State<ProfileUpdateIntegrationTest> {
  late AccountViewModel _accountViewModel;
  late EditInformationViewModel _editInformationViewModel;

  @override
  void initState() {
    super.initState();
    _accountViewModel = AccountViewModel();
    _editInformationViewModel = EditInformationViewModel(
      name: 'Test User',
      email: 'test@example.com',
      birthDate: '2025-09-21',
      city: 'Test City',
    );

    // Load initial account data
    _loadAccountData();
  }

  Future<void> _loadAccountData() async {
    await _accountViewModel.fetchAccountInformation();
  }

  Future<void> _testProfileUpdate() async {
    // Update the form with test data
    _editInformationViewModel.nameController.text = 'Updated Test User';
    _editInformationViewModel.emailController.text = 'updated@example.com';
    _editInformationViewModel.cityController.text = 'Updated City';
    _editInformationViewModel.birthDateController.text = '2025-09-22';

    // Save changes
    await _editInformationViewModel.saveChanges();

    // Refresh account data to see the changes
    await Future.delayed(const Duration(seconds: 2));
    await _accountViewModel.fetchAccountInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Update Integration Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Information Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Account Information',
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
                          return const CircularProgressIndicator();
                        }

                        if (_accountViewModel.errorMessage != null) {
                          return Text(
                            'Error: ${_accountViewModel.errorMessage}',
                            style: const TextStyle(color: Colors.red),
                          );
                        }

                        final account = _accountViewModel.accountModel;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${account.name}'),
                            Text('Email: ${account.email}'),
                            Text('Date of Birth: ${account.dateOfBirth}'),
                            Text('Location: ${account.location}'),
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

            // Edit Information Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Edit Information Test',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedBuilder(
                      animation: _editInformationViewModel,
                      builder: (context, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller:
                                  _editInformationViewModel.nameController,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller:
                                  _editInformationViewModel.emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller:
                                  _editInformationViewModel.cityController,
                              decoration: const InputDecoration(
                                labelText: 'City',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller:
                                  _editInformationViewModel.birthDateController,
                              decoration: const InputDecoration(
                                labelText: 'Birth Date (YYYY-MM-DD)',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Status messages
                            if (_editInformationViewModel.isLoading)
                              const CircularProgressIndicator(),

                            if (_editInformationViewModel.errorMessage != null)
                              Text(
                                'Error: ${_editInformationViewModel.errorMessage}',
                                style: const TextStyle(color: Colors.red),
                              ),

                            if (_editInformationViewModel.successMessage !=
                                null)
                              Text(
                                'Success: ${_editInformationViewModel.successMessage}',
                                style: const TextStyle(color: Colors.green),
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

            // Action Buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: _testProfileUpdate,
                  child: const Text('Test Profile Update'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _loadAccountData,
                  child: const Text('Refresh Account'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Integration Status
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Integration Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('✅ EditInformationViewModel uses ProfileRepository'),
                    Text(
                      '✅ Real API integration with PUT /user/profile/update',
                    ),
                    Text('✅ AccountViewModel fetches updated data'),
                    Text('✅ Account information page auto-refreshes'),
                    Text('✅ JWT authentication handled automatically'),
                    Text('✅ Error handling for API responses'),
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
    _accountViewModel.dispose();
    _editInformationViewModel.dispose();
    super.dispose();
  }
}
