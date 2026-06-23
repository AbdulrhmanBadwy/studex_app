import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/quiz/widgets/create_quiz_widget/add_question_card.dart';
import 'package:studex_graduation_project/features/quiz/widgets/create_quiz_widget/quiz_stepper.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_bloc.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_event.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_state.dart';
import 'package:studex_graduation_project/models/quiz_model.dart';
import 'package:studex_graduation_project/models/question_model.dart';
import 'package:studex_graduation_project/repositories/quiz_repository.dart';

class CreateQuizStepOne extends StatefulWidget {
  final String quizTitle;
  final String quizDescription;
  final int timePerQuestion;
  final QuizModel? quiz;

  const CreateQuizStepOne({
    super.key,
    required this.quizTitle,
    required this.quizDescription,
    required this.timePerQuestion,
    this.quiz,
  });

  @override
  State<CreateQuizStepOne> createState() => _CreateQuizStepOneState();
}

class _CreateQuizStepOneState extends State<CreateQuizStepOne> {
  final List<_QuestionData> _questionsData = [_QuestionData()];

  void _addQuestion() {
    setState(() => _questionsData.add(_QuestionData()));
  }

  void _removeQuestion(int index) {
    if (_questionsData.length > 1) {
      setState(() {
        _questionsData[index].dispose();
        _questionsData.removeAt(index);
      });
    }
  }

