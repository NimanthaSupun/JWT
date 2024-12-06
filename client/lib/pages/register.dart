import 'package:flutter/material.dart';
import 'package:wallpaper/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "WallFit",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Make each time a real pleasure with unique wallpapers from QHD Wallpapers collections. Let your device become a source of self-expression, joy, inspiration and more...  ",
                      style: TextStyle(fontSize: 15),
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
