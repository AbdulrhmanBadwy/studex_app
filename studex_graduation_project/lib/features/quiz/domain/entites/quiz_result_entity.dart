class QuizResultEntity {
  final String userId;
  final String quizId;
  final int score;
  final int totalQuestions;
  final List<int> answers;

  const QuizResultEntity({
    required this.userId,
    required this.quizId,
    required this.score,
    required this.totalQuestions,
    required this.answers,
  });
}