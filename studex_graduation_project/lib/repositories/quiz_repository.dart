import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz_model.dart';
import '../models/question_model.dart';
import '../models/quiz_attempt_model.dart';

abstract class QuizRepository {
  Stream<List<QuizModel>> getQuizzes();
  Future<void> createQuiz(QuizModel quiz, List<QuestionModel> questions);
  Future<QuizModel?> getQuizById(String quizId);
  Future<List<QuestionModel>> getQuestions(String quizId);
  Future<void> saveAttempt(QuizAttemptModel attempt);
  Future<bool> hasAttempted(String quizId, String userId);
}

class FirestoreQuizRepository implements QuizRepository {
  final FirebaseFirestore _firestore;

  FirestoreQuizRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _quizzesCollection =>
      _firestore.collection('quizzes');

  CollectionReference<Map<String, dynamic>> _questionsCollection(String quizId) =>
      _quizzesCollection.doc(quizId).collection('questions');

  CollectionReference<Map<String, dynamic>> get _attemptsCollection =>
      _firestore.collection('quiz_attempts');

  @override
  Stream<List<QuizModel>> getQuizzes() {
    return _quizzesCollection
        .where('isPublished', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => QuizModel.fromJson(doc.data())).toList());
  }

  @override
  Future<void> createQuiz(QuizModel quiz, List<QuestionModel> questions) async {
    final batch = _firestore.batch();
    batch.set(_quizzesCollection.doc(quiz.id), quiz.toJson());
    for (final q in questions) {
      batch.set(_questionsCollection(quiz.id).doc(q.id), q.toJson());
    }

    await batch.commit();
  }

  @override
  Future<QuizModel?> getQuizById(String quizId) async {
    final doc = await _quizzesCollection.doc(quizId).get();
    if (doc.exists && doc.data() != null) {
      return QuizModel.fromJson(doc.data()!);
    }
    return null;
  }

  @override
  Future<List<QuestionModel>> getQuestions(String quizId) async {
    final snapshot = await _questionsCollection(quizId).get();
    return snapshot.docs
        .map((doc) => QuestionModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> saveAttempt(QuizAttemptModel attempt) async {
    await _attemptsCollection.doc(attempt.id).set(attempt.toJson());
  }

  @override
  Future<bool> hasAttempted(String quizId, String userId) async {
    final snapshot = await _attemptsCollection
        .where('quizId', isEqualTo: quizId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty;
  }
}