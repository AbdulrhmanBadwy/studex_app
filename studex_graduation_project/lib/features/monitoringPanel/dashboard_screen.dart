import 'package:flutter/material.dart';

import 'package:studex_graduation_project/features/monitoringPanel/widgets/app_bar.dart';
import 'package:studex_graduation_project/features/monitoringPanel/widgets/exam_grade_section.dart';
import 'package:studex_graduation_project/features/monitoringPanel/widgets/dashboard_items_section.dart';
import 'package:studex_graduation_project/features/monitoringPanel/widgets/performance_chart_section.dart';

class MonitoringPanelScreen extends StatelessWidget {
  const MonitoringPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        onProfileTap: () {},
        onNotificationTap: () {},
        onMenuTap: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DashboardSection(),
            ExamGradesSection(),
            PerformanceChartSection(),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF8F9FF),
    );
  }
}
