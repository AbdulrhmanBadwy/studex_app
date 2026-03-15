import 'package:flutter/material.dart';

class RecentChatsList extends StatelessWidget {
  const RecentChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xffE0E4FF),
          ),
          title: const Text(
            "جروب لغات صورية الفرقة التالته",
            style: TextStyle(fontWeight: FontWeight.bold ,fontFamily: 'AbdoMaster'),
          ),
          subtitle: const Text(
            "هل أكملت مراجعة الفصل الثالث؟",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("10:45", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}
