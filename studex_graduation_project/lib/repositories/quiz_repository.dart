import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz_model.dart';

abstract class QuizRepository {
  Stream<List<QuizModel>> getQuizzes();
  Future<void> createQuiz(QuizModel quiz);
  Future<QuizModel?> getQuizById(String quizId);
}

class FirestoreQuizRepository implements QuizRepository {
  final FirebaseFirestore _firestore;

  FirestoreQuizRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _quizzesCollection =>
      _firestore.collection('quizzes');

  @override
  Stream<List<QuizModel>> getQuizzes() {
    return _quizzesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => QuizModel.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<void> createQuiz(QuizModel quiz) async {
    await _quizzesCollection.doc(quiz.id).set(quiz.toJson());
  }

  @override
  Future<QuizModel?> getQuizById(String quizId) async {
    final doc = await _quizzesCollection.doc(quizId).get();
    if (doc.exists && doc.data() != null) {
      return QuizModel.fromJson(doc.data()!);
    }
    return null;
  }
}
