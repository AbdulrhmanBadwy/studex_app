import 'package:flutter/material.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/study_room_card.dart';

class StudyRoomsGrid extends StatelessWidget {
  const StudyRoomsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.85,
      children: const [
        StudyRoomCard(
          title: "هندسة برمجيات",
          count: "12 طالب",
          imageColor: Color(0xff0D3B3F),
        ),
        StudyRoomCard(
          title: "تحليل بيانات",
          count: "8 طلاب",
          imageColor: Color(0xffC4D7D1),
        ),
      ],
    );
  }
}
