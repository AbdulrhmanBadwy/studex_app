import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_create_room_button.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_text_form_field.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_headline_create_room.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_bloc.dart';
import 'package:studex_graduation_project/blocs/quiz/quiz_state.dart';
import 'package:studex_graduation_project/models/quiz_model.dart';
import 'package:studex_graduation_project/repositories/quiz_repository.dart';

class CreateQuizz extends StatefulWidget {
  const CreateQuizz({super.key});

  @override
  State<CreateQuizz> createState() => _CreateQuizzState();
}

class _CreateQuizzState extends State<CreateQuizz> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController(text: '30');

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _next() {
    if (_formKey.currentState?.validate() != true) return;

    final quizId = const Uuid().v4();
    final quiz = QuizModel(
      id: quizId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      timePerQuestion: int.tryParse(_timeController.text) ?? 30,
      creatorId: '',
      isPublished: false,
    );

    context.pushNamed(
      AppRoutes.createQuizStepOne,
      extra: {
        'quiz': quiz,
        'quizTitle': quiz.title,
        'quizDescription': quiz.description,
        'timePerQuestion': quiz.timePerQuestion,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc(quizRepository: FirestoreQuizRepository()),
      child: BlocListener<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xffF8F6F6),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeadlineCreateRoom(
                        title: 'إنشاء اختبار جديد',
                        onPressed: () => context.pop(),
                      ),
                      HeightSpacing(18),
                      Text('عنوان الاختبار',
                          style: AppStyles.bold16black.copyWith(fontFamily: 'AbdoMaster')),
                      HeightSpacing(8),
                      CustomTextFormField(
                        hintText: 'مثال: اختبار على الفصل الأول',
                        controller: _titleController,
                      ),
                      HeightSpacing(24),
                      Text('وصف الاختبار',
                          style: AppStyles.bold16black.copyWith(fontFamily: 'AbdoMaster')),
                      HeightSpacing(8),
                      CustomTextFormField(
                        hintText: 'أضف تفاصيل للطلاب',
                        heigh: 120,
                        maxLines: null,
                        controller: _descriptionController,
                      ),
                      HeightSpacing(24),
                      Text('وقت كل سؤال (بالثواني)',
                          style: AppStyles.bold16black.copyWith(fontFamily: 'AbdoMaster')),
                      HeightSpacing(8),
                      CustomTextFormField(
                        hintText: '30',
                        suffixIcon: const Icon(Icons.timer_outlined),
                        controller: _timeController,
                      ),
                      HeightSpacing(48),
                      CustomCreateRoomButton(
                        text: 'التالي',
                        onPressed: _next,
                      ),
                      HeightSpacing(24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}