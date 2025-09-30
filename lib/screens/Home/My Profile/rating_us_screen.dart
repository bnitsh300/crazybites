import 'package:crazy_bites/screens/widgets/custom_button.dart';
import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double rating = 0.0;
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rate Us"),
        centerTitle: true,
        backgroundColor: appcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Heading
            Text(
              "Enjoying Crazy Bites? 🍕🥟",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),
            Text(
              "Tap the stars below to rate your experience",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Star Rating
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 45,
              itemPadding: const EdgeInsets.symmetric(horizontal: 6),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),

            const SizedBox(height: 30),

            // Feedback TextField
            TextField(
              controller: feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your feedback here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Spacer(),

            // Submit Button
            CustomShimmerButton(text: 'Submit',   onPressed: () {
                  if (rating == 0.0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please select a star rating")),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Thanks for rating us ⭐ $rating\nFeedback: ${feedbackController.text}"),
                    ),
                  );
                },),
           
          ],
        ),
      ),
    );
  }
}
