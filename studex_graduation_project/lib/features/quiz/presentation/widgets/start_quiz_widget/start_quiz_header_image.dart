import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartQuizHeaderImage extends StatelessWidget {
  final String imageUrl;

  const StartQuizHeaderImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h, bottom: 32.h),
      child: Center(
        child: SizedBox(
          width: 260.w,
          height: 260.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 260.w,
                height: 260.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1A1F2E),
                ),
              ),
              Container(
                width: 190.w,
                height: 190.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5EDD8),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
