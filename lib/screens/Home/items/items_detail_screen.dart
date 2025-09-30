import 'package:crazy_bites/screens/Home/Cart/cart_screen.dart';
import 'package:crazy_bites/screens/widgets/custom_button.dart';
import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int selectedSize = 1;
  int quantity = 1;

  final List<Map<String, dynamic>> pizzaSizes = [
    {"label": "Small 8\"", "price": 99.00},
    {"label": "Medium 12\"", "price": 199.00},
    {"label": "Large 18\"", "price": 299.00},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    double totalPrice = pizzaSizes[selectedSize]["price"] * quantity;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/pizza.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              "Melting Cheese Pizza",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "🍕 Pizza Italiano",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, size: 18, color: theme.iconTheme.color),
                const SizedBox(width: 4),
                Text("15 min", style: theme.textTheme.bodyMedium),
                const SizedBox(width: 16),
                const Icon(Icons.star, size: 18, color: Colors.amber),
                const SizedBox(width: 4),
                Text("4.8 (2.2k review)", style: theme.textTheme.bodyMedium),
              ],
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(pizzaSizes.length, (index) {
                  bool isSelected = selectedSize == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = index;
                      });
                    },
                    child: Container(
                      width: 90,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? appcolor.withOpacity(0.1)
                                : theme.cardColor,
                        border: Border.all(
                          color:
                              isSelected
                                  ? appcolor
                                  : theme.dividerColor.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected ? appcolor : theme.disabledColor,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            pizzaSizes[index]["label"],
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "₹${pizzaSizes[index]["price"]}",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Melting cheese pizza making with Extra virgin olive oil, Cornmeal, beef/chicken, Tomato sauce (smooth or pureed), Firm mozza, 100 gm onion, 70 gm chopped capsicum...More",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
              ),
            ),

            const Spacer(),

            // Total + Quantity + Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDark
                            ? Colors.black.withOpacity(0.6)
                            : Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Total + Quantity Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: ₹${totalPrice.toStringAsFixed(2)}",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: theme.iconTheme.color,
                            ),
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                          ),
                          Text(
                            "$quantity",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: theme.iconTheme.color,
                            ),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  CustomShimmerButton(
                    text: 'Next',
                    onPressed: () => Get.to(() => const CartScreen()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
