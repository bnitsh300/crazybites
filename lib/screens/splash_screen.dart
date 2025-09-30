import 'dart:async';
import 'package:crazy_bites/screens/onboarding/onboarding_screens.dart';
import 'package:crazy_bites/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // Scale animation (logo grows slightly)
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    // Fade animation (logo appears smoothly)
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Start animation
    _controller.forward();

    // Navigate after delay
    Timer(const Duration(seconds: 3), () {
      Get.off(() => OnboardingScreen(),
          transition: Transition.fadeIn, duration: const Duration(milliseconds: 600));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Modern gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                '${assetsimageurl}logo.png',
                width: 250,
                height: 250,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
