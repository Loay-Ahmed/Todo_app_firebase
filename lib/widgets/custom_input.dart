import 'package:flutter/material.dart';
import 'package:todo_fire/providers/theme_provider.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.controller,
    this.obscure = false,
    required this.label,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final bool obscure;
  final String label;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = ThemeProvider();
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: provider.colorScheme.onPrimaryFixedVariant,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            // color: myColors.colorScheme.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: provider.colorScheme.onPrimaryFixedVariant,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
