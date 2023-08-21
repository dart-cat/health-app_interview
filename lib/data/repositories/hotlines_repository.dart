import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:vstrecha/data/models/hotline.dart';
import 'package:vstrecha/data/models/paged.dart';
import 'package:vstrecha/data/models/response.dart';
import 'package:vstrecha/data/providers/api.dart';
import 'package:vstrecha/data/providers/local_cache.dart';

class HotlinesRepository {
  HotlinesRepository._privateConstructor();

  static final HotlinesRepository instance = HotlinesRepository._privateConstructor();

  late API api;
  late LocalCache cache;

  void init() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    api = API(dio);
    cache = const LocalCache();
  }

  Future<List<Hotline>> getHotlines() async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      int i = 1;
      APIResponse<Paged<List<Hotline>>> fetch;
      final List<Hotline> hotlines = [];

      // Fetch all pages
      do {
        fetch = await api.getHotlines(i++);
        hotlines.addAll(fetch.data.items);
      } while (fetch.data.current_page < fetch.data.total_pages);

      // Save to cache and return results
      await cache.saveHotlines(hotlines);
      return hotlines;
    } catch (_) {
      // Fetch from cache when no internet connection
      return await cache.loadHotlines();
    }
  }
}
