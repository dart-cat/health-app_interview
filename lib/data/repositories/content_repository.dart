import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vstrecha/data/models/article.dart';

import 'package:vstrecha/data/models/library_section.dart';
import 'package:vstrecha/data/providers/api.dart';
import 'package:vstrecha/data/providers/local_cache.dart';

class ContentRepository {
  ContentRepository._privateConstructor();

  static final ContentRepository instance = ContentRepository._privateConstructor();

  late API api;
  late LocalCache cache;

  void init() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    api = API(dio);
    cache = const LocalCache();
  }

  Future<List<LibrarySection>> getSections() async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Fetch sections
      final sections = await api.getLibrarySections();

      // Save to cache and return results
      await cache.saveSections(sections.data);
      return sections.data;
    } catch (_) {
      return await cache.loadSections();
    }
  }

  Future<List<Article>> getArticles(int sectionId) async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Fetch sections
      final articles = await api.getArticles(sectionId);

      // Save to cache and return results
      await cache.saveArticles(articles.data, sectionId);
      return articles.data;
    } catch (_) {
      return await cache.loadArticles(sectionId);
    }
  }
}
