import 'package:crazy_bites/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  // Dummy Orders List
  final List<Map<String, dynamic>> orders = [
    {
      "id": "1001",
      "item": "Cheese Pizza",
      "date": "18 Aug 2025",
      "status": "Accepted",
      "price": "₹299",
      "image": "assets/images/pizza.jpg", // pizza img
    },
    {
      "id": "1002",
      "item": "Veg Momos",
      "date": "15 Aug 2025",
      "status": "Rejected",
      "price": "₹149",
      "image": "assets/images/momos.jpg", // momos img
    },
    {
      "id": "1003",
      "item": "Spring Roll",
      "date": "12 Aug 2025",
      "status": "Completed",
      "price": "₹199",
      "image": "assets/images/springroll.jpg", // roll img
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Accepted":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      case "Completed":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
            
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      // Order Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.asset(
                          order["image"],
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
            
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Order name + Price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order["item"],
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  order["price"],
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
            
                            const SizedBox(height: 6),
            
                            // Order ID + Date
                            Text(
                              "Order ID: ${order["id"]} • ${order["date"]}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
            
                            const SizedBox(height: 12),
            
                            // Status Badge
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(order["status"]).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                order["status"],
                                style: TextStyle(
                                  color: _getStatusColor(order["status"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
            
                            const SizedBox(height: 14),
            
                            // Action Buttons
                            if (order["status"] == "Completed")
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomShimmerButton(text: 'Reorder',  onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Reordered ${order["item"]} successfully")),
                                        );
                                      },)
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        side: BorderSide(
                                          color: theme.colorScheme.primary,
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text("Rate your order: ${order["item"]}")),
                                        );
                                        // Navigate to Rating Screen
                                      },
                                      icon: Icon(Icons.star,
                                          size: 18, color: theme.colorScheme.primary),
                                      label: Text(
                                        "Rate",
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                );
              },
              
            ),
          ),
          Gap(100)
        ],
      ),
    );
  }
}
