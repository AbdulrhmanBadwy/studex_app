class QuestionEntity {
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  QuestionEntity({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}
