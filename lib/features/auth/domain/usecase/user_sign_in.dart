
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_comment/core/error/failure.dart';
import 'package:flutter_comment/core/usecase/usecase.dart';
import 'package:flutter_comment/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UserCase<User?, AuthSignInParams> {
  final AuthRepository authRepository;

  UserSignIn( this.authRepository);
  @override
  Future<Either<Failure, User?>> call(AuthSignInParams params) async{
    return await authRepository.signInWithEmailandPassword(email: params.email, password: params.password);
  }
}

class AuthSignInParams {
  final String email;
  final String password;

  AuthSignInParams({required this.email, required this.password});
}
