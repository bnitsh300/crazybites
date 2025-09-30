import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';

class CouponScreen extends StatelessWidget {
  // Dummy coupon list
  final List<Map<String, String>> coupons = [
    {
      "title": "Flat 20% OFF",
      "code": "SAVE20",
      "description": "Get 20% off on your first order",
      "expiry": "Expires on: 30 Aug 2025"
    },
    {
      "title": "₹100 Cashback",
      "code": "CASH100",
      "description": "Get ₹100 cashback on orders above ₹500",
      "expiry": "Expires on: 10 Sep 2025"
    },
    {
      "title": "Free Delivery",
      "code": "FREESHIP",
      "description": "Enjoy free delivery on all orders",
      "expiry": "Expires on: 25 Aug 2025"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("My Coupons"),
        centerTitle: true,
        backgroundColor: appcolor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          final coupon = coupons[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            color: theme.cardColor, // adapts to dark/light mode
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coupon Title
                  Text(
                    coupon["title"]!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    coupon["description"]!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Coupon Code + Copy button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: appcolor),
                          borderRadius: BorderRadius.circular(8),
                          color: appcolor.withOpacity(0.1),
                        ),
                        child: Text(
                          coupon["code"]!,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: appcolor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Copied ${coupon["code"]}")),
                          );
                        },
                        child: Text(
                          "Copy",
                          style: TextStyle(color: appcolor),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Expiry Date
                  Text(
                    coupon["expiry"]!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
