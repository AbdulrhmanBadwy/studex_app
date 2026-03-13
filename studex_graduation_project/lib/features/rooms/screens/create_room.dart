import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_create_room_button.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_room_type_toggle.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_text_form_field.dart';

import '../widgets/custom_headline_create_room.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  bool isPublic = true;

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
                  title: 'إنشاء غرفة جديدة',
                  onPressed: () {
                    GoRouter.of(context).pop;
                  },
                ),
                HeightSpacing(18),
                Text(
                  'اسم الغرفة',
                  style: AppStyles.bold16black.copyWith(
                    fontFamily: 'AbdoMaster',
                  ),
                ),
                HeightSpacing(8),
                CustomTextFormField(
                  hintText: 'مثال : جروب فرقة تالته حساسبات ومعلومات',
                ),
                HeightSpacing(24),
                Text(
                  'وصف مختصر',
                  style: AppStyles.bold16black.copyWith(
                    fontFamily: 'AbdoMaster',
                  ),
                ),
                HeightSpacing(8),
                CustomTextFormField(
                  hintText: 'ما هو الهدف من هذه الغرفة ؟',
                  heigh: 150,
                  maxLines: null,
                ),
                HeightSpacing(24),
                Text(
                  'خصوصية الغرقة',
                  style: AppStyles.bold16black.copyWith(
                    fontFamily: 'AbdoMaster',
                  ),
                ),
                HeightSpacing(8),

                CustomRoomTypeToggle(
                  isPublic: isPublic,
                  publicIcon: AssetsPaths.publicRoom,
                  privateIcon: AssetsPaths.privateRoom,
                  onChanged: (value) {
                    setState(() {
                      isPublic = value;
                    });
                  },
                ),
                HeightSpacing(12),
                Text(
                  'الغرف العامة تظهر للجميع في نتائج البحث ، بينما الغرف الخاصة تتطلب دعوة ',
                  style: TextStyle(
                    color: Color(0xff64748B),
                    fontSize: 12,
                    fontFamily: 'AbdoMaster',
                  ),
                ),
                HeightSpacing(143),
                CustomCreateRoomButton(onPressed: (){} , text: 'إنشاء الغرفة',)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
