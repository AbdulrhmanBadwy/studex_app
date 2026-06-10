import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a user's attempt at a quiz.
class QuizAttemptModel {
  final String id;
  final String quizId;
  final String userId;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final int score;
  final int totalCorrect;
  final int totalQuestions;
  final int? durationSeconds;
  final Map<String, dynamic>? answers;
  final DateTime? createdAt;

  const QuizAttemptModel({
    required this.id,
    required this.quizId,
    required this.userId,
    this.startedAt,
    this.finishedAt,
    required this.score,
    required this.totalCorrect,
    required this.totalQuestions,
    this.durationSeconds,
    this.answers,
    this.createdAt,
  });

  QuizAttemptModel copyWith({
    String? id,
    String? quizId,
    String? userId,
    DateTime? startedAt,
    DateTime? finishedAt,
    int? score,
    int? totalCorrect,
    int? totalQuestions,
    int? durationSeconds,
    Map<String, dynamic>? answers,
    DateTime? createdAt,
  }) {
    return QuizAttemptModel(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      score: score ?? this.score,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      answers: answers ?? this.answers,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static DateTime? _parseTimestamp(dynamic v) {
    if (v == null) return null;
    if (v is Timestamp) return v.toDate();
    if (v is DateTime) return v;
    if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
    if (v is String) return DateTime.tryParse(v);
    return null;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'quizId': quizId,
        'userId': userId,
        if (startedAt != null) 'startedAt': Timestamp.fromDate(startedAt!),
        if (finishedAt != null) 'finishedAt': Timestamp.fromDate(finishedAt!),
        'score': score,
        'totalCorrect': totalCorrect,
        'totalQuestions': totalQuestions,
        if (durationSeconds != null) 'durationSeconds': durationSeconds,
        if (answers != null) 'answers': answers,
        if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
      };

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) {
    return QuizAttemptModel(
      id: json['id'] as String? ?? '',
      quizId: json['quizId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      startedAt: _parseTimestamp(json['startedAt']),
      finishedAt: _parseTimestamp(json['finishedAt']),
      score: json['score'] as int? ?? 0,
      totalCorrect: json['totalCorrect'] as int? ?? 0,
      totalQuestions: json['totalQuestions'] as int? ?? 0,
      durationSeconds: json['durationSeconds'] as int?,
      answers: (json['answers'] as Map?)?.cast<String, dynamic>(),
      createdAt: _parseTimestamp(json['createdAt']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizAttemptModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          quizId == other.quizId &&
          userId == other.userId &&
          startedAt == other.startedAt &&
          finishedAt == other.finishedAt &&
          score == other.score &&
          totalCorrect == other.totalCorrect &&
          totalQuestions == other.totalQuestions &&
          durationSeconds == other.durationSeconds &&
          _mapEquals(answers, other.answers) &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      quizId.hashCode ^
      userId.hashCode ^
      (startedAt?.hashCode ?? 0) ^
      (finishedAt?.hashCode ?? 0) ^
      score.hashCode ^
      totalCorrect.hashCode ^
      totalQuestions.hashCode ^
      (durationSeconds?.hashCode ?? 0) ^
      (answers?.hashCode ?? 0) ^
      (createdAt?.hashCode ?? 0);
}

bool _mapEquals(Map? a, Map? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  for (final key in a.keys) {
    if (!b.containsKey(key) || a[key] != b[key]) return false;
  }
  return true;
}
