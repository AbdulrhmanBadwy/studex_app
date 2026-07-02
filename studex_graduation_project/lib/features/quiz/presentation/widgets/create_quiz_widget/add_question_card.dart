import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionData {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuestionData({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class AddQuestionCard extends StatefulWidget {
  final int questionNumber;
  final VoidCallback? onDelete;

  const AddQuestionCard({
    super.key,
    required this.questionNumber,
    this.onDelete,
  });

  @override
  AddQuestionCardState createState() => AddQuestionCardState();
}

class AddQuestionCardState extends State<AddQuestionCard> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  int? _correctAnswerIndex;
  String _selectedType = 'اختيار من متعدد';

  static const List<String> _questionTypes = ['اختيار من متعدد', 'صح أو خطأ'];

  QuestionData? getQuestionData() {
    if (_questionController.text.trim().isEmpty) return null;
    if (_correctAnswerIndex == null) return null;

    final options = _selectedType == 'صح أو خطأ'
        ? ['صح', 'خطأ']
        : _optionControllers.map((c) => c.text.trim()).toList();

    if (_selectedType != 'صح أو خطأ' && options.any((o) => o.isEmpty)) {
      return null;
    }

    return QuestionData(
      question: _questionController.text.trim(),
      options: options,
      correctAnswerIndex: _correctAnswerIndex!,
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var c in _optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xffE8ECF4), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffEEF0FF),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'السؤال ${widget.questionNumber}',
                    style: TextStyle(
                      fontFamily: 'AbdoMaster',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff6366F1),
                    ),
                  ),
                ),
                const Spacer(),
                if (widget.onDelete != null)
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade300,
                      size: 20.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            SizedBox(height: 12.h),

            // Question text label
            Text(
              'نص السؤال',
              style: TextStyle(
                fontFamily: 'AbdoMaster',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff0F172A),
              ),
            ),
            SizedBox(height: 6.h),
            TextField(
              controller: _questionController,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'AbdoMaster',
                fontSize: 13.sp,
                color: Colors.black,
              ),
              decoration: _inputDecoration('اكتب السؤال هنا...'),
            ),
            SizedBox(height: 14.h),

            // Question type dropdown
            Text(
              'نوع السؤال',
              style: TextStyle(
                fontFamily: 'AbdoMaster',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff0F172A),
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xffE8ECF4)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedType,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: const Color(0xff94A3B8),
                    size: 20.sp,
                  ),
                  style: TextStyle(
                    fontFamily: 'AbdoMaster',
                    fontSize: 13.sp,
                    color: Colors.black,
                  ),
                  items: _questionTypes
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedType = val);
                  },
                ),
              ),
            ),
            SizedBox(height: 14.h),

            // Options
            Text(
              'خيارات الإجابة الصحيحة',
              style: TextStyle(
                fontFamily: 'AbdoMaster',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff0F172A),
              ),
            ),
            SizedBox(height: 8.h),
            ...List.generate(
              _selectedType == 'صح أو خطأ' ? 2 : 4,
              (index) => _OptionRow(
                index: index,
                controller: _selectedType == 'صح أو خطأ'
                    ? (TextEditingController()
                        ..text = index == 0 ? 'صح' : 'خطأ')
                    : _optionControllers[index],
                isCorrect: _correctAnswerIndex == index,
                onSelect: () => setState(() => _correctAnswerIndex = index),
                isReadOnly: _selectedType == 'صح أو خطأ',
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: 'AbdoMaster',
        fontSize: 13.sp,
        color: const Color(0xff94A3B8),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      filled: true,
      fillColor: const Color(0xffF8FAFC),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xffE8ECF4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xff6366F1)),
      ),
    );
  }
}

// ✅ outside AddQuestionCard class
class _OptionRow extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final bool isCorrect;
  final VoidCallback onSelect;
  final bool isReadOnly;

  const _OptionRow({
    required this.index,
    required this.controller,
    required this.isCorrect,
    required this.onSelect,
    this.isReadOnly = false,
  });

  static const List<String> _labels = ['أ', 'ب', 'ج', 'د'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onSelect,
            child: Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCorrect
                    ? const Color(0xff6366F1)
                    : const Color(0xffE2E8F0),
                border: Border.all(
                  color: isCorrect
                      ? const Color(0xff6366F1)
                      : const Color(0xffCBD5E1),
                ),
              ),
              child: isCorrect
                  ? Icon(Icons.check, color: Colors.white, size: 13.sp)
                  : null,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCorrect
                  ? const Color(0xffEEF0FF)
                  : const Color(0xffF1F5F9),
            ),
            child: Center(
              child: Text(
                _labels[index],
                style: TextStyle(
                  fontFamily: 'AbdoMaster',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: isCorrect
                      ? const Color(0xff6366F1)
                      : const Color(0xff64748B),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: isReadOnly,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'AbdoMaster',
                fontSize: 13.sp,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'أدخل الإجابة',
                hintStyle: TextStyle(
                  fontFamily: 'AbdoMaster',
                  fontSize: 12.sp,
                  color: const Color(0xff94A3B8),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
                filled: true,
                fillColor: isCorrect
                    ? const Color(0xffF0F0FF)
                    : const Color(0xffF8FAFC),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: isCorrect
                        ? const Color(0xff6366F1)
                        : const Color(0xffE8ECF4),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Color(0xff6366F1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
