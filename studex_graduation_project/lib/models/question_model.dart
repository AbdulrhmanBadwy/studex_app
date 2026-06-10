class QuestionModel {
  final String id;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final double marks;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  QuestionModel({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    required this.marks,
    this.createdAt,
    this.updatedAt,
  });

  QuestionModel copyWith({
    String? id,
    String? text,
    List<String>? options,
    int? correctOptionIndex,
    double? marks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      text: text ?? this.text,
      options: options ?? List<String>.from(this.options),
      correctOptionIndex: correctOptionIndex ?? this.correctOptionIndex,
      marks: marks ?? this.marks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      return null;
    }

    final optionsRaw = json['options'];
    List<String> optionsList = <String>[];
    if (optionsRaw is List) {
      optionsList = optionsRaw.map((e) => e?.toString() ?? '').cast<String>().toList();
    }

    return QuestionModel(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      options: optionsList,
      correctOptionIndex: (json['correctOptionIndex'] is int)
          ? json['correctOptionIndex'] as int
          : int.tryParse(json['correctOptionIndex']?.toString() ?? '') ?? 0,
      marks: (json['marks'] is num) ? (json['marks'] as num).toDouble() : double.tryParse(json['marks']?.toString() ?? '0') ?? 0.0,
      createdAt: parseDate(json['createdAt'] ?? json['created_at']),
      updatedAt: parseDate(json['updatedAt'] ?? json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    Object? dateToJson(DateTime? d) => d?.toIso8601String();

    return {
      'id': id,
      'text': text,
      'options': List<String>.from(options),
      'correctOptionIndex': correctOptionIndex,
      'marks': marks,
      'createdAt': dateToJson(createdAt),
      'updatedAt': dateToJson(updatedAt),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is QuestionModel &&
        other.id == id &&
        other.text == text &&
        _listEquals(other.options, options) &&
        other.correctOptionIndex == correctOptionIndex &&
        other.marks == marks &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  bool _listEquals(List? a, List? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      text,
      Object.hashAll(options),
      correctOptionIndex,
      marks,
      createdAt?.millisecondsSinceEpoch,
      updatedAt?.millisecondsSinceEpoch,
    );
  }

  @override
  String toString() {
    return 'QuestionModel(id: $id, text: $text, options: $options, correctOptionIndex: $correctOptionIndex, marks: $marks, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
