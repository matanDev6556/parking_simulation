import 'package:flutter/material.dart';

class Validation {
  static validateEmpty(String? value, String field) {
    if (value == null || value.isEmpty) return '$field is required!';
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(value) ? null : 'Invalid email format';
  }

  static showSnackBarMsg(
      String titel, String msg, Color color, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
