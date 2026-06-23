import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_bloc.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_event.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_state.dart';
import 'package:studex_graduation_project/core/services/auth_service.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/features/quiz/widgets/takeQuizWidget/quiz_progress.dart';
import 'package:studex_graduation_project/features/quiz/widgets/takeQuizWidget/take_quiz_abb_bar.dart';
import 'package:studex_graduation_project/repositories/quiz_repository.dart';

class TakeQuizScreen extends StatefulWidget {
  final String quizId;

  const TakeQuizScreen({super.key, required this.quizId});

  @override
  State<TakeQuizScreen> createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(quizRepository: FirestoreQuizRepository())
        ..add(LoadQuestionsRequested(quizId: widget.quizId)),
      child: BlocConsumer<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizResultState) {
            context.go(
              AppRoutes.quizResultScreen,
              extra: {
                'score': state.score,
                'totalQuestions': state.totalQuestions,
                'totalMarks': state.totalMarks,
              },
            );
          } else if (state is QuizFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is QuizFailure) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message,
                        style: AppStyles.bold16black, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.pop(),
                      child: const Text('رجوع'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is! QuizTakingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final quiz = state.quiz;
          final questions = state.questions;
          final totalPages = questions.length;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: const Color(0xFFF8F9FF),
              appBar: QuizAppBar(
                subject: quiz.title,
                currentQuestion: _currentPage + 1,
                totalQuestions: totalPages,
                remainingSeconds: 0,
                onClose: () => context.pop(),
              ),
              body: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    QuizProgressHeader(
                      progress: totalPages > 0 ? _currentPage / totalPages : 0,
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: totalPages,
                        onPageChanged: (p) => setState(() => _currentPage = p),
                        itemBuilder: (context, i) {
                          final q = questions[i];
                          final selected = state.answers[i];

                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    q.text,
                                    style: AppStyles.bold20black.copyWith(
                                        fontFamily: 'AbdoMaster'),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                ...List.generate(q.options.length, (optIdx) {
                                  final isSelected = selected == optIdx;
                                  return GestureDetector(
                                    onTap: () {
                                      context.read<QuizBloc>().add(
                                        AnswerSelected(
                                          questionIndex: i,
                                          selectedOptionIndex: optIdx,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 12.h),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16.h, horizontal: 20.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16.r),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.primaryAllColor
                                              : Colors.grey.shade200,
                                          width: isSelected ? 2 : 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              q.options[optIdx],
                                              style: isSelected
                                                  ? AppStyles.primaryBoldBlue18
                                                  .copyWith(
                                                  fontFamily: 'AbdoMaster')
                                                  : AppStyles.bold20black.copyWith(
                                                  fontFamily: 'AbdoMaster'),
                                            ),
                                          ),
                                          Container(
                                            height: 24.h,
                                            width: 24.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: isSelected
                                                  ? AppColors.primaryLight
                                                  : Colors.transparent,
                                              border: isSelected
                                                  ? null
                                                  : Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 2),
                                            ),
                                            child: isSelected
                                                ? Icon(Icons.check_circle,
                                                color: AppColors.primaryAllColor,
                                                size: 16.sp)
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        if (_currentPage > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r)),
                                side: BorderSide(color: AppColors.primaryAllColor),
                              ),
                              child: Text('السابق',
                                  style: AppStyles.bold16primary
                                      .copyWith(fontFamily: 'AbdoMaster')),
                            ),
                          ),
                        if (_currentPage > 0) SizedBox(width: 12.w),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentPage < totalPages - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                final uid =
                                    AuthService.instance.currentUser?.uid ?? '';
                                context
                                    .read<QuizBloc>()
                                    .add(QuizSubmitted(userId: uid));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryAllColor,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r)),
                            ),
                            child: Text(
                              _currentPage < totalPages - 1 ? 'التالي' : 'تسليم',
                              style: AppStyles.bold16white
                                  .copyWith(fontFamily: 'AbdoMaster'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}