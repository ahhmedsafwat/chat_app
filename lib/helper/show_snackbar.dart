import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String messege) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(messege),
    ),
  );
}
