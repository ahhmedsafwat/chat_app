import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  CustomBtn({super.key, required this.title, this.onTap});
  String? title;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            "$title",
          ),
        ),
      ),
    );
  }
}
