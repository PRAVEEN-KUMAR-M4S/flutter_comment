import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_comment/core/usecase/usecase_stream.dart';
import 'package:flutter_comment/features/auth/domain/repository/auth_repository.dart';


class AuthStateChage implements UserCaseStream<User?, Noparam> {
  final AuthRepository authRepository;

  AuthStateChage({required this.authRepository});

  @override
  Stream<User?> call(param) {
    return authRepository.authStateChanges();
  }
}
