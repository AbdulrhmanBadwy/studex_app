import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/takeQuizWidget/quiz_progress.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/takeQuizWidget/quiz_view.dart';
import 'package:studex_graduation_project/features/quiz/presentation/widgets/takeQuizWidget/take_quiz_abb_bar.dart';

class TakeQuizScreen extends StatefulWidget {
  final QuizEntity quiz;
  final String roomId;

  const TakeQuizScreen({super.key, required this.quiz, required this.roomId});

  @override
  State<TakeQuizScreen> createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  int _currentIndex = 0;
  late List<int?> _selectedAnswers;

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List.filled(widget.quiz.questions.length, null);
  }

  bool get _isLastQuestion => _currentIndex == widget.quiz.questions.length - 1;

  void _onNext() {
    if (_selectedAnswers[_currentIndex] == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('من فضلك اختر إجابة')));
      return;
    }

    if (_isLastQuestion) {
      context.pushNamed(
        AppRoutes.quizResultScreen,
        extra: {
          'quiz': widget.quiz,
          'roomId': widget.roomId,
          'answers': _selectedAnswers.map((e) => e ?? 0).toList(),
        },
      );
    } else {
      setState(() => _currentIndex++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[_currentIndex];
    final progress = (_currentIndex + 1) / widget.quiz.questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: QuizAppBar(
        subject: widget.quiz.title,
        currentQuestion: _currentIndex + 1,
        totalQuestions: widget.quiz.questions.length,
        onClose: () => context.pop(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            QuizProgressHeader(progress: progress),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: QuizQuestionWidget(
                  question: question.question,
                  options: question.options,
                  selectedIndex: _selectedAnswers[_currentIndex],
                  onOptionSelected: (index) {
                    setState(() {
                      _selectedAnswers[_currentIndex] = index;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAllColor,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLastQuestion ? 'إنهاء الاختبار' : 'التالي',
                      style: AppStyles.bold16white.copyWith(
                        fontFamily: 'AbdoMaster',
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      _isLastQuestion ? Icons.check : Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
