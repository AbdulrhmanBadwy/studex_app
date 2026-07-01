import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_cubit.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/home_header.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/main_task_card.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/recent_room_list.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/section_title.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/study_room_grid.dart';
import 'package:studex_graduation_project/repositories/room_repository.dart';

import '../../core/widgets/spacing.dart';

// ملاحظة: استبدل Colors.blue و الألوان الثابتة بـ AppColors اللي عندك
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit = HomeCubit(FirestoreRoomRepository())
    ..loadRecentChats();

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeCubit,
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FD),

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff6A6EF6),
          shape: const CircleBorder(),
          onPressed: () => context.pushNamed(AppRoutes.createRoomScreen),
          child: Icon(Icons.add, color: Colors.white, size: 30.sp),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
                    onActionTap: () => context.go(AppRoutes.roomListScreen),
                  ),
                  const HeightSpacing(15),
                  const StudyRoomsGrid(),
                  const HeightSpacing(30),
                  SectionTitle(
                    title: "المحادثات الأخيرة",
                    actionText: "رؤية الكل",
                    onActionTap: () => context.go(AppRoutes.roomListScreen),
                  ),
                  const SizedBox(height: 15),
                  const RecentChatsList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
