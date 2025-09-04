import 'package:supabase_flutter/supabase_flutter.dart';

class SBTables {
  /// Shared Supabase client
  static final SupabaseClient client = Supabase.instance.client;

  /// Auth interface
  static final GoTrueClient auth = client.auth;

  /// Users table
  static final SupabaseQueryBuilder users = client.from('users');
}
