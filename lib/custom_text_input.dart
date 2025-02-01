import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final int? maxLines;
  final bool obscureText;

  const CustomTextInput({
    super.key,
    required this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.maxLines = 1,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Ensure RTL support
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        obscureText: obscureText,
        textAlign: TextAlign.right, // Align text to the right for RTL
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        validator: validator,
      ),
    );
  }
}