import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static String routeName = "/PrivacyPolicyPage";

  const PrivacyPolicyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Introduction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'This Privacy Policy explains how we collect, use, and protect your personal information when you use our eCommerce app. By using the app, you agree to the terms of this policy.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Information We Collect',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We may collect the following information from you:\n'
                    '• Personal identification information (Name, email address, phone number, etc.)\n'
                    '• Payment information (Credit card details, billing address)\n'
                    '• Usage data (How you use the app, features used, etc.)',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'How We Use Your Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We use your personal information to:\n'
                    '• Process transactions and manage your account\n'
                    '• Improve the app experience based on usage data\n'
                    '• Send notifications and updates about your orders or app features\n'
                    '• Ensure the security of your information and transactions',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Data Protection',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We implement appropriate security measures to protect your personal data from unauthorized access, alteration, or disclosure. However, please note that no data transmission over the internet can be guaranteed to be 100% secure.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Changes to This Policy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We may update this Privacy Policy from time to time. Any changes will be posted on this page, and your continued use of the app signifies your acceptance of these changes.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'If you have any questions about this Privacy Policy, please contact us at support@thuanht.com.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
