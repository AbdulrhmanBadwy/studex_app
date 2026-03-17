import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';

class CustomDropdownButtonFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownButtonFormField({
    super.key,
    this.hintText = 'اختر التخصص',
    this.labelText = 'التخصص',
    this.onChanged,
  });

  @override
  State<CustomDropdownButtonFormField> createState() => _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState extends State<CustomDropdownButtonFormField> {
  String? _selectedMajor;
  late SharedPreferences _prefs;

  // قائمة التخصصات الجامعية
  static const List<String> collegeMajors = [
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
    'التعليم الابتدائي',
    'التعليم الثانوي',
    'الفندقة والسياحة',
    'العمارة',
    'التصميم الداخلي',
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedMajor();
  }

  Future<void> _loadSelectedMajor() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedMajor = _prefs.getString('selected_major');
    });
  }

  Future<void> _saveMajor(String? major) async {
    if (major != null) {
      await _prefs.setString('selected_major', major);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: collegeMajors.contains(_selectedMajor) ? _selectedMajor : null,
      hint: Text(
        widget.hintText ?? 'اختر التخصص',
        style: TextStyle(color: AppColors.blackHeadLine),
      ),
      items: collegeMajors.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: AppColors.blackHeadLine),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedMajor = newValue;
          });
          _saveMajor(newValue);
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        }
      },
      decoration: InputDecoration(
        focusColor:AppColors.whiteColor ,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.blackHeadLine,fontSize: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      isExpanded: true,
      style: TextStyle(color: AppColors.blackHeadLine),
    );
  }
}
