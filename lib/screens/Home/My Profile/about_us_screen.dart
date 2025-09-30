import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
        backgroundColor: appcolor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: appcolor.withOpacity(0.1),
                child: Text(
                  "🍕", // You can replace with app logo image
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // App Name
            Center(
              child: Text(
                "Crazy Bites",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: appcolor,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // About Description
            Text(
              "Welcome to Crazy Bites! 🎉",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "At Crazy Bites, we serve delicious and freshly prepared food "
              "that satisfies your cravings anytime! From cheesy pizzas 🍕 to "
              "crispy momos 🥟, spring rolls 🌯, and much more, our menu is "
              "packed with flavors you’ll love.",
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            // Mission Section
            Text(
              "🍴 Our Mission",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We believe food is more than just a meal – it’s an experience. "
              "Our mission is to bring joy to your taste buds with every bite "
              "and make food ordering simple, fun, and satisfying.",
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),

            const SizedBox(height: 20),

            // Contact Info
            Text(
              "📞 Contact Us",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Email: support@crazybites.com\n"
              "Phone: +91 98765 43210\n"
              "Address: Crazy Bites, Blardu Chownk, Chambapatan Jwalamukhi Road Himachal Pradesh",
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),

            const SizedBox(height: 30),

            // Footer
            Center(
              child: Text(
                "Made with ❤️ by Crazy Bites",
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
}
