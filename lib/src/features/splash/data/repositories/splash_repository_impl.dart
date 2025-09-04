part of 'package:sol_replace_revamp/src/features/splash/splash_library.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashDataSource _splashDataSource = SplashDataSource();

  @override
  Session? getCurrentSession() {
    try {
      return _splashDataSource.getCurrentSession();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> fetchUser(String id) async {
    try {
      return await _splashDataSource.fetchUser(id);
    } catch (_) {
      rethrow;
    }
  }
}
