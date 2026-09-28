import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const FormTextField({
    super.key,
    required this.label,
    this.hint = '',
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.amberAccent,
            fontWeight: FontWeight.w300,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 8,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFFFE0BD), width: 0.9),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFFFD700), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
