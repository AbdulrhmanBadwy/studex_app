import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChatTabs extends StatelessWidget {
  const CustomChatTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tab("الأعضاء", false),
        _tab("الاختبارات", false),
        _tab("الدردشة", true),
      ],
    );
  }
  Widget _tab(String label, bool isSelected) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 12.h),
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
    );
  }
  }