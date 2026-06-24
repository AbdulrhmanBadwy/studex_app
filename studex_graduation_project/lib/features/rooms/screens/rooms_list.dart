import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/features/chat/presentation/screens/chat_screen.dart';

import '../../../core/routes/app_routes.dart';
import '../widgets/custom_floating_action_button.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/room_card.dart';

class RoomsListScreen extends StatelessWidget {
  const RoomsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: _buildAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomSearchBar(),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {


                        context.go(AppRoutes.roomChatScreen);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RoomChatScreen(roomId: 'room1'),//pass the actual room id here
                          ),
                        );
                      },
                      child: const RoomCard(
                        title: "هندسة برمجيات 1",
                        category: "برمجيات",
                        description:
                        "مناقشة المحاضرة الثالثة والتحضير للمشروع الفصلي",
                        memberCount: "+15",
                        tag: "خاص",
                        tagColor: Color(0xffEEF0FF),
                        status: "نشط منذ 5 دقائق",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
      leading: _iconBox(Icons.notifications_none),
    );
  }

  Widget _iconBox(IconData icon) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xffEEF0FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: const Color(0xff6A6EF6), size: 22),
    );
  }
}