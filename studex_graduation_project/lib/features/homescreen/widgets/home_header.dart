import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            'https://via.placeholder.com/150',
          ), // حط صورتك هنا
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "أهلاً بك مجدداً",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              "مرحباً، أحمد",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),
        _headerIcon(Icons.search),
        const SizedBox(width: 10),
        _headerIcon(Icons.notifications_none_outlined),
      ],
    );
  }

  Widget _headerIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Icon(icon, size: 24, color: Colors.black87),
    );
  }
}
