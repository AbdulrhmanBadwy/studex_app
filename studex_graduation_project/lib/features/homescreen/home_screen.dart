import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/custom_button_nav_bar.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/home_header.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/main_task_card.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/recent_room_list.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/section_title.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/study_room_grid.dart';

import '../../core/widgets/spacing.dart';

// ملاحظة: استبدل Colors.blue و الألوان الثابتة بـ AppColors اللي عندك
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff6A6EF6),
        shape: const CircleBorder(),
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: 30.sp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: CustomButtonNavBar(),

      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(),
                const HeightSpacing(25),
                const MainTaskCard(),
                const HeightSpacing(30),
                SectionTitle(
                  title: "غرف الدراسة",
                  actionText: '                الكل',
                ),
                const HeightSpacing(15),
                const StudyRoomsGrid(),
                const HeightSpacing(30),
                SectionTitle(
                  title: "المحادثات الأخيرة",
                  actionText: "رؤية الكل",
                ),
                const SizedBox(height: 15),
                const RecentChatsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
