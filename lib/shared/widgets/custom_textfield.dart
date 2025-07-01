import 'package:coursezy/shared/styles/colors.dart';
import 'package:coursezy/shared/styles/text.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
