import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studex_graduation_project/features/quiz/data/data_source/quiz_remote_data_source.dart';
import 'package:studex_graduation_project/features/quiz/data/models/quiz_model.dart';
import 'package:studex_graduation_project/features/quiz/data/models/quiz_result_model.dart';

class RemoteDataSourceImpl implements QuizRemoteDataSource {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Future<void> createQuiz(QuizModel quiz, String roomId) async {
    await fireStore
        .collection('rooms')
        .doc(roomId)
        .collection('quizzes')
        .doc(quiz.id)
        .set({
          ...quiz.toJson(),
          'roomId': roomId,
          'createdAt': FieldValue.serverTimestamp(),
          'resultsCount': 0,
        });
  }

  @override
  Future<QuizModel?> getQuizById(String roomId, String quizId) {
    return fireStore
        .collection('rooms')
        .doc(roomId)
        .collection('quizzes')
        .doc(quizId)
        .get()
        .then((doc) {
          if (doc.exists && doc.data() != null) {
            return QuizModel.fromJson(doc.data()!);
          }
          return null;
        })
        .catchError((error) {
          throw Exception(error);
        });
  }

  @override
  Stream<List<QuizModel>> getQuizzes(String roomId) {
    return fireStore
        .collection('rooms')
        .doc(roomId)
        .collection('quizzes')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => QuizModel.fromJson(doc.data()))
              .toList();
        });
  }

  @override
  @override
  Future<QuizResultModel?> getQuizResult(
    String roomId,
    String quizId,
    String userId,
  ) {
    return fireStore
        .collection('rooms')
        .doc(roomId)
        .collection('quizzes')
        .doc(quizId)
        .collection('results')
        .doc(userId)
        .get()
        .then((doc) {
          if (doc.exists && doc.data() != null) {
            return QuizResultModel.fromJson(doc.data()!);
          }
          return null;
        })
        .catchError((error) {
          throw Exception(error);
        });
  }

  @override
  Future<void> submitQuizAnswers(
    String roomId,
    String quizId,
    String userId,
    List<int> answers,
    int score,
  ) {
    final quizRef = fireStore
        .collection('rooms')
        .doc(roomId)
        .collection('quizzes')
        .doc(quizId);
    final resultRef = quizRef.collection('results').doc(userId);

    return fireStore
        .runTransaction((transaction) async {
          final existingResult = await transaction.get(resultRef);
          if (existingResult.exists) {
            return;
          }

          transaction.set(resultRef, {
            'userId': userId,
            'quizId': quizId,
            'answers': answers,
            'score': score,
            'totalQuestions': answers.length,
            'submittedAt': FieldValue.serverTimestamp(),
          });
          transaction.update(quizRef, {
            'resultsCount': FieldValue.increment(1),
          });
        })
        .catchError((error) {
          throw Exception(error);
        });
  }
}
