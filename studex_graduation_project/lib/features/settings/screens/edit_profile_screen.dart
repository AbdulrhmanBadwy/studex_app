import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';

import '../../../core/theme/app_styles.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,

      /// AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "تعديل الملف الشخصي",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// الصورة
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 128.w,
                    height: 128.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundColor: Colors.grey,
                      child: SvgPicture.asset(AssetsPaths.editProfile),
                    ),
                  ),

                  Positioned(
                    right: 10,
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryAllColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2.w,
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // TODO: add avatar/image picker flow.
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const HeightSpacing(10),

              Text(
                "تغيير الصورة",
                style: AppStyles.primaryHeadlineStyle.copyWith(
                  color: AppColors.primaryAllColor,
                  fontSize: 14.sp,
                ),
              ),

              const HeightSpacing(30),

              /// المعلومات الدراسية
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "المعلومات الدراسية",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'AbdoMaster',
                  ),
                ),
              ),
              const HeightSpacing(20),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الاسم بالكامل',
                  style: AppStyles.primaryHeadlineStyle.copyWith(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              const HeightSpacing(8),
              TextField(
                style: AppStyles.primaryHeadlineStyle.copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
                decoration: InputDecoration(
                  hintText: "مثال: عبدالله احمد ",
                  hintStyle: AppStyles.primaryHeadlineStyle.copyWith(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                  prefixIcon: const Icon(Icons.school),
                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const HeightSpacing(20),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الكلية',
                  style: AppStyles.primaryHeadlineStyle.copyWith(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              const HeightSpacing(8),

              /// الكلية
              TextField(
                style: AppStyles.bold16primary.copyWith(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "كلية علوم الحاسب",
                  hintStyle: AppStyles.primaryHeadlineStyle.copyWith(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                  prefixIcon: const Icon(Icons.school),
                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const HeightSpacing(20),

              /// السنة والتخصص
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "السنة الثالثة",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),

                  const WidthSpacing(10),

                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "هندسة البرمجيات",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const HeightSpacing(30),

              /// زر الحفظ
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryAllColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () => context.pop(),
                  child: Text(
                    "حفظ التعديلات",
                    style: AppStyles.primaryHeadlineStyle.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
