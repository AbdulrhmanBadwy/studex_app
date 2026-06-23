import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';

class CustomButtonNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomButtonNavBar({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xff6A6EF6),
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(AppRoutes.homeScreen);
            break;
          case 1:
            context.go(AppRoutes.roomListScreen);
            break;
          case 2:
            context.go(AppRoutes.monitoringPanel);
            break;
          case 3:
            context.go(AppRoutes.settingsScreen);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: "الرئيسية",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups_rounded),
          label: "الغرف",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_rounded),
          label: "لوحة المتابعة",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
      ],
    );
  }
}
