import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class CustomTextFormFiled extends StatelessWidget {
  CustomTextFormFiled(
      {super.key,
      required this.hintText,
      this.onChange,
      required this.keyboardType,
      this.passVisabilty = false,
      this.iconButton});

  String? hintText;
  Function(String)? onChange;
  // String? Function(String? value)? validator;
  TextInputType keyboardType;
  bool passVisabilty;
  IconButton? iconButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      keyboardType: keyboardType,
      obscureText: passVisabilty,
      onChanged: onChange,
      decoration: InputDecoration(
        suffixIcon: iconButton,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
