part of 'package:sol_replace_revamp/src/features/splash/splash_library.dart';

class SplashDataSource {
  /// Use the shared auth client from SBTables
  final GoTrueClient _auth = SBTables.auth;

  /// Get current session from Supabase
  Session? getCurrentSession()  {
    try {
      return _auth.currentSession;
    } catch (e) {
      debugPrint("Error getting current session: $e");
      return null;
    }
  }


  Future<UserModel> fetchUser(String id) async {
    try {
      final response = await SBTables.users
          .select()
          .eq('id', id)
          .limit(1);

      if (response.isEmpty) {
        throw "User not found";
      }
      final userMap = response.first;

      return UserModel.fromJson(userMap);
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
    }
  }
}