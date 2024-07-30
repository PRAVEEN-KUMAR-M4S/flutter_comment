import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comment/core/common/entities/user.dart';
import 'package:flutter_comment/core/usecase/usecase.dart';
import 'package:flutter_comment/core/usecase/usecase_stream.dart';
import 'package:flutter_comment/features/auth/domain/usecase/auth_state_chage.dart';
import 'package:flutter_comment/features/auth/domain/usecase/get_current_user.dart';
import 'package:flutter_comment/features/auth/domain/usecase/user_sign_in.dart';
import 'package:flutter_comment/features/auth/domain/usecase/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AuthStateChage _authStateChage;

  AuthBloc(
      {required AuthStateChage authStateChange,
      required CurrentUser currentUser,
      required UserSignUp userSignUp,
      required UserSignIn userSignIn})
      : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _authStateChage = authStateChange,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
    on<AuthStateChangeEvent>(_onAuthStateChangeStream);
  }

  void _onAuthStateChangeStream(
    AuthStateChangeEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final res = _authStateChage(Noparam());
      emit(AuthStateChageSuccess(user: res));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(Noparams());
    res.fold((l) => emit(AuthFailure(error: l.error)),
        (r) => emit(AuthUserDataSuccess(user: r)));
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailure(error: l.error)),
        (r) => emit(AuthSignInUpSuccess(user: r)));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(
        AuthSignInParams(email: event.email, password: event.password));

    res.fold((l) => emit(AuthFailure(error: l.error)),
        (r) => emit(AuthSignInSuccess(user: r)));
  }
}
