import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uuid/uuid.dart';
import 'package:vstrecha/data/models/analysis.dart';
import 'package:vstrecha/data/providers/api.dart';
import 'package:vstrecha/data/providers/local_cache.dart';
import 'package:vstrecha/data/repositories/auth_repository.dart';

class AnalysesRepository {
  AnalysesRepository._privateConstructor();

  static final AnalysesRepository instance = AnalysesRepository._privateConstructor();

  late API api;
  late LocalCache cache;
  Uuid uuid = const Uuid();

  void init() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
    ));
    api = API(dio);
    cache = const LocalCache();
  }

  Future<List<AnalysisItem>> getAnalyses() async {
    try {
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch analyses and map them to List<AnalysisItem>
      final response = await api.getAnalyses(user.id);
      final analyses = response.data
          .map((item) => AnalysisItem(id: item.id, path: item.link, date: DateTime.parse(item.date)))
          .toList();

      // Update cache and return the results
      await cache.saveAnalysisData(analyses);
      return analyses;
    } catch (_) {
      // Read cache if no internet
      return await cache.loadAnalysisData();
    }
  }

  Future<List<AnalysisItem>> addAnalysis(AnalysisItem analysis) async {
    try {
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch analyses and map them to List<AnalysisItem>
      var response = await api.getAnalyses(user.id);
      var analyses = response.data
          .map((item) => AnalysisItem(id: item.id, path: item.link, date: DateTime.parse(item.date)))
          .toList();

      // Upload analysis item to the server
      final file = File(analysis.path);
      final ext = file.path.split('/').last.split('.');
      final name = '${uuid.v4()}${ext.length > 1 ? '.${ext.last}' : ''}';
      await api.uploadAnalysis("${user.id}", DateTime.now().toIso8601String(), file, name: name);

      // Fetch updated item list
      response = await api.getAnalyses(user.id);
      analyses = response.data
          .map((item) => AnalysisItem(id: item.id, path: item.link, date: DateTime.parse(item.date)))
          .toList();

      // Update cache and return the results
      await cache.saveAnalysisData(analyses);
      return analyses;
    } catch (_) {
      // Read cache on exception
      return await cache.loadAnalysisData();
    }
  }

  Future<List<AnalysisItem>> removeAnalysis(AnalysisItem analysis) async {
    try {
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch analyses and map them to List<AnalysisItem>
      final response = await api.getAnalyses(user.id);
      var analyses = response.data
          .map((item) => AnalysisItem(id: item.id, path: item.link, date: DateTime.parse(item.date)))
          .toList();

      // Remove analysis item and send delete request
      analyses = analyses.where((item) => item.id != analysis.id && item.path != analysis.path).toList();
      if (analysis.id != null) {
        await api.deleteAnalysis(analysis.id!);
      }

      // Update cache and return the results
      await cache.saveAnalysisData(analyses);
      return analyses;
    } catch (_) {
      // Read cache on exception
      return await cache.loadAnalysisData();
    }
  }
}
