import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? label;
  final String? hint;
  final IconData? suffixIcon;
  final TextEditingController textEditingController;
  const TextFormFieldWidget({
    Key? key,
    this.label,
    this.hint,
    this.suffixIcon,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        label: Text(
          label!,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        floatingLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        hintText: hint!,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Cairo',
          fontSize: 14,
        ),
        suffixIcon: Icon(
          suffixIcon,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          gapPadding: 10,
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          gapPadding: 10,
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
