import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

class SignUpFailure implements Exception {
  SignUpFailure({this.message});

  final String? message;
}

class EmailVerification implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {
  LogInWithEmailAndPasswordFailure({this.message});
  final String? message;
}

class LogOutFailure implements Exception {
  LogOutFailure({this.message});

  final String? message;
}

class NoSession implements Exception {}

const petsistSessionKey = 'PERSIST_SESSION_KEY';

class AuthRepo {
  AuthRepo({required this.prefs, required this.supabaseClient});

  final SupabaseClient supabaseClient;
  final SharedPreferences prefs;
  User? get user {
    return supabaseClient.auth.currentUser;
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    final res = await supabaseClient.auth.signUp(email, password);
    if (res.error != null)
      throw SignUpFailure(message: res.error!.message);
    else if (res.data == null && res.user == null) {
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      throw EmailVerification();
    } else {
      await prefs.setString(petsistSessionKey, res.data!.persistSessionString);
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final res = await supabaseClient.auth.signIn(
      email: email,
      password: password,
    );
    if (res.error != null) if (res.error!.message == 'Email not confirmed')
      throw EmailVerification();
    else
      throw LogInWithEmailAndPasswordFailure(message: res.error!.message);
    else if (res.data == null && res.user == null) {
      throw EmailVerification();
    } else {
      await prefs.remove('email');
      await prefs.remove('pass');
      await prefs.setString(petsistSessionKey, res.data!.persistSessionString);
    }
  }

  Future<void> logOut() async {
    await prefs.remove('email');
    await prefs.remove('pass');
    await prefs.remove(petsistSessionKey);
    final res = await supabaseClient.auth.signOut();
    if (res.error != null) throw LogOutFailure(message: res.error!.message);
  }

  Future<void> restoreSession() async {
    final email = prefs.getString('email');
    final pass = prefs.getString('pass');
    if (email != null && pass != null) {
      return logInWithEmailAndPassword(email: email, password: pass);
    }

    final exist = prefs.containsKey(petsistSessionKey);
    if (!exist) {
      throw NoSession();
    }

    final jsonStr = prefs.getString(petsistSessionKey)!;
    final res = await supabaseClient.auth.recoverSession(jsonStr);
    if (res.error != null) {
      await prefs.remove(petsistSessionKey);
      throw NoSession();
    }
    await prefs.setString(petsistSessionKey, res.data!.persistSessionString);
  }
}
