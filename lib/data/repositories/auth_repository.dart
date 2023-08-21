import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vstrecha/data/models/user.dart';
import 'package:vstrecha/data/providers/api.dart';
import 'package:vstrecha/data/providers/local_cache.dart';

class AuthRepository {
  AuthRepository._privateConstructor();

  static final AuthRepository instance = AuthRepository._privateConstructor();

  late API api;
  late LocalCache cache;

  void init() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    api = API(dio);
    cache = const LocalCache();
  }

  Future<User?> getUser({String? email, String? password}) async {
    // Get user from cache if no credentials specified
    if (email == null || password == null) {
      return await cache.loadUser();
    }

    // Otherwise log in using API
    final result = await api.login(email, password);
    if (result.status == 'success') {
      Map<String, dynamic> json = result.data['user'];
      User user = User.fromJson(json);
      await cache.saveUser(user);
      print('user: $user');
      return user;
    }

    // On failure
    return null;
  }

  Future<bool> createUser({
    required String email,
    required String password,
    required String gender,
    required List<int> typesUsers,
    required String city,
  }) async {
    final regResult = await api.createAccount(
        email, password, gender, typesUsers.join(','), city);
    return regResult.status == 'success';
  }

  Future<void> deleteUser() async {
    await cache.saveUser(null);
  }
}
