import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';

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
        child: Column(children: [DashboardSection(),
          ExamGradesSection(),
          PerformanceChartSection(),

        ]),
      ),
      backgroundColor: AppColors.whiteBgColor,
    );
  }
}
