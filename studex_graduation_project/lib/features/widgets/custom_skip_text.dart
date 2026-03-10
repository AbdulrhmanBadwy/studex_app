import 'package:flutter/material.dart';

class CustomSkipText extends StatelessWidget {
  final String text ;
  final VoidCallback onPressed;
  const CustomSkipText({super.key, required this.text , required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text ,));
  }
}
