

import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {
  const RegisterTextField({
    required this.hintText,
    required this.validator,
    this.textInputType,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.controller,
    super.key,
  });

  final String hintText;
  final String? Function(String?) validator;
  final TextInputType? textInputType;
  final FocusNode focusNode;
  final Function(String?) onFieldSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      color: Colors.white,
      child: Center(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            errorStyle: const TextStyle(
              height: 1,
              fontSize: 11,
              color: Colors.red,
            ),
          ),
          keyboardType: textInputType,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
        ),
      )
    );
  }
}