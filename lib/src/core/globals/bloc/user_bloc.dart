import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sol_replace_revamp/src/features/auth/domain/model/user_model.dart';

// Events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class SetUser extends UserEvent {
  final UserModel user;

  const SetUser(this.user);

  @override
  List<Object?> get props => [user];
}

class ClearUser extends UserEvent {
  const ClearUser();
}

// State
class UserState extends Equatable {
  final UserModel user;
  final bool isAuthenticated;

  const UserState({
    required this.user,
    this.isAuthenticated = false,
  });

  UserState copyWith({
    UserModel? user,
    bool? isAuthenticated,
  }) {
    return UserState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [user, isAuthenticated];
}

// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState(user: UserModel.empty())) {
    on<SetUser>(_onSetUser);
    on<ClearUser>(_onClearUser);
  }

  void _onSetUser(SetUser event, Emitter<UserState> emit) {
    emit(state.copyWith(
      user: event.user,
      isAuthenticated: true,
    ));
  }

  void _onClearUser(ClearUser event, Emitter<UserState> emit) {
    emit(UserState(user: UserModel.empty(), isAuthenticated: false));
  }
}
