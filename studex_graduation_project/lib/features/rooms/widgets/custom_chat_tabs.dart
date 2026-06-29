
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChatTabs extends StatelessWidget {
  final VoidCallback? onMembersTap;
  final VoidCallback? onQuizzesTap;
  final VoidCallback? onChatTap;

  const CustomChatTabs({
    super.key,
    this.onMembersTap,
    this.onQuizzesTap,
    this.onChatTap,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tab("الناس", false, onMembersTap),
        _tab("الكويزات", false, onQuizzesTap),
        _tab("الشات", true, onChatTap),
      ],
    );
  }

  Widget _tab(String label, bool isSelected, VoidCallback? onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xff6A6EF6) : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 3,
              color: isSelected ? const Color(0xff6A6EF6) : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
