import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        centerTitle: true,
        backgroundColor: appcolor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "At Crazy Bites, we respect your privacy and are committed to "
              "protecting your personal information. This policy explains how we "
              "collect, use, and safeguard your data.",
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            _buildPoint(
              theme,
              "1. Information We Collect",
              "We may collect your name, phone number, email address, delivery address, and payment details when you place an order.",
            ),
            _buildPoint(
              theme,
              "2. How We Use Your Data",
              "Your data is used only for order processing, delivery, customer support, and providing a personalized experience.",
            ),
            _buildPoint(
              theme,
              "3. Data Security",
              "We use secure systems to protect your personal information, but we cannot guarantee 100% protection against cyber threats.",
            ),
            _buildPoint(
              theme,
              "4. Third-Party Sharing",
              "We do not sell your personal data. Limited information may be shared with delivery partners or payment gateways for completing your orders.",
            ),
            _buildPoint(
              theme,
              "5. Updates",
              "This Privacy Policy may be updated from time to time. Continued use of the app means you agree to the updated policy.",
            ),

            const SizedBox(height: 30),
            Center(
              child: Text(
                "© 2025 Crazy Bites. All Rights Reserved.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoint(ThemeData theme, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
