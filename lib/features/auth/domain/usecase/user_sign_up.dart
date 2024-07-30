
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_comment/core/error/failure.dart';
import 'package:flutter_comment/core/usecase/usecase.dart';
import 'package:flutter_comment/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class UserSignUp implements UserCase<User?, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User?>> call(UserSignUpParams params) async {
  return await authRepository.signUpWithEmailandPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
