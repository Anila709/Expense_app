import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    required this.mController
  });

  final String hintText;
  final Widget suffixIcon;
  final TextEditingController mController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mController,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
                style: BorderStyle.solid,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
                style: BorderStyle.solid,
              ))),
    );
  }
}
