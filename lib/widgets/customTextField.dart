import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      required this.error,
      required this.keyboard});

  final TextInputType keyboard;
  final TextEditingController controller;
  final String label;
  final String hint;
  final String error;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
          labelText: label,
          // helperText: 'Name',
          hintText: hint,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return error;
        }
        return null;
      },
    );
  }
}
