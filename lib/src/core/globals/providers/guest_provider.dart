import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

class GuestStateProvider extends StateNotifier<bool> {
  GuestStateProvider() : super(true) {
    debugPrint(
      'GuestStateProvider: Constructor called with initial state: true',
    );
  }

  void setAuthenticated() {
    state = false;
  }

  void setGuest() {
    state = true;
  }
}

final guestStateProvider = StateNotifierProvider<GuestStateProvider, bool>((
  ref,
) {
  debugPrint('guestStateProvider: Creating provider instance');
  return GuestStateProvider();
});
