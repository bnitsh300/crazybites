import 'package:crazy_bites/screens/widgets/custom_button.dart';
import 'package:crazy_bites/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedCountryCode = "+1";
  bool _isObscure = true;
  bool _isConfirmObscure = true;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        final theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(primary: appcolor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat("dd MMM yyyy").format(picked);
      });
    }
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );
    }
  }

  InputDecoration _inputDecoration({
    required String label,
    IconData? icon,
    Widget? suffixIcon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, color: colorScheme.primary) : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: theme.inputDecorationTheme.fillColor ??
          colorScheme.surfaceVariant.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Gradient Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [appcolor, appcolor.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create Your Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Join us and enjoy your experience",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Form Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: _inputDecoration(
                          label: "Full Name",
                          icon: Icons.person,
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter your name" : null,
                      ),
                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _dobController,
                        readOnly: true,
                        onTap: _pickDate,
                        decoration: _inputDecoration(
                          label: "Date of Birth",
                          icon: Icons.calendar_today,
                        ),
                        validator: (value) => value!.isEmpty
                            ? "Please select your date of birth"
                            : null,
                      ),
                      const SizedBox(height: 14),

                      // Phone Field
                      Row(
                        children: [
                          Container(
                            height: 55,
                            padding: const EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                              color: theme.inputDecorationTheme.fillColor ??
                                  colorScheme.surfaceVariant.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: CountryCodePicker(
                              onChanged: (code) {
                                setState(() {
                                  _selectedCountryCode = code.dialCode ?? "+1";
                                });
                              },
                              initialSelection: 'IN',
                              favorite: const ['+1', 'US', '+91', 'IN'],
                              showCountryOnly: false,
                              alignLeft: false,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: _inputDecoration(
                                label: "Phone Number",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your phone number";
                                }
                                if (!RegExp(r'^[0-9]{6,15}$')
                                    .hasMatch(value)) {
                                  return "Please enter a valid phone number";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _emailController,
                        decoration: _inputDecoration(
                          label: "Email",
                          icon: Icons.email,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter your email";
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscure,
                        decoration: _inputDecoration(
                          label: "Password",
                          icon: Icons.lock,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () =>
                                setState(() => _isObscure = !_isObscure),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _isConfirmObscure,
                        decoration: _inputDecoration(
                          label: "Confirm Password",
                          icon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => setState(
                                () => _isConfirmObscure = !_isConfirmObscure),
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomShimmerButton(
                          text: "Sign Up",
                          onPressed: _signUp,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appcolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
