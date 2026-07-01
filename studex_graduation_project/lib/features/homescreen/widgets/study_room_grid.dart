import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_cubit.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_state.dart';
import 'package:studex_graduation_project/features/homescreen/widgets/study_room_card.dart';

class StudyRoomsGrid extends StatelessWidget {
  const StudyRoomsGrid({super.key});

  Color _colorForIndex(int index) {
    switch (index) {
      case 0:
        return const Color(0xff0D3B3F);
      case 1:
        return const Color(0xffC4D7D1);
      default:
        return const Color(0xffE0E4FF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.roomsStatus == HomeSectionStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.roomsStatus == HomeSectionStatus.error) {
          return Text(
            state.roomsErrorMessage ?? 'Unable to load rooms.',
            style: const TextStyle(color: Colors.red),
          );
        }

        final rooms = state.availableRooms.take(2).toList();
        if (rooms.isEmpty) {
          return const Text('No rooms available');
        }

        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.85,
          children: List.generate(rooms.length, (index) {
            final room = rooms[index];
            final memberCount = room.members.length;
            return StudyRoomCard(
              title: room.name,
              count: '$memberCount طالب',
              imageColor: _colorForIndex(index),
              roomId: room.id,
            );
          }),
        );
      },
    );
  }
}
