import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/features/widgets/dashboard_item.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({super.key});

  static const _items = [
    _MonitoringData(
      icon: Icons.people_alt_rounded,
      title: 'الغرف المنضمة',
      iconColor: Color(0xFF2563EB),
      bgColor: Color(0xFFDBEAFE),
      subTitle: '43',
    ),
    _MonitoringData(
      icon: Icons.quiz_outlined,
      title: 'الاختبارات المكتملة',
      iconColor: Color(0xFFD97706),
      bgColor: Color(0xFFFEF3C7),
      subTitle: '20',
    ),
    _MonitoringData(
      icon: Icons.analytics_outlined,
      title: 'متوسط الدرجات',
      iconColor: Color(0xFF6366F1),
      bgColor: Color(0xFFEDE9FE),
      subTitle: '25',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          itemBuilder: (context, i) => MonitoringItem(
            icon: _items[i].icon,
            title: _items[i].title,
            subtitle: _items[i].subTitle,
            iconColor: _items[i].iconColor,
            backgroundColor: _items[i].bgColor,
          ),
        ),
      ],
    );
  }
}

class _MonitoringData {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color bgColor;
  final String subTitle;

  const _MonitoringData({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.bgColor,
    required this.subTitle,
  });
}
