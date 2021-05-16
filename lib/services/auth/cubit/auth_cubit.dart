import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_notes/services/auth/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.auth}) : super(AuthState());
  final AuthRepo auth;
  Future<void> init() async {
    try {
      await auth.restoreSession();
      emit(state.copyWith(user: auth.user, status: AuthStatus.authenticated));
    } on NoSession {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } on EmailVerification {
      emit(state.copyWith(status: AuthStatus.emailNotVerified));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.logInWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(user: auth.user, status: AuthStatus.authenticated));
    } on LogInWithEmailAndPasswordFailure catch (err) {
      _emitError(err.message!);
    } on EmailVerification {
      emit(state.copyWith(status: AuthStatus.emailNotVerified));
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      await auth.signUp(email: email, password: password);
      emit(state.copyWith(user: auth.user, status: AuthStatus.authenticated));
    } on SignUpFailure catch (err) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
      ));
      _emitError(err.message!);
    } on EmailVerification {
      emit(state.copyWith(status: AuthStatus.emailNotVerified));
    }
  }

  Future<void> logout() async {
    try {
      emit(state.copyWith(status: AuthStatus.unauthenticated));

      await auth.logOut();
    } on LogOutFailure catch (err) {
      _emitError(err.message!);
    }
  }

  void _emitError(String message) {
    emit(state.copyWith(errorMessage: message));
    emit(state.removeError());
  }
}
