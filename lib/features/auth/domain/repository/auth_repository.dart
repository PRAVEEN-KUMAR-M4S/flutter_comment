

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_comment/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User?>> signUpWithEmailandPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure, User?>> signInWithEmailandPassword(
      {required String email, required String password});

  Future<Either<Failure, UserEntity>> currentUser();

   Stream<User?> authStateChanges();

    Future<void> signOut();
}
