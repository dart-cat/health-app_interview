import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vstrecha/data/models/city.dart';
import 'package:vstrecha/data/models/institution.dart';
import 'package:vstrecha/data/models/paged.dart';
import 'package:vstrecha/data/models/response.dart';
import 'package:vstrecha/data/models/type_institution.dart';
import 'package:vstrecha/data/providers/api.dart';
import 'package:vstrecha/data/providers/local_cache.dart';

class InstitutionsRepository {
  InstitutionsRepository._privateConstructor();

  static final InstitutionsRepository instance = InstitutionsRepository._privateConstructor();

  late API api;
  late LocalCache cache;

  void init() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    api = API(dio);
    cache = const LocalCache();
  }

  Future<List<Institution>> getInstitutions({bool abroad = false}) async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Fetch all pages
      int i = 1;
      APIResponse<Paged<List<Institution>>> fetch;
      final List<Institution> institutions = [];
      do {
        if (abroad) {
          fetch = await api.getAbroadInstitutions(i++);
        } else {
          fetch = await api.getInstitutions(i++);
        }
        institutions.addAll(fetch.data.items);
      } while (fetch.data.current_page < fetch.data.total_pages);

      // Save to cache and return results
      await cache.saveInstitutions(institutions, abroad: abroad);
      return institutions;
    } catch (_) {
      // Read cache if no internet connection
      return await cache.loadInstitutions(abroad: abroad);
    }
  }

  Future<List<City>> getCities({bool abroad = false}) async {
    // Read institutions from cache to speed up things
    final List<Institution> institutions = await cache.loadInstitutions(abroad: abroad);

    // Make unique list of cities
    final List<City> cities = [];
    for (final institution in institutions) {
      City? city = cities.where((c) => c.id == institution.city_id?.id).firstOrNull;
      if (institution.city_id != null && city == null) {
        cities.add(institution.city_id!);
      }
    }

    return cities;
  }

  Future<List<TypeInstitution>> getTypes({bool abroad = false}) async {
    // Read institutions from cache to speed up things
    final List<Institution> institutions = await cache.loadInstitutions(abroad: abroad);

    // Make unique list of types
    final List<TypeInstitution> types = [];
    for (final institution in institutions) {
      TypeInstitution? type = types.where((t) => t.id == institution.type_id.id).firstOrNull;
      if (type == null) {
        types.add(institution.type_id);
      }
    }

    return types;
  }
}
