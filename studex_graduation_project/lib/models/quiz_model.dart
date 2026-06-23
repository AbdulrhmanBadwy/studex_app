import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  final String id;
  final String title;
  final String description;
  final int timePerQuestion;
  final String creatorId;
  final bool isPublished;
  final int totalMarks;
  final DateTime? createdAt;

  const QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timePerQuestion,
    required this.creatorId,
    this.isPublished = false,
    this.totalMarks = 0,
    this.createdAt,
  });

  QuizModel copyWith({
    String? id,
    String? title,
    String? description,
    int? timePerQuestion,
    String? creatorId,
    bool? isPublished,
    int? totalMarks,
    DateTime? createdAt,
  }) {
    return QuizModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timePerQuestion: timePerQuestion ?? this.timePerQuestion,
      creatorId: creatorId ?? this.creatorId,
      isPublished: isPublished ?? this.isPublished,
      totalMarks: totalMarks ?? this.totalMarks,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timePerQuestion': timePerQuestion,
      'creatorId': creatorId,
      'isPublished': isPublished,
      'totalMarks': totalMarks,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      if (v is Timestamp) return v.toDate();
      if (v is DateTime) return v;
      return null;
    }

    return QuizModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      timePerQuestion: json['timePerQuestion'] as int? ?? 30,
      creatorId: json['creatorId'] as String? ?? '',
      isPublished: json['isPublished'] as bool? ?? false,
      totalMarks: json['totalMarks'] as int? ?? 0,
      createdAt: parseDate(json['createdAt']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is QuizModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}