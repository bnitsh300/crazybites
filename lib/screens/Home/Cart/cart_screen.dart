import 'package:crazy_bites/screens/widgets/custom_button.dart';
import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {"name": "Melting Cheese Pizza", "image": "assets/images/pizza.jpg", "price": 9.99, "qty": 2},
    {"name": "Spaghetti Shrimp", "image": "assets/images/springroll.jpg", "price": 10.99, "qty": 1},
    {"name": "Momos", "image": "assets/images/momos.jpg", "price": 6.99, "qty": 2},
  ];

  final double tax = 3.99;

  double get subtotal => cartItems.fold(0, (sum, item) => sum + item["price"] * item["qty"]);
  double get totalPrice => subtotal + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemCard(
                  item: item,
                  onQtyChanged: (newQty) {
                    setState(() => item["qty"] = newQty);
                  },
                  onRemove: () {
                    setState(() => cartItems.removeAt(index));
                  },
                );
              },
            ),
          ),

          // Bottom Summary & Checkout
          _buildSummarySection(),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promo Code
          const Text("Promo Code", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: blackcolor)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your code",
                    hintStyle: TextStyle(color: blackcolor),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appcolor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                onPressed: () {},
                child: Text("Apply", style: TextStyle(color: whitecolor)),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Price Summary
          _priceRow("Price", "\$${subtotal.toStringAsFixed(2)}"),
          _priceRow("Tax", "\$${tax.toStringAsFixed(2)}"),
          const Divider(height: 24, thickness: 1),
          _priceRow("Total", "\$${totalPrice.toStringAsFixed(2)}", isBold: true),
          const SizedBox(height: 16),

          // Checkout Button
          CustomShimmerButton(
            text: 'Checkout',
            onPressed: _showOrderPlacedDialog,
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.w500,color: blackcolor)),
        Text(value,
            style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal,color: blackcolor)),
      ],
    );
  }

  void _showOrderPlacedDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "OrderPlaced",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: FadeTransition(
            opacity: anim1,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // Animated Check
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.elasticOut,
                    builder: (context, scale, child) => Transform.scale(
                      scale: scale,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: const BoxDecoration(color: appcolor, shape: BoxShape.circle),
                        child: const Icon(Icons.check, size: 40, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Order Placed Successfully 🎉",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                    "Please wait, your order will be confirmed by the admin.\nYou will be notified with a message soon.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appcolor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // close dialog
                      Navigator.pop(context); // go back to previous page
                    },
                    child: const Text("OK", style: TextStyle(color: Colors.white)),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final ValueChanged<int> onQtyChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQtyChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(item["image"], width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["name"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("\$${item["price"]}",
                    style: const TextStyle(color: appcolor, fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
          ),

          // Quantity Controls
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  if (item["qty"] > 1) onQtyChanged(item["qty"] - 1);
                },
              ),
              Text("${item["qty"]}", style: const TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => onQtyChanged(item["qty"] + 1),
              ),
            ],
          ),

          IconButton(icon: const Icon(Icons.close, color: Colors.grey), onPressed: onRemove),
        ],
      ),
    );
  }
}
