part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _authDataSource = AuthDataSource();

  @override
  Future<bool> isUserRegistered(String email) async {
    try {
      return await _authDataSource.isUserRegistered(email);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> registerUser(UserModel userData, String password) async {
    try {
      final user = await _authDataSource.registerUser(userData.email, password);

      final updatedUserData = userData.copyWith(authId: user.id);
      return await _setUser(updatedUserData);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _setUser(UserModel userData) async {
    try {
      return await _authDataSource.setUser(userData);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final User? user = await _authDataSource
          .getCurrentUser(); // AuthDataSource returns User?
      if (user == null) throw "User not found";
      return await _fetchUser(user.id); // Use user.id instead of user.email
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final User? user = await _authDataSource.loginUser(
        email,
        password,
      ); // AuthDataSource returns User?
      if (user == null) throw "User not found";
      return await _fetchUser(user.id); // Use user.id instead of user.email
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      final User? user = await _authDataSource
          .signInWithFacebook(); // AuthDataSource returns User?
      if (user == null) throw "User not found";
      return await _fetchUser(user.id); // Use user.id instead of user.email
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final User? user = await _authDataSource
          .signInWithGoogle(); // AuthDataSource returns User?
      if (user == null) throw "User not found";
      return await _fetchUser(user.id); // Use user.id instead of user.email
    } catch (_) {
      rethrow;
    }
  }

  Future<UserModel> _fetchUser(String id) async {
    try {
      return await _authDataSource.fetchUser(id);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> sendResetPassEmail(String email) async {
    try {
      return await _authDataSource.sendResetPassEmail(email);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      return await _authDataSource.signOut();
    } catch (_) {
      rethrow;
    }
  }
}
