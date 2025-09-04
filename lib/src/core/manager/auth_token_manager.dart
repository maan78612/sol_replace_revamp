import 'package:sol_replace_revamp/src/core/constants/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class AuthTokenManager {
  static final AuthTokenManager instance = AuthTokenManager._internal();

  const AuthTokenManager._internal();

  Future<Session?> getValidSession() async {
    final session = SBTables.auth.currentSession;
    if (session == null) return null;
    final now = DateTime.now();

    // Check if session expires in next 5 seconds
    if (session.expiresAt != null) {
      final expiresAt = DateTime.fromMillisecondsSinceEpoch(
        session.expiresAt! * 1000,
      );
      debugPrint("Session expires at: $expiresAt, Current time: $now");

      if (expiresAt.isBefore(now.add(const Duration(minutes: 2)))) {
        debugPrint("Session is expired: TRUE");
        try {
          final response = await SBTables.auth.refreshSession();
          debugPrint(" Session refreshed successfully");
          return response.session;
        } catch (e) {
          debugPrint("Session refresh failed: $e");
          return null;
        }
      } else {
        debugPrint("Session is expired: FALSE");
      }
    }

    return session;
  }

  /// Sign out and clear session
  Future<void> signOut() async {
    await SBTables.auth.signOut();
  }
}
