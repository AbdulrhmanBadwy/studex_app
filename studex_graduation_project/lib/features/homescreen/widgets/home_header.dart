import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_cubit.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_state.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final currentUser = state.currentUser;
        final userName =
            currentUser != null && currentUser.name.trim().isNotEmpty
            ? currentUser.name.trim()
            : 'أحمد';

        return Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "أهلاً بك مجدداً",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "مرحباً، $userName",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            _headerIcon(Icons.search),
            const SizedBox(width: 10),
            _headerIcon(Icons.notifications_none_outlined),
          ],
        );
      },
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
