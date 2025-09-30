import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        centerTitle: true,
        backgroundColor: appcolor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Crazy Bites!",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "By using our app, you agree to the following Terms & Conditions. "
              "Please read them carefully before placing an order.",
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            _buildPoint(
              theme,
              "1. Orders & Delivery",
              "Orders once placed cannot be canceled. Delivery times may vary depending on location and availability.",
            ),
            _buildPoint(
              theme,
              "2. Payments",
              "All payments must be made online or cash on delivery where applicable. Crazy Bites is not responsible for payment failures from third-party gateways.",
            ),
            _buildPoint(
              theme,
              "3. Refunds",
              "Refunds are only applicable in case of non-delivery or wrong order delivery, subject to management approval.",
            ),
            _buildPoint(
              theme,
              "4. Usage",
              "The app must not be used for fraudulent purposes, including misuse of coupons, offers, or false orders.",
            ),
            _buildPoint(
              theme,
              "5. Changes",
              "Crazy Bites reserves the right to modify these Terms & Conditions at any time without prior notice.",
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
