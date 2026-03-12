import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/features/settings/widgets/custom_headline_settings.dart';
import 'package:studex_graduation_project/features/settings/widgets/custom_item_in_settings.dart';
import 'package:studex_graduation_project/features/settings/widgets/custom_item_notication.dart';
import 'package:studex_graduation_project/features/settings/widgets/custom_language_item.dart';

import '../../core/widgets/spacing.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isChatEnabled = true;
  bool isQuizEnabled = true;
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeadlineSettings(title: 'الإعدادات'),
                HeightSpacing(5),
                Divider(),
                HeightSpacing(24),
                Text(
                  'الحساب',
                  style: AppStyles.primaryHeadlineStyle.copyWith(
                    color: AppColors.primaryAllColor,
                    fontSize: 18.sp,
                  ),
                ),
                HeightSpacing(8.5),
                CustomItemInSettings(
                  title: 'تعديل الملف الشخصي ',
                  icon: AssetsPaths.personSettings,
                  trailingIcon: Icons.arrow_forward_ios_outlined,
                ),
                HeightSpacing(10),
                CustomItemInSettings(
                  title: 'تغيير كلمة المرور ',
                  icon: AssetsPaths.changePasswordSettings,
                  trailingIcon: Icons.arrow_forward_ios_outlined,
                ),

                HeightSpacing(32),
                Text(
                  'الإشعارات',
                  style: AppStyles.primaryHeadlineStyle.copyWith(
                    color: AppColors.primaryAllColor,
                    fontSize: 18.sp,
                  ),
                ),
                HeightSpacing(8.5),
                CustomItemNotification(
                  title: 'تنبيهات المحادثات',
                  icon: AssetsPaths.chatNotificationsSettings,
                  isSwitched: isChatEnabled,
                  onTypeChanged: (value) {
                    setState(() {
                      isChatEnabled = value;
                    });
                  },
                ),
                HeightSpacing(10),
                CustomItemNotification(
                  title: 'تنبيهات الإختبارات',
                  icon: AssetsPaths.chatNotificationsSettings,
                  isSwitched: isQuizEnabled,
                  onTypeChanged: (value) {
                    setState(() {
                      isQuizEnabled = value;
                    });
                  },
                ),
                HeightSpacing(32),
                Text(
                  'المظهر',
                  style: AppStyles.primaryHeadlineStyle.copyWith(
                    color: AppColors.primaryAllColor,
                    fontSize: 18.sp,
                  ),
                ),
                HeightSpacing(8.5),
                CustomItemNotification(
                  title: 'الوضع الداكن',
                  icon: AssetsPaths.darkMode,
                  isSwitched: isDarkMode,
                  onTypeChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
                HeightSpacing(10),
                CustomLanguageItem(
                  title: 'لغة التطبيق',
                  icon: AssetsPaths.appLanguage,
                  currentLanguage: 'العربية',
                  onTap: () {},
                ),
                HeightSpacing(32),
                Text(
                  'المظهر',
                  style: AppStyles.primaryHeadlineStyle.copyWith(
                    color: AppColors.primaryAllColor,
                    fontSize: 18.sp,
                  ),
                ),
                HeightSpacing(8.5),
                CustomItemInSettings(
                  title: 'مركز المساعده',
                  icon: AssetsPaths.centerHelping,
                  trailingIcon: Icons.arrow_forward_ios_outlined,
                ),
                HeightSpacing(10),
                CustomItemInSettings(
                  title: 'سياسة الخصوصية',
                  icon: AssetsPaths.privacyPolitical,
                  trailingIcon: Icons.arrow_forward_ios_outlined,
                ),
                HeightSpacing(20)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
