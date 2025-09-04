part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class AuthDataSource {
  final GoTrueClient _auth = SBTables.auth;

  Future<bool> isUserRegistered(String email) async {
    try {
      final response = await SBTables.users
          .select()
          .eq('email', email)
          .limit(1);
      return response.isNotEmpty;
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
    }
  }

  Future<void> setUser(UserModel userData) async {
    try {
      await SBTables.users.insert(userData.toJson());
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
    }
  }

  Future<User> registerUser(String email, String password) async { // Changed return type to Future<User>
    try {
      final AuthResponse response = await _auth.signUp(email: email, password: password);
      if (response.user == null) {
        throw "Registration failed: No user returned.";
      }
      return response.user!;
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
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

  Future<void> sendResetPassEmail(String email) async {
    try {
      await _auth.resetPasswordForEmail(email);
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
    }
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      final response = await _auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      await _auth.signInWithOAuth(OAuthProvider.facebook);
      return _auth.currentUser;
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      await _auth.signInWithOAuth(OAuthProvider.google);
      return _auth.currentUser;
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      throw ("Authentication Error : ${e.toString()}");
    }
  }
}
