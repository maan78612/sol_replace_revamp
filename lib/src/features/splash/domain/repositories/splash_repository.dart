part of 'package:sol_replace_revamp/src/features/splash/splash_library.dart';
abstract class SplashRepository {
  Session? getCurrentSession();

  Future<UserModel> fetchUser(String id);


}
