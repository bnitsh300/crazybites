import 'package:crazy_bites/screens/Home/items/items_detail_screen.dart';
import 'package:crazy_bites/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> _bannerImages = [
    "${assetsimageurl}banner1.jpeg",
    "${assetsimageurl}banner2.jpeg",
    "${assetsimageurl}banner3.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: 1,
                child: Text(
                  'Hi Crazy Bites',
                  style: GoogleFonts.poppins(
                    fontSize: isTablet ? 18 : 14,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
            ),
            AnimatedSlide(
              duration: const Duration(seconds: 2),
              offset: const Offset(0.1, 0),
              curve: Curves.easeOut,
              child: Text(
                'Hungry Now ?🔥',
                style: GoogleFonts.poppins(
                  fontSize: isTablet ? 28 : 20,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                hintStyle: GoogleFonts.poppins(fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      BorderSide(color: theme.colorScheme.onBackground.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      BorderSide(color: theme.colorScheme.onBackground.withOpacity(0.3)),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: "profile_logo",
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary,
                  border: Border.all(color: theme.colorScheme.onBackground),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset('${assetsimageurl}logo.png', height: 35),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildCarouselSlider(theme),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Items',
                    style: TextStyle(
                      fontSize: isTablet ? 26 : 20,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 16,
                      fontWeight: FontWeight.w600,
                      color: theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            SizedBox(
              height: isTablet ? 420 : 320,
              child: AnimationLimiter(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(24),
                              onTap: () {
                                Get.to(() => const ItemDetailScreen());
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                width: size.width * 0.55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: Image.asset(
                                            '${assetsimageurl}pizza.jpg',
                                            height: isTablet ? 160 : 120,
                                            width: isTablet ? 160 : 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Gap(12),
                                      Text(
                                        'Sweet Corn Pizza',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: isTablet ? 20 : 16,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                      ),
                                      Text(
                                        '₹105',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: isTablet ? 18 : 14,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '🔥 44 Calories',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: isTablet ? 15 : 13,
                                              color: theme.colorScheme.onBackground
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: theme.colorScheme.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(8),
                                            child: const Icon(
                                              Icons.add_shopping_cart,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(8),
                                      Row(
                                        children: [
                                          Icon(Icons.timer,
                                              size: 16,
                                              color: theme.hintColor),
                                          const Gap(4),
                                          Text(
                                            '20 min',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: isTablet ? 14 : 12,
                                              color: theme.hintColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: isTablet ? 26 : 20,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: isTablet ? 300 : 220,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child:
                        const InlineChewiePlayer(assetPath: "assets/videos/output.mp4"),
                  ),
                ),
              ),
            ),
            Gap(100)
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSlider(ThemeData theme) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _bannerImages.length,
          itemBuilder: (context, index, realIndex) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(_bannerImages[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _bannerImages.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentIndex == entry.key ? 12 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key
                    ? theme.colorScheme.primary
                    : theme.hintColor,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class InlineChewiePlayer extends StatefulWidget {
  final String assetPath;
  const InlineChewiePlayer({super.key, required this.assetPath});

  @override
  State<InlineChewiePlayer> createState() => _InlineChewiePlayerState();
}

class _InlineChewiePlayerState extends State<InlineChewiePlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoController,
            autoPlay: false,
            looping: true,
            aspectRatio: _videoController.value.aspectRatio,
            showControls: true,
          );
        });
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Chewie(controller: _chewieController!),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
