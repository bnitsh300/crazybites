import 'package:crazy_bites/screens/Auth/login_screen.dart';
import 'package:crazy_bites/screens/widgets/custom_button.dart';
import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shimmer/shimmer.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/mykitchen.jpg",
      "title": "Premium Quality",
      "subtitle":
          "Experience handcrafted vegetarian pizzas made with organic ingredients and authentic recipes",
    },
    {
      "image": "assets/images/momos.jpg",
      "title": "Authentic Flavors",
      "subtitle":
          "Savor our Himalayan-inspired momos, prepared with fresh vegetables and secret spices",
    },
    {
      "image": "assets/images/springroll.jpg",
      "title": "Gourmet Selection",
      "subtitle":
          "Indulge in our crispy spring rolls with chef-curated dipping sauces",
    },
    {
      "image": "assets/images/pizza.jpg",
      "title": "Exclusive Membership",
      "subtitle":
          "Join our loyalty program for special discounts and early access to new menu items",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Skip button at top right
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _controller.jumpToPage(pages.length - 1),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    "SKIP",
                   style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == pages.length - 1;
                      currentPage = index;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (_, index) {
                    bool isActive = index == currentPage;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated Image with shimmer
                        AnimatedOpacity(
                          opacity: isActive ? 1 : 0,
                          duration: const Duration(milliseconds: 700),
                          child: AnimatedScale(
                            scale: isActive ? 1 : 0.9,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeOut,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black12,
                                //     blurRadius: 15,
                                //     spreadRadius: 5,
                                //     offset: Offset(0, 10),
                                //   )
                                // ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FutureBuilder(
                                  future: Future.delayed(
                                    const Duration(milliseconds: 400),
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState !=
                                        ConnectionState.done) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[200]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: double.infinity,
                                          color: Colors.white,
                                        ),
                                      );
                                    }
                                    return Image.asset(
                                      pages[index]['image']!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Animated Title
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 50, end: isActive ? 0 : 50),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: isActive ? 1 : 0,
                              child: Transform.translate(
                                offset: Offset(0, value),
                                child: ShaderMask(
                                  shaderCallback:
                                      (bounds) => LinearGradient(
                                        colors: [
                                          appcolor[800]!,
                                          appcolor[500]!,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ).createShader(bounds),
                                  child: Text(
                                    pages[index]['title']!,
                                   style: GoogleFonts.poppins(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Animated Subtitle
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 50, end: isActive ? 0 : 50),
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: isActive ? 1 : 0,
                              child: Transform.translate(
                                offset: Offset(0, value),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Text(
                                    pages[index]['subtitle']!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      height: 1.5,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Smooth page indicator
              // Smooth page indicator
              SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.deepOrange,
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                  expansionFactor: 3,
                ),
              ),

              const SizedBox(height: 20),

              // Arrow Button for next page
              if (!isLastPage)
                GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),

              const SizedBox(height: 30),

              // Get Started button
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child:
                    isLastPage
                        ? CustomShimmerButton(
                          text: 'Get Started',
                          onPressed: () {
                            Get.to(() => const LoginScreen());
                          },
                        )
                        : const SizedBox.shrink(),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
