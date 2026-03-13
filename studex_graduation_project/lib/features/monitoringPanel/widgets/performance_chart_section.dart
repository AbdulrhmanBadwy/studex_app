import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';

class PerformanceChartSection extends StatefulWidget {
  const PerformanceChartSection({super.key});

  @override
  State<PerformanceChartSection> createState() => _PerformanceChartSectionState();
}

class _PerformanceChartSectionState extends State<PerformanceChartSection> {
  String selected = 'اخر شهر';
  static const List<String> options = ['اخر سنة', 'اخر 6 شهور', 'اخر شهر'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selected,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    borderRadius: BorderRadius.circular(12.r),
                    items: options.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selected = value);
                      }
                    },
                  ),
                ),
                Text('تطور الأداء', style: AppStyles.bold16black),
              ],
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}