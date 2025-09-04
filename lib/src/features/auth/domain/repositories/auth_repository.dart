
part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';


abstract class AuthRepository {
  Future<bool> isUserRegistered(String email);
  Future<void> registerUser(UserModel userData, String password);
  Future<UserModel> signInWithEmailPassword(String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<void> sendResetPassEmail(String email);
  Future<bool> signOut();
  Future<UserModel> getCurrentUser();

}
