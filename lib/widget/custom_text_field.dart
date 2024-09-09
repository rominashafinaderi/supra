import 'package:flutter/material.dart';
import 'package:supra/colors.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.label,
    this.prefixIcon,
    this.controller,
    this.isPassword = false,
  });

  final TextEditingController? controller;
  final String? label;
  final IconData? prefixIcon;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: primaryColor.withOpacity(0.2),
          selectionHandleColor: primaryColor,
          cursorColor: primaryColor,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        style: TextStyle(
          fontSize: 12,
        ),
        obscureText: widget.isPassword && _obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.black54),
          filled: true,
          fillColor: white.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: primaryColor),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: darkPurple,
                )
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: darkPurple,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          focusColor: primaryColor,
        ),
      ),
    );
  }
}
