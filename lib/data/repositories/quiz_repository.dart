import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vstrecha/data/models/quiz.id.dart';
import 'package:vstrecha/data/models/quiz_questions_id.dart';
import 'package:vstrecha/data/providers/api.dart';
import 'package:vstrecha/data/providers/local_cache.dart';

import 'auth_repository.dart';

class QuizRepository {
  QuizRepository._privateConstructor();

  static final QuizRepository instance = QuizRepository._privateConstructor();

  late API api;
  late LocalCache cache;

  void init() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    api = API(dio);
    cache = const LocalCache();
  }

  Future<QuizId?> getQuiz() async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        throw Exception('No internet');
      }

      final user = await AuthRepository.instance.getUser();
      final quiz = await api.getQuiz(user!.id);

      // Save to cache and return results
      await cache.saveQuiz(quiz);
      return quiz;
    } catch (_) {
      // Fetch from cache when no internet connection
      return await cache.loadQuizId();
    }
  }

  Future<List<AllQuestion>> getQuizQuestions() async {
    try {
      // Check internet connection

      final result = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        throw Exception('No internet');
      }

      final user = await AuthRepository.instance.getUser();
      final pull = await getQuiz();
      final quiz = await api.getQuizQuestions(user!.id, pull!.data!.id ?? 0);
      final id = quiz.data.allQuestions;
      // Save to cache and return results
      await cache.saceQuestionId(id);
      return quiz.data.allQuestions;
    } catch (_) {
      // Fetch from cache when no internet connection
      return await cache.loadQuestionsID();
    }
  }

  Future<void> postQuiz(int answerId) async {
    final getuserId = await AuthRepository.instance.getUser();
    final getpullId = await getQuiz();
    final getquestionId = await getQuizQuestions();
    final pullId = getpullId?.data?.id;
    final userId = getuserId?.id;
    final questionId = getquestionId[0].id;
    final answerId = await cache.loadedQuizId();
    await api.postQuiz(pullId!, questionId!, answerId!, userId!);
    print('--------> pullId $pullId , userId $userId , questionId $questionId , answerId $answerId');

  }
}
