import 'package:supabase_flutter/supabase_flutter.dart';

class BonsuiSupabaseAuthResponse {
  final User? user;
  final Session? session;
  final String? error;

  BonsuiSupabaseAuthResponse(
      {required this.user, required this.session, required this.error});
}
