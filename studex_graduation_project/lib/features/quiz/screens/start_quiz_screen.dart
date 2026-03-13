import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/features/quiz/widgets/start_quiz_widget/abb_bar_start_quiz.dart';
import 'package:studex_graduation_project/features/quiz/widgets/start_quiz_widget/start_quiz_button.dart';
import 'package:studex_graduation_project/features/quiz/widgets/start_quiz_widget/start_quiz_details.dart';
import 'package:studex_graduation_project/features/quiz/widgets/start_quiz_widget/start_quiz_header_image.dart';
import 'package:studex_graduation_project/features/quiz/widgets/start_quiz_widget/start_quiz_title.dart';

class StartQuizScreen extends StatelessWidget {
  const StartQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FF),
      appBar: StartQuizAppBar(
        title: 'هندسة',
        subtitle: 'الترم الاول',
        onMenuPressed: () {},
        onArrowPressed: () {},
      ),
      body:
    Column(
      children: [
        StartQuizHeaderImage(
              imageUrl:
                  'https://media.istockphoto.com/id/1616906708/vector/vector-speech-bubble-with-quiz-time-words-trendy-text-balloon-with-geometric-grapic-shape.jpg?s=2048x2048&w=is&k=20&c=5Yp0ha5yM9YQGZx01kR3bGh-M9H4N2XEJLGDOXe7R1o=',
            ),
        StartQuizTitleSection(
          title: 'اختبار الوحدة الأولى - أساسيات',
          subtitle: 'يتضمن هذا الاختبار مفاهيم هندسة البرمجيات الأساسية، دورة حياة النظام، والنماذج المختلفة للتطوير. استعد جيداً!',
        ),
        SizedBox(height: 16.h),
        StartQuizDetailsSection(participantsCount: '12', timeValue: '20', questionsCount: '15',),
        SizedBox(height: 40.h),
        StartQuizButton(label: 'بدء الجلسة الآن', onPressed: () {  },),
      ],
    ),

    );
  }
}
