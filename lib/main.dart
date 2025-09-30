import 'package:crazy_bites/screens/splash_screen.dart';
import 'package:crazy_bites/utils/colors.dart';
import 'package:crazy_bites/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: whitecolor,
        textTheme: GoogleFonts.poppinsTextTheme(), 
        colorScheme: ColorScheme.fromSeed(
          seedColor: whitecolor,
          primary: appcolor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.poppinsTextTheme( 
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: appcolor,
          brightness: Brightness.dark,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
