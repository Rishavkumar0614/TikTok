import 'package:flutter/material.dart';
import 'package:tiktok/commons.dart';

class TextInputField extends StatelessWidget {
  final IconData icon;
  final bool isObscure;
  final String labelText;
  final TextEditingController controller;

  const TextInputField({
    super.key,
    required this.icon,
    this.isObscure = false,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
