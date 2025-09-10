import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

// Events
abstract class GuestEvent extends Equatable {
  const GuestEvent();

  @override
  List<Object?> get props => [];
}

class SetAuthenticated extends GuestEvent {
  const SetAuthenticated();
}

class SetGuest extends GuestEvent {
  const SetGuest();
}

// State
class GuestState extends Equatable {
  final bool isGuest;

  const GuestState({this.isGuest = true});

  GuestState copyWith({bool? isGuest}) {
    return GuestState(isGuest: isGuest ?? this.isGuest);
  }

  @override
  List<Object?> get props => [isGuest];
}

// Bloc
class GuestBloc extends Bloc<GuestEvent, GuestState> {
  GuestBloc() : super(const GuestState()) {
    on<SetAuthenticated>(_onSetAuthenticated);
    on<SetGuest>(_onSetGuest);
    
    debugPrint('GuestBloc: Constructor called with initial state: true');
  }

  void _onSetAuthenticated(SetAuthenticated event, Emitter<GuestState> emit) {
    debugPrint('GuestBloc: Setting authenticated state');
    emit(state.copyWith(isGuest: false));
  }

  void _onSetGuest(SetGuest event, Emitter<GuestState> emit) {
    debugPrint('GuestBloc: Setting guest state');
    emit(state.copyWith(isGuest: true));
  }
}
