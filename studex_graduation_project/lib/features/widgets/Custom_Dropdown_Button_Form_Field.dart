// dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';

enum DropdownType {
  university,

  major,
  year,
}

class CustomDropdownButtonFormField extends StatefulWidget {
  final DropdownType type;
  final String? hintText;
  final String? labelText;
  final ValueChanged<String?>? onChanged;
  final List<String>? customItems;

  const CustomDropdownButtonFormField({
    super.key,
    required this.type,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.customItems,
  });

  @override
  State<CustomDropdownButtonFormField> createState() => _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState extends State<CustomDropdownButtonFormField> {
  String? _selectedValue;
  late SharedPreferences _prefs;

  static const List<String> majors = [
    'الهندسة المدنية',
    'الهندسة الميكانيكية',
    'الهندسة الكهربائية',
    'الهندسة الإلكترونية',
    'علوم الحاسوب',
    'هندسة البرمجيات',
    'الطب',
    'الصيدلة',
    'طب الأسنان',
    'التمريض',
    'الحقوق',
    'الإدارة العامة',
    'إدارة الأعمال',
    'المحاسبة',
    'الاقتصاد',
    'العلاقات الدولية',
    'الإعلام والصحافة',
    'اللغة العربية',
    'اللغة الإنجليزية',
    'الفلسفة والعلوم الاجتماعية',
    'الرياضيات',
    'الفيزياء',
    'الكيمياء',
    'الأحياء',
    'الزراعة',
    'الطب البيطري',
    'الفنون الجميلة',
    'الموسيقى والفنون',
    'التربية البدنية',
    'الفندقة والسياحة',
    'العمارة',
    'التصميم الداخلي',
    'التعليم الابتدائي',
    'التعليم الاعدادى',
    'التعليم الثانوي',

  ];

  static const List<String> universities = [
    'جامعة القاهرة',
    'جامعة عين شمس',
    'جامعة الإسكندرية',
    'جامعة الأزهر (القاهرة)',
    'جامعة الأزهر (الأقاليم)',
    'جامعة المنصورة',
    'جامعة طنطا',
    'جامعة أسيوط',
    'جامعة سوهاج',
    'جامعة جنوب الوادي',
    'جامعة حلوان',
    'جامعة بنها',
    'جامعة المنوفية',
    'جامعة كفر الشيخ',
    'جامعة بني سويف',
    'جامعة الفيوم',
    'جامعة دمياط',
    'جامعة السويس',
    'جامعة قناة السويس',
    'جامعة بورسعيد',
    'جامعة الوادي الجديد',
    'جامعة الزقازيق',
    'الجامعة الأمريكية بالقاهرة (AUC)',
    'جامعة النيل',
    'الجامعة الألمانية في القاهرة',
    'جامعة 6 أكتوبر',
    'جامعة المستقبل',
    'جامعة سيناء',
    'جامعة الملك سلمان الدولية',
    'جامعة فاروس',
    'الأكاديمية العربية للعلوم والتكنولوجيا والنقل البحري',
    'أكاديمية السادات للعلوم الإدارية',
    'الأكاديمية المصرية للهندسة',
    'أكاديمية الشرطة',
    'الأكاديمية البحرية',
    'أكاديمية البحث العلمي والتكنولوجيا',
    'أكاديمية الفنون',
    'المعهد العالي للهندسة والتكنولوجيا',
    'المعهد العالي للحاسبات والمعلومات',
    'المعهد الفني للتمريض',
    'المعهد العالي للعلوم الإدارية والمالية',
    'المعهد العالي للخدمة الاجتماعية',
    'المعهد العالي للسياحة والفنادق',
    'المعهد العالي للفنون التطبيقية',
    'المعهد العالي لنظم المعلومات',
    'المعهد الفني الصناعي',
    'المعهد القومي لبحوث الصحة',
  ];





  List<String> get years => List.generate(7, (i) => 'الفرقه ${i + 1}');

  String get _prefsKey {
    switch (widget.type) {
      case DropdownType.university:
        return 'selected_university';
      case DropdownType.major:
        return 'selected_major';
      case DropdownType.year:
        return 'selected_year';
    }
  }

  List<String> get _items {
    if (widget.customItems != null && widget.customItems!.isNotEmpty) {
      return widget.customItems!;
    }
    switch (widget.type) {
      case DropdownType.university:
        return universities;
      case DropdownType.major:
        return majors;
      case DropdownType.year:
        return years;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSelected();
  }

  Future<void> _loadSelected() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      final val = _prefs.getString(_prefsKey);
      _selectedValue = _items.contains(val) ? val : null;
    });
  }

  Future<void> _saveSelected(String? value) async {
    if (value != null) {
      await _prefs.setString(_prefsKey, value);
    }
  }

  String _defaultHint() {
    if (widget.hintText != null) return widget.hintText!;
    switch (widget.type) {
      case DropdownType.university:
        return 'اختر الجامعة';
      case DropdownType.major:
        return 'اختر التخصص';
      case DropdownType.year:
        return 'اختر السنة الدراسية';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: AppColors.whiteColor,
      value: _items.contains(_selectedValue) ? _selectedValue : null,
      hint: Text(
        _defaultHint(),
        style: TextStyle(color: AppColors.blackBgColor),
      ),
      items: _items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: AppColors.blackBgColor)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        _saveSelected(newValue);
        widget.onChanged?.call(newValue);
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.greyColor)),
        hintText: _defaultHint(),
        hintStyle: TextStyle(color: AppColors.blackBgColor, fontSize: 20),
        fillColor: AppColors.greyColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.greyColor)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      isExpanded: true,
      style: TextStyle(color: AppColors.blackBgColor, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}