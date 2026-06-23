import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;
  const SectionTitle({
    super.key,
    required this.title,
    required this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff2D3142),
          ),
        ),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: const TextStyle(
              color: Color(0xff6A6EF6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
