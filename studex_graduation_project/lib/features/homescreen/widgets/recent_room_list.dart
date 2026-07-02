import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_cubit.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_state.dart';
import 'package:studex_graduation_project/models/room_model.dart';

class RecentChatsList extends StatelessWidget {
  const RecentChatsList({super.key});

  String formatChatTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    final now = DateTime.now();
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return DateFormat('HH:mm').format(dateTime);
    }

    if (date == yesterday) {
      return 'أمس';
    }

    return DateFormat('d/M').format(dateTime);
  }

  void _openChat(BuildContext context, RoomModel room) {
    if (room.id.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Missing room id.')));
      return;
    }

    context.pushNamed(
      AppRoutes.roomChatScreen,
      extra: {'roomId': room.id, 'roomName': room.name},
    );
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
            state.roomsErrorMessage ?? 'Unable to load recent chats.',
            style: const TextStyle(color: Colors.red),
          );
        }

        if (state.joinedRooms.isEmpty) {
          return const Text('No rooms available');
        }

        final rooms = state.joinedRooms.take(4).toList();
        if (rooms.isEmpty) {
          return const Text('No rooms available');
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rooms.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final room = rooms[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => _openChat(context, room),
              leading: const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xffE0E4FF),
              ),
              title: Text(
                room.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AbdoMaster',
                ),
              ),
              subtitle: Text(
                room.lastMessage ?? 'لا توجد رسائل بعد',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatChatTime(room.lastMessageAt),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
