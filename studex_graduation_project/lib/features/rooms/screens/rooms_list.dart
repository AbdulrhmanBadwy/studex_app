import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/services/auth_service.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/models/room_model.dart';
import 'package:studex_graduation_project/repositories/room_repository.dart';

import '../widgets/custom_floating_action_button.dart';
import '../widgets/room_card.dart';

class RoomsListScreen extends StatefulWidget {
  const RoomsListScreen({super.key});

  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {
  final RoomRepository _roomRepository = FirestoreRoomRepository();
  late final Stream<List<RoomModel>> _roomsStream = _roomRepository.getRooms();

  void _openChat(RoomModel room) {
    if (room.id.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Missing room id.')));
      return;
    }

    try {
      context.pushNamed(
        AppRoutes.roomChatScreen,
        extra: {'roomId': room.id, 'roomName': room.name},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open chat. ${e.toString()}')),
      );
    }
  }

  Future<void> _joinRoom(RoomModel room) async {
    final currentUser = AuthService.instance.currentUser;
    if (room.id.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Missing room id.')));
      return;
    }
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be signed in to join rooms.')),
      );
      return;
    }

    try {
      await _roomRepository.joinRoom(room.id, currentUser.uid);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Joined successfully')));
      _openChat(room);
    } on StateError catch (e) {
      if (!mounted) return;
      if (e.message == 'Room does not exist.') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Room no longer exists')));
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } on ArgumentError catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to join room. ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: _buildAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: StreamBuilder<List<RoomModel>>(
          stream: _roomsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Unable to load rooms.',
                  style: TextStyle(color: Colors.red.shade700),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final rooms = snapshot.data ?? const <RoomModel>[];
            if (rooms.isEmpty) {
              return const Center(child: Text('No rooms available'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                final isJoined =
                    currentUser != null &&
                    room.members.contains(currentUser.uid);
                return RoomCard(
                  title: room.name,
                  description: room.description,
                  buttonText: isJoined ? 'Already Joined' : 'Join',
                  buttonEnabled: !isJoined,
                  onCardTap: isJoined ? () => _openChat(room) : null,
                  onJoinPressed: () => _joinRoom(room),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: CustomFAB(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        "غرف الدراسة",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
