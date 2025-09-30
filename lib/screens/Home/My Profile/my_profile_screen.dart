import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';



class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isEditing = false;

  final TextEditingController nameController =
      TextEditingController(text: "John Doe");
  final TextEditingController bioController =
      TextEditingController(text: "Flutter Developer");
  final TextEditingController addressController =
      TextEditingController(text: "123, Street, City");
  final TextEditingController emailController =
      TextEditingController(text: "john.doe@email.com");
  final TextEditingController phoneController =
      TextEditingController(text: "+91 9876543210");
  final TextEditingController dobController =
      TextEditingController(text: "01/01/1995");

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appcolor,
        elevation: 0,
        title: const Text("My Profile", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.check_circle : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile picture section
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: appcolor,
                    radius: 60,
                    backgroundImage: const AssetImage("assets/images/logo.png"),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor:appcolor,
                      radius: 18,
                      child: const Icon(Icons.camera_alt,
                          size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Card container for info
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTextField("Full Name", nameController, isEditing),
                    _buildTextField("Bio", bioController, isEditing),
                    _buildTextField("Address", addressController, isEditing),
                    _buildTextField("Email", emailController, isEditing),
                    _buildTextField("Phone", phoneController, isEditing),
                    _buildTextField("Date of Birth", dobController, isEditing),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool enabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        enabled: enabled,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelStyle: const TextStyle(
            color: appcolor,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: appcolor, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: appcolor, width: 1.8),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          prefixIcon: Icon(
            _getIconForLabel(label),
            color: appcolor,
          ),
        ),
      ),
    );
  }

  IconData _getIconForLabel(String label) {
    switch (label) {
      case "Full Name":
        return Icons.person;
      case "Bio":
        return Icons.info_outline;
      case "Address":
        return Icons.home;
      case "Email":
        return Icons.email;
      case "Phone":
        return Icons.phone;
      case "Date of Birth":
        return Icons.calendar_today;
      default:
        return Icons.text_fields;
    }
  }
}
