import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_cubit.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_state.dart';

class MainTaskCard extends StatelessWidget {
  const MainTaskCard({super.key});

  void _openLatestQuiz(BuildContext context, HomeState state) {
    final quiz = state.latestQuiz;
    final roomId = state.latestQuizRoomId;
    if (quiz == null || roomId == null || roomId.isEmpty) {
      return;
    }

    context.pushNamed(
      AppRoutes.startQuiz,
      extra: {'quiz': quiz, 'roomId': roomId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final isLoading = state.taskStatus == HomeSectionStatus.loading;
        final isError = state.taskStatus == HomeSectionStatus.error;
        final isNoRooms = state.taskStatus == HomeSectionStatus.noRoomsJoined;
        final isNoQuizzes = state.taskStatus == HomeSectionStatus.noQuizzesYet;

        final totalQuizzes = state.totalQuizzesCount;
        final completedQuizzes = state.completedQuizzesCount;
        final uncompletedQuizzes = state.uncompletedQuizzesCount;

        final title = isNoRooms
            ? 'لسه منضمش لأي غرفة'
            : isError
            ? 'تعذر تحميل المهام'
            : totalQuizzes == 0
            ? 'لا توجد اختبارات بعد'
            : 'عدد الاختبارات في غرفك';

        final subtitle = isNoRooms
            ? state.taskMessage ?? 'انضم لغرفة الأول عشان تشوف مهامك'
            : isNoQuizzes || totalQuizzes == 0
            ? state.taskMessage ?? 'مفيش اختبارات لسه في غرفك'
            : isError
            ? state.taskMessage ?? 'حاول مرة أخرى'
            : 'إجمالي الاختبارات في الغرف التي انضممت إليها';

        final buttonText = isNoRooms
            ? 'الذهاب للغرف'
            : isError
            ? 'إعادة المحاولة'
            : state.latestQuiz == null
            ? 'استكشف الغرف'
            : 'عرض التفاصيل';

        final VoidCallback? onPressed = isLoading
            ? null
            : isNoRooms
            ? () => context.go(AppRoutes.roomListScreen)
            : isError
            ? () => context.read<HomeCubit>().loadRecentChats()
            : state.latestQuiz == null
            ? () => context.go(AppRoutes.roomListScreen)
            : () => _openLatestQuiz(context, state);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xff8E92FF), Color(0xff6A6EF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'المهام القادمة',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$totalQuizzes',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'الإجمالي في الغرف المنضم لها',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _StatChip(
                              label: 'مكتملة',
                              value: completedQuizzes,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _StatChip(
                              label: 'غير مكتملة',
                              value: uncompletedQuizzes,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xff6A6EF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
