import 'package:flutter/material.dart';
import 'package:wallpaper/services/auth_service.dart';
import 'package:wallpaper/widgets/reusable/custom_button.dart';
import 'package:wallpaper/widgets/reusable/custom_input.dart';

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

  //todo: register
  void register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoding = true;
      });
      try {
        await authService.register(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registration susscussfull, please login"),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registration failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        setState(() {
          isLoding = false;
        });
      }
    }
  }

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
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "WallFit",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Make each time a real pleasure with unique wallpapers from QHD Wallpapers collections. Let your device become a source of self-expression, joy, inspiration and more...  ",
                      style: TextStyle(fontSize: 15),
                    ),
                    Image.asset(
                      "assets/images/logo.png",
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CustomInput(
                      controller: _usernameController,
                      labalText: "username",
                      obsecureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your username";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomInput(
                      controller: _emailController,
                      labalText: "email",
                      obsecureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomInput(
                      controller: _passwordController,
                      labalText: "password",
                      obsecureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    CustomButton(
                      isLoading: isLoding,
                      onPresed: register,
                      labelText: "Register",
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
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
