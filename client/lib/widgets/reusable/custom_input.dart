import 'package:flutter/material.dart';
import 'package:wallpaper/constans/colors.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String labalText;
  final bool obsecureText;
  final String? Function(String?) validator;
  const CustomInput({
    super.key,
    required this.controller,
    required this.labalText,
    required this.obsecureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        labelText: labalText,
        labelStyle:
            const TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red.shade600,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      cursorColor: primaryColor,
      validator: validator,
    );
  }
}
