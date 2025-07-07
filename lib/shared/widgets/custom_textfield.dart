import 'package:coursezy/shared/styles/text.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      errorBuilder:
          (context, errorText) => Container(
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            margin: const EdgeInsets.only(top: 0, bottom: 0),
            child: Text(errorText, style: TextStyles.errorField),
          ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.all(20),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: label,
        hintStyle: TextStyles.gilroyMediumAlpha,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      obscureText: obscureText,
    );
  }
}
