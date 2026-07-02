import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizStepper extends StatelessWidget {
  final int currentStep; // 1 or 2
  const QuizStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          children: [
            _StepCircle(
              number: 1,
              label: 'الأسئلة',
              isActive: currentStep == 1,
              isDone: currentStep > 1,
            ),
            _StepLine(isActive: currentStep > 1),
            _StepCircle(
              number: 2,
              label: 'المراجعة',
              isActive: currentStep == 2,
              isDone: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  final int number;
  final String label;
  final bool isActive;
  final bool isDone;

  const _StepCircle({
    required this.number,
    required this.label,
    required this.isActive,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isActive
        ? const Color(0xff6366F1)
        : isDone
        ? const Color(0xff6366F1)
        : const Color(0xffE2E8F0);
    final Color textColor =
    (isActive || isDone) ? Colors.white : const Color(0xff94A3B8);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
            boxShadow: isActive
                ? [
              BoxShadow(
                color: const Color(0xff6366F1).withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ]
                : [],
          ),
          child: Center(
            child: isDone
                ? Icon(Icons.check, color: Colors.white, size: 18.sp)
                : Text(
              '$number',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                fontFamily: 'AbdoMaster',
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontFamily: 'AbdoMaster',
            color: isActive
                ? const Color(0xff6366F1)
                : const Color(0xff94A3B8),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool isActive;
  const _StepLine({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2.5,
        margin: EdgeInsets.only(bottom: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isActive
              ? const Color(0xff6366F1)
              : const Color(0xffE2E8F0),
        ),
      ),
    );
  }
}