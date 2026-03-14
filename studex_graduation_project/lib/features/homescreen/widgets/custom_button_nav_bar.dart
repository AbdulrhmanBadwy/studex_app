import 'package:flutter/material.dart';

class CustomButtonNavBar extends StatelessWidget {
  const CustomButtonNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xff6A6EF6),
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
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
