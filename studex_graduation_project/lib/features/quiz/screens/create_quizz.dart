import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_create_room_button.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_text_form_field.dart';

import '../../rooms/widgets/custom_headline_create_room.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';

class CreateQuizz extends StatefulWidget {
  const CreateQuizz({super.key});

  @override
  State<CreateQuizz> createState() => _CreateQuizzState();
}

class _CreateQuizzState extends State<CreateQuizz> {
  bool isPublic = true;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeadlineCreateRoom(
                  title: 'إنشاء أختبار جديد',
                  onPressed: () {
                    context.pop();
                  },
                ),
                HeightSpacing(18),
                Text(
                  'الأختبار',
                  style: AppStyles.bold16black.copyWith(
                    fontFamily: 'AbdoMaster',
                  ),
                ),
                HeightSpacing(8),
                CustomTextFormField(
                  hintText: 'مثال : اختبار علي شابتر 1 لغات صورية',
                  controller: _titleController,
                ),
                HeightSpacing(24),
                Text(
                  'وصف الإختبار',
                  style: AppStyles.bold16black.copyWith(
                    fontFamily: 'AbdoMaster',
                  ),
                ),
                HeightSpacing(8),
                CustomTextFormField(
                  hintText: 'أضف تفاصيل إضافية للطلاب',
                  heigh: 150,
                  maxLines: null,
                  controller: _descriptionController,
                ),
                HeightSpacing(24),
                Text(
                  'وقت لكل سؤال ( بالثواني ) ',
                  style: AppStyles.bold16black.copyWith(
                    fontFamily: 'AbdoMaster',
                  ),
                ),
                HeightSpacing(8),
                CustomTextFormField(
                  hintText: '30',
                  suffixIcon: Icon(Icons.timer),
                  controller: _timeController,
                ),
                HeightSpacing(76),
                CustomCreateRoomButton(
                  text: 'التالي',
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.createQuizStepOne,
                      extra: {
                        'quizTitle': _titleController.text,
                        'quizDescription': _descriptionController.text,
                        'timePerQuestion':
                            int.tryParse(_timeController.text) ?? 30,
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