  List<QuestionModel>? _buildAndValidateQuestions() {
    final questions = <QuestionModel>[];

    for (int i = 0; i < _questionsData.length; i++) {
      final data = _questionsData[i];
      final text = data.questionController.text.trim();

      if (text.isEmpty) {
        _showError('نص السؤال ${i + 1} فارغ');
        return null;
      }

      final options = data.optionControllers.map((c) => c.text.trim()).toList();
      if (options.any((o) => o.isEmpty)) {
        _showError('اكتب كل الإجابات في السؤال ${i + 1}');
        return null;
      }

      if (data.correctIndex == null) {
        _showError('حدد الإجابة الصحيحة في السؤال ${i + 1}');
        return null;
      }

      questions.add(QuestionModel(
        id: const Uuid().v4(),
        text: text,
        options: options,
        correctOptionIndex: data.correctIndex!,
        marks: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }

    return questions;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _submit(BuildContext blocContext) {
    final questions = _buildAndValidateQuestions();
    if (questions == null) return;

    final quiz = (widget.quiz ?? QuizModel(
      id: const Uuid().v4(),
      title: widget.quizTitle,
      description: widget.quizDescription,
      timePerQuestion: widget.timePerQuestion,
      creatorId: '',
    )).copyWith(
      isPublished: true,
      totalMarks: questions.length,
    );

    blocContext.read<QuizBloc>().add(
      CreateQuizRequested(quiz: quiz, questions: questions),
    );
  }

  @override
  void dispose() {
    for (final d in _questionsData) {
      d.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc(quizRepository: FirestoreQuizRepository()),
      child: Builder(
        builder: (blocContext) {
          return BlocListener<QuizBloc, QuizState>(
            listener: (context, state) {
              if (state is QuizCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إنشاء الاختبار بنجاح ✓')),
                );
                context.pushNamed(
                  AppRoutes.createQuizStepTwo,
                  extra: {
                    'quizTitle': widget.quizTitle,
                    'questionsCount': _questionsData.length,
                    'timePerQuestion': widget.timePerQuestion,
                  },
                );
              } else if (state is QuizFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: const Color(0xffF8F6F6),
                body: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => context.pop(),
                              icon: Icon(Icons.arrow_back, size: 24.sp,
                                  color: const Color(0xff0F172A)),
                            ),
                            SizedBox(width: 8.w),
                            Text('إنشاء اختبار جديد',
                                style: AppStyles.primaryHeadlineStyle),
                          ],
                        ),
                      ),
                      QuizStepper(currentStep: 1),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          child: Column(
                            children: [
                              ...List.generate(
                                _questionsData.length,
                                    (i) => _ConnectedQuestionCard(
                                  data: _questionsData[i],
                                  questionNumber: i + 1,
                                  onDelete: _questionsData.length > 1
                                      ? () => _removeQuestion(i)
                                      : null,
                                  onCorrectSelected: (idx) {
                                    setState(() {
                                      _questionsData[i].correctIndex = idx;
                                    });
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: _addQuestion,
                                child: Container(
                                  width: double.infinity,
                                  height: 52.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14.r),
                                    border: Border.all(
                                        color: const Color(0xff6366F1), width: 1.5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_circle_outline,
                                          color: const Color(0xff6366F1), size: 20.sp),
                                      SizedBox(width: 8.w),
                                      Text('إضافة سؤال آخر',
                                          style: TextStyle(
                                            fontFamily: 'AbdoMaster',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff6366F1),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              HeightSpacing(100),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: BlocBuilder<QuizBloc, QuizState>(
                    builder: (ctx, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: state is QuizLoading ? null : () => _submit(ctx),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryAllColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r)),
                            elevation: 0,
                          ),
                          child: state is QuizLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('حفظ ونشر الاختبار',
                                  style: TextStyle(
                                    fontFamily: 'AbdoMaster',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                              SizedBox(width: 8.w),
                              Icon(Icons.rocket_launch_outlined,
                                  color: Colors.white, size: 20.sp),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _QuestionData {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers =
  List.generate(4, (_) => TextEditingController());
  int? correctIndex;

  void dispose() {
    questionController.dispose();
    for (final c in optionControllers) {
      c.dispose();
    }
  }
}

class _ConnectedQuestionCard extends StatelessWidget {
  final _QuestionData data;
  final int questionNumber;
  final VoidCallback? onDelete;
  final ValueChanged<int> onCorrectSelected;

  const _ConnectedQuestionCard({
    required this.data,
    required this.questionNumber,
    this.onDelete,
    required this.onCorrectSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xffE8ECF4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xffEEF0FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('السؤال $questionNumber',
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff6366F1),
                    )),
              ),
              const Spacer(),
              if (onDelete != null)
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete_outline,
                      color: Colors.red.shade300, size: 20.sp),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Text('نص السؤال',
              style: TextStyle(
                  fontFamily: 'AbdoMaster',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff0F172A))),
          SizedBox(height: 6.h),
          TextField(
            controller: data.questionController,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontFamily: 'AbdoMaster', fontSize: 13.sp),
            decoration: _inputDecoration('اكتب السؤال هنا...'),
          ),
          SizedBox(height: 14.h),
          Text('خيارات الإجابة (اختر الصحيحة)',
              style: TextStyle(
                  fontFamily: 'AbdoMaster',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff0F172A))),
          SizedBox(height: 8.h),
          ...List.generate(4, (i) => _OptionRow(
            index: i,
            controller: data.optionControllers[i],
            isCorrect: data.correctIndex == i,
            onSelect: () => onCorrectSelected(i),
          )),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
        fontFamily: 'AbdoMaster',
        fontSize: 13.sp,
        color: const Color(0xff94A3B8)),
    contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
    filled: true,
    fillColor: const Color(0xffF8FAFC),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: Color(0xffE8ECF4)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: Color(0xff6366F1)),
    ),
  );
}

class _OptionRow extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final bool isCorrect;
  final VoidCallback onSelect;

  const _OptionRow({
    required this.index,
    required this.controller,
    required this.isCorrect,
    required this.onSelect,
  });

  static const _labels = ['أ', 'ب', 'ج', 'د'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onSelect,
            child: Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCorrect ? const Color(0xff6366F1) : const Color(0xffE2E8F0),
                border: Border.all(
                    color: isCorrect
                        ? const Color(0xff6366F1)
                        : const Color(0xffCBD5E1)),
              ),
              child: isCorrect
                  ? Icon(Icons.check, color: Colors.white, size: 13.sp)
                  : null,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCorrect
                  ? const Color(0xffEEF0FF)
                  : const Color(0xffF1F5F9),
            ),
            child: Center(
              child: Text(_labels[index],
                  style: TextStyle(
                    fontFamily: 'AbdoMaster',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: isCorrect
                        ? const Color(0xff6366F1)
                        : const Color(0xff64748B),
                  )),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'AbdoMaster', fontSize: 13.sp),
              decoration: InputDecoration(
                hintText: 'أدخل الإجابة',
                hintStyle: TextStyle(
                    fontFamily: 'AbdoMaster',
                    fontSize: 12.sp,
                    color: const Color(0xff94A3B8)),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                filled: true,
                fillColor: isCorrect
                    ? const Color(0xffF0F0FF)
                    : const Color(0xffF8FAFC),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                      color: isCorrect
                          ? const Color(0xff6366F1)
                          : const Color(0xffE8ECF4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Color(0xff6366F1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}