import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import 'package:studex_graduation_project/features/quiz/data/data_source/quiz_remote_data_source.dart';
import 'package:studex_graduation_project/features/quiz/data/data_source/quiz_remote_data_source_impl.dart';

import 'package:studex_graduation_project/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:studex_graduation_project/features/quiz/domain/repositres/quiz_repository.dart';
import 'package:studex_graduation_project/features/quiz/domain/use_cases/create_quiz_use_case.dart';

import 'package:studex_graduation_project/features/quiz/domain/use_cases/get_quiz_by_id.dart';

import 'package:studex_graduation_project/features/quiz/domain/use_cases/get_quizzes.dart';
import 'package:studex_graduation_project/features/quiz/domain/use_cases/submit_quiz_answer.dart';

import 'package:studex_graduation_project/features/quiz/presentation/cubits/create_quiz/create_quiz_cubit.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/get_quizzes/get_quizes_cubit.dart';
import 'package:studex_graduation_project/features/quiz/presentation/cubits/submit_cubit/submit_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<QuizRemoteDataSource>(() => RemoteDataSourceImpl());

  sl.registerLazySingleton<QuizRepository>(() => QuizRepositoryImpl(sl()));

  sl.registerLazySingleton(() => CreateQuizUseCase(sl()));
  sl.registerLazySingleton(() => GetQuizzes(sl()));
  sl.registerLazySingleton(() => GetQuizById(sl()));
  sl.registerLazySingleton(() => SubmitQuizAnswers(sl()));
  sl.registerFactory(() => GetQuizzesCubit(sl()));

  sl.registerFactory(() => CreateQuizCubit(sl()));
  sl.registerFactory<SubmitQuizCubit>(() => SubmitQuizCubit(sl()));
}
