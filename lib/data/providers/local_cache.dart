import 'dart:convert';

import 'package:json_cache/json_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vstrecha/data/models/analysis.dart';
import 'package:vstrecha/data/models/article.dart';
import 'package:vstrecha/data/models/calendar_event.dart';
import 'package:vstrecha/data/models/hotline.dart';
import 'package:vstrecha/data/models/institution.dart';
import 'package:vstrecha/data/models/library_section.dart';
import 'package:vstrecha/data/models/quiz.id.dart';
import 'package:vstrecha/data/models/quiz_questions_id.dart';
import 'package:vstrecha/data/models/treatment.dart';
import 'package:vstrecha/data/models/user.dart';

class LocalCache {
  const LocalCache();

  Future<void> saveUser(User? user) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    print('User1 : $JsonCache');
    if (user != null) {
      await jsonCache.refresh('User', user.toJson());
    } else {
      await jsonCache.remove('User');
    }
  }

  Future<User?> loadUser() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    print('User2 РАБОТАЕТ ЗДЕСЬ :  $JsonCache     <---------');
    final cachedInfo = await jsonCache.value('User');
    print('Кэшированная инфа $cachedInfo');
    if (cachedInfo != null) {
      return User.fromJson(cachedInfo);
    }
    return null;
  }

  Future<void> saveCalendarEvents(List<CalendarEventItem> events) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    await jsonCache.refresh(
      'CalendarEvents',
      {'items': events.map((e) => e.toJson()).toList()},
    );
  }

  Future<List<CalendarEventItem>> loadCalendarEvents() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    final cachedInfo = await jsonCache.value('CalendarEvents');
    if (cachedInfo != null) {
      return (cachedInfo['items'] as List)
          .map((e) => CalendarEventItem.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<void> saveTreatmentRegimen(List<TreatmentItem> regimen) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    await jsonCache.refresh(
      'TreatmentRegimen',
      {'items': regimen.map((e) => e.toJson()).toList()},
    );
  }

  Future<List<TreatmentItem>> loadTreatmentRegimen() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    final cachedInfo = await jsonCache.value('TreatmentRegimen');
    if (cachedInfo != null) {
      return (cachedInfo['items'] as List)
          .map((e) => TreatmentItem.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<void> saveAnalysisData(List<AnalysisItem> analysis) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    await jsonCache.refresh(
      'AnalysisData',
      {'items': analysis.map((e) => e.toJson()).toList()},
    );
  }

  Future<List<AnalysisItem>> loadAnalysisData() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    final cachedInfo = await jsonCache.value('AnalysisData');
    if (cachedInfo != null) {
      return (cachedInfo['items'] as List)
          .map((e) => AnalysisItem.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<void> saveHotlines(List<Hotline> hotlines) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    await jsonCache.refresh(
      'Hotlines',
      {'items': hotlines.map((e) => e.toJson()).toList()},
    );
  }

  Future<List<Hotline>> loadHotlines() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    final cachedInfo = await jsonCache.value('Hotlines');
    if (cachedInfo != null) {
      return (cachedInfo['items'] as List)
          .map((e) => Hotline.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<void> saveSections(List<LibrarySection> sections) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    await jsonCache.refresh(
      'LibrarySections',
      {'items': sections.map((e) => e.toJson()).toList()},
    );
  }

  Future<List<LibrarySection>> loadSections() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    final cachedInfo = await jsonCache.value('LibrarySections');
    if (cachedInfo != null) {
      return (cachedInfo['items'] as List)
          .map((e) => LibrarySection.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<void> saveArticles(List<Article> articles, int sectionId) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    await jsonCache.refresh(
      'Articles_$sectionId',
      {'items': articles.map((e) => e.toJson()).toList()},
    );
  }

  Future<List<Article>> loadArticles(int sectionId) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    final cachedInfo = await jsonCache.value('Articles_$sectionId');
    if (cachedInfo != null) {
      return (cachedInfo['items'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<void> saveInstitutions(List<Institution> institutions,
      {bool abroad = false}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    await jsonCache.refresh(
      abroad ? 'AbroadInstitutions' : 'Institutions',
      {'items': institutions.map((e) => e.toJson()).toList()},
    );
  }

  Future<List<Institution>> loadInstitutions({bool abroad = false}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    final cachedInfo =
        await jsonCache.value(abroad ? 'AbroadInstitutions' : 'Institutions');
    if (cachedInfo != null) {
      return (cachedInfo['items'] as List)
          .map((e) => Institution.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<void> saveQuiz(QuizId quiz) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString('QuizData', jsonEncode(quiz.toJson()));
  }

  Future<QuizId?> loadQuizId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final quizJson = sharedPrefs.getString('QuizData');
    if (quizJson != null) {
      return QuizId.fromJson(jsonDecode(quizJson));
    }
    return null;
  }

  Future<void> saceQuestionId(
    List<AllQuestion> quizQuestionId,
  ) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    await jsonCache.refresh(
      'questions',
      {'items': quizQuestionId.map((e) => e.toJson()).toList()},
    );
  }

  Future<List<AllQuestion>> loadQuestionsID() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final JsonCache jsonCache =
        JsonCacheMem(JsonCacheSharedPreferences(sharedPrefs));
    final cachedInfo = await jsonCache.value('questions');
    if (cachedInfo != null) {
      return (cachedInfo['items'] as List)
          .map((e) => AllQuestion.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<void> saveQuizId(int id) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.remove('id');
    await sharedPrefs.setInt('id', id);
  }

  Future<int?> loadedQuizId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getInt('id');
  }
}
