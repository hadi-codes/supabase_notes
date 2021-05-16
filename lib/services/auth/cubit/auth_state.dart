part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, emailNotVerified }

class AuthState extends Equatable {
  AuthState({this.status = AuthStatus.unknown, this.user, this.errorMessage});
  final AuthStatus status;
  final User? user;
  final String? errorMessage;
  @override
  List<Object?> get props => [status, user, errorMessage];

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  AuthState removeError() {
    return AuthState(
      status: status,
      user: user,
      errorMessage: null,
    );
  }
}
