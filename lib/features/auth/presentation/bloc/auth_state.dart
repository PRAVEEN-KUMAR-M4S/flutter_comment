part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSignInUpSuccess extends AuthState {
  final User? user;

  AuthSignInUpSuccess({required this.user});
}

final class AuthUserDataSuccess extends AuthState {
  final UserEntity user;

  AuthUserDataSuccess({required this.user});
}

final class AuthStateChageSuccess extends AuthState {
  final Stream<User?> user;

  AuthStateChageSuccess({required this.user});
}

final class AuthLoading extends AuthState {}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}

final class AuthSignInSuccess extends AuthState {
  final User? user;

  AuthSignInSuccess({required this.user});
}
