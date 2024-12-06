import 'package:flutter/material.dart';
import 'package:wallpaper/constans/colors.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPresed;
  final String labelText;

  const CustomButton({
    super.key,
    required this.isLoading,
    required this.onPresed,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: onPresed,
              child: Text(
                labelText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
