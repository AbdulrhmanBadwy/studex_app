import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRoomTypeToggle extends StatelessWidget {
  final bool isPublic;
  final String publicIcon;
  final String privateIcon;
  final Function(bool) onChanged;

  const CustomRoomTypeToggle({
    super.key,
    required this.isPublic,
    required this.onChanged,
    required this.publicIcon,
    required this.privateIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: const Color(0xffE8ECF4).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [

          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isPublic ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 175.w,
              height: 52.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isPublic) onChanged(true);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          publicIcon,
                          width: 20.w,
                          colorFilter: ColorFilter.mode(
                            isPublic ? const Color(0xff6C63FF) : const Color(0xff94A3B8),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'غرفة عامة',
                          style: TextStyle(
                            fontFamily: 'AbdoMaster',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isPublic ? const Color(0xff6C63FF) : const Color(0xff94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isPublic) onChanged(false);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          privateIcon,
                          width: 20.w,
                          colorFilter: ColorFilter.mode(
                            !isPublic ? const Color(0xff6C63FF) : const Color(0xff94A3B8),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'غرفة خاصة',
                          style: TextStyle(
                            fontFamily: 'AbdoMaster',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: !isPublic ? const Color(0xff6C63FF) : const Color(0xff94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}