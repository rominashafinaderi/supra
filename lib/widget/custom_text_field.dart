import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  customTextField({
    super.key,
    this.label,
    this.prefixIcon,
    this.controller,
  });

  final TextEditingController? controller;
  String? label;
  IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.deepPurple.withOpacity(0.2),
          selectionHandleColor: Colors.deepPurple,
          cursorColor: Colors.deepPurple,
        ),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black54),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon,color: Colors.deepPurple,) : null,
          focusColor: Colors.deepPurple,
        ),
      ),
    );
  }
}