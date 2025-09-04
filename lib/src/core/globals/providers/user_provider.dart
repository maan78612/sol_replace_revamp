import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sol_replace_revamp/src/features/auth/domain/model/user_model.dart';

class UserModelProvider extends StateNotifier<UserModel> {
  UserModelProvider() : super(UserModel.empty());

  Future<void> setUser(UserModel newUser) async {
    state = newUser;
  }
}

final userModelProvider = StateNotifierProvider<UserModelProvider, UserModel>((
  ref,
) {
  return UserModelProvider();
});
