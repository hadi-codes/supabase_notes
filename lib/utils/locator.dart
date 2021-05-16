import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_notes/api/api.dart';
import 'package:supabase_notes/services/auth/auth.dart';
import './constans.dart';

GetIt locator = GetIt.instance;
Future<void> setupLocatorServices() async {
  final prefs = await SharedPreferences.getInstance();
  final supabaseClient =
      SupabaseClient(supabaseURL, supabaseAnonKey, autoRefreshToken: false);
  final notesRepo = NotesRepo(supabaseClient: supabaseClient);
  locator.registerSingleton<SupabaseClient>(supabaseClient);
  locator.registerSingletonAsync<AuthRepo>(
      () async => AuthRepo(supabaseClient: supabaseClient, prefs: prefs));
  locator.registerSingleton<NotesRepo>(notesRepo);
}
