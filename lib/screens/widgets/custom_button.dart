import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomShimmerButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final List<Color> shimmerColors;

  const CustomShimmerButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.borderRadius = 12,
    this.shimmerColors = const [Color(0xFFFFA726), Color(0xFFFF7043)],
  }) : super(key: key);

  @override
  State<CustomShimmerButton> createState() => _CustomShimmerButtonState();
}

class _CustomShimmerButtonState extends State<CustomShimmerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // continuous forward loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            // Offset moves from -1 to 2 so it wraps around smoothly
            double offset = _controller.value * 3 - 1;

            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gradient: LinearGradient(
                      colors: widget.shimmerColors,
                      begin: Alignment(offset, offset), // diagonal movement
                      end: Alignment(offset - 2, offset - 2),
                    ),
                  ),
                ),
                Text(
                  widget.text,
                 style: GoogleFonts.poppins(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.bold,
                    color: widget.textColor,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
