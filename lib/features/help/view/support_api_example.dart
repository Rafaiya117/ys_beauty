import 'package:flutter/material.dart';
import '../viewmodel/help_support_viewmodel.dart';

/// Example widget showing how to use the Support API integration
/// This demonstrates the complete support request submission flow
class SupportApiExample extends StatefulWidget {
  const SupportApiExample({Key? key}) : super(key: key);

  @override
  State<SupportApiExample> createState() => _SupportApiExampleState();
}

class _SupportApiExampleState extends State<SupportApiExample> {
  late HelpSupportViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HelpSupportViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support API Integration Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _viewModel.clearError();
              _viewModel.clearSuccess();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // API Integration Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Support API Integration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('✅ POST /user/support/create'),
                    const Text('✅ Email and description validation'),
                    const Text('✅ Real-time error handling'),
                    const Text('✅ Success response with request ID'),
                    const SizedBox(height: 8),
                    const Text(
                      'API Request Format:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '{"email": "user@example.com", "description": "Issue description"}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Support Request Form
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
                          labelText: 'Email *',
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
                            labelText: 'Request Description *',
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
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 16),
                                Text('Submitting your request...'),
                              ],
                            ),
                          ),
                        ),

                      if (_viewModel.errorMessage != null)
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
                                    _viewModel.errorMessage!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => _viewModel.clearError(),
                                  child: const Text('Dismiss'),
                                ),
                              ],
                            ),
                          ),
                        ),

                      if (_viewModel.successMessage != null)
                        Card(
                          color: Colors.green.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _viewModel.successMessage!,
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),

                      // Submit Button
                      ElevatedButton(
                        onPressed: _viewModel.isLoading
                            ? null
                            : () => _viewModel.submitRequest(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _viewModel.isLoading
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
                                  Text('Submitting...'),
                                ],
                              )
                            : const Text('Submit Support Request'),
                      ),

                      const SizedBox(height: 16),

                      // Test Data Button
                      OutlinedButton(
                        onPressed: () {
                          _viewModel.emailController.text = 'test@example.com';
                          _viewModel.requestDetailsController.text =
                              'This is a test support request to verify the API integration is working correctly.';
                        },
                        child: const Text('Fill Test Data'),
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
