import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper/pages/home_page.dart';
import 'package:wallpaper/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.openSans().fontFamily,
          brightness: Brightness.dark),
      home: const CheckAuthStatus(),
    );
  }
}

class CheckAuthStatus extends StatefulWidget {
  const CheckAuthStatus({super.key});

  @override
  State<CheckAuthStatus> createState() => _CheckAuthStatusState();
}

class _CheckAuthStatusState extends State<CheckAuthStatus> {
  bool isLoggedIn = false;

  // method to check the user login status
  void checkLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");

    setState(() {
      isLoggedIn = token != null;
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }



  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const HomePage() : LoginPage();
  }
}
