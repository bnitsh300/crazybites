import 'package:crazy_bites/screens/Home/My%20Profile/rating_us_screen.dart';
import 'package:crazy_bites/screens/Home/My%20Profile/web_soket.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'about_us_screen.dart';
import 'coupon_screen.dart';
import 'my_profile_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_and_conditions_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("My Account"),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onBackground,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Top Profile Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Profile Image
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/pizza.jpg"),
                ),
                const SizedBox(width: 16),

                // Name & Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Doe",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "johndoe@gmail.com",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Menu Items
          Expanded(
            child: ListView(
              children: [
                _buildProfileTile(
                  context,
                  icon: Icons.person,
                  title: "My Profile",
                  onTap: () {
                    Get.to(()=>MyProfileScreen());
                  },
                ),
                _buildProfileTile(
                  context,
                  icon: Icons.local_offer,
                  title: "Coupons",
                  onTap: () {
                    Get.to(()=>CouponScreen());
                  },
                ),
                _buildProfileTile(
                  context,
                  icon: Icons.info_outline,
                  title: "About Us",
                  onTap: () {
                    Get.to(()=>AboutUsScreen());
                  },
                ),
                _buildProfileTile(
                  context,
                  icon: Icons.star_rate,
                  title: "Ratings",
                  onTap: () {
                     Get.to(()=>RatingScreen());
                  },
                ),
                _buildProfileTile(
                  context,
                  icon: Icons.description,
                  title: "Terms & Conditions",
                  onTap: () {
                    Get.to(()=>TermsAndConditionsScreen());
                  },
                ),
                _buildProfileTile(
                  context,
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  onTap: () {
                    Get.to(()=>PrivacyPolicyScreen());
                  },
                ),
                 _buildProfileTile(
                  context,
                  icon: Icons.privacy_tip,
                  title: "Chats",
                  onTap: () {
                    Get.to(()=>SocketIoExample());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surface,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: theme.hintColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
