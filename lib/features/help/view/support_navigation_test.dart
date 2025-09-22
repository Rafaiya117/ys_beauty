import 'package:flutter/material.dart';
import '../viewmodel/help_support_viewmodel.dart';

/// Test widget to verify the navigation from Help & Support to Settings
/// This demonstrates the complete flow with automatic navigation back
class SupportNavigationTest extends StatefulWidget {
  const SupportNavigationTest({Key? key}) : super(key: key);

  @override
  State<SupportNavigationTest> createState() => _SupportNavigationTestState();
}

class _SupportNavigationTestState extends State<SupportNavigationTest> {
  late HelpSupportViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HelpSupportViewModel();
  }

  Future<void> _testSuccessfulSubmission() async {
    // Fill form with test data
    _viewModel.emailController.text = 'test@example.com';
    _viewModel.requestDetailsController.text =
        'This is a test support request to verify navigation works correctly.';

    // Submit request (this should navigate back to Settings after success)
    await _viewModel.submitRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support Navigation Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Navigation Flow Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Navigation Flow Test',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('✅ Help & Support → Settings (on success)'),
                    const Text('✅ Automatic navigation after 1 second delay'),
                    const Text('✅ Similar to Edit Information → Account flow'),
                    const SizedBox(height: 8),
                    const Text(
                      'Expected Flow:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text('1. Fill form with valid data'),
                    const Text('2. Submit support request'),
                    const Text('3. Show success message'),
                    const Text('4. Clear form'),
                    const Text('5. Navigate back to Settings after 1s'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Form Section
            Expanded(
              child: AnimatedBuilder(
                animation: _viewModel,
                builder: (context, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email Field
                      TextField(
                        controller: _viewModel.emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Description Field
                      Expanded(
                        child: TextField(
                          controller: _viewModel.requestDetailsController,
                          decoration: const InputDecoration(
                            labelText: 'Support Request Description',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                            alignLabelWithHint: true,
                          ),
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Status Messages
                      if (_viewModel.isLoading)
                        const Card(
                          color: Colors.blue,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CircularProgressIndicator(color: Colors.white),
                                SizedBox(width: 16),
                                Text(
                                  'Submitting request...',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),

                      if (_viewModel.errorMessage != null)
                        Card(
                          color: Colors.red.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Error: ${_viewModel.errorMessage}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),

                      if (_viewModel.successMessage != null)
                        Card(
                          color: Colors.green.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Success: ${_viewModel.successMessage}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '🔄 Navigating back to Settings...',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _viewModel.isLoading
                                  ? null
                                  : () => _viewModel.submitRequest(),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              child: const Text('Submit Support Request'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _testSuccessfulSubmission,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              child: const Text('Test Navigation'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
