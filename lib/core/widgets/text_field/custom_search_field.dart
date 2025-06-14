import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    required this.controller,
    super.key,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.hintText,
  });

  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String value)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.grey), // Gri border
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: prefixIcon ?? const Icon(Icons.search, color: Colors.grey),
          suffixIcon: suffixIcon,
          hintText: hintText ?? 'Search medicine...',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
