import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_comment/core/common/entities/user.dart';
import 'package:flutter_comment/core/error/failure.dart';
import 'package:flutter_comment/features/auth/data/datsources/auth_remote_datasources.dart';
import 'package:flutter_comment/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasources authRemoteDatasources;

  AuthRepositoryImp(
    this.authRemoteDatasources,
  );
  @override
  Future<Either<Failure, User?>> signInWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDatasources.signInWithEmailandPassword(
          email: email, password: password);
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, User?>> signUpWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDatasources.signUpWithEmailandPassword(
          name: name, email: email, password: password);
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      final user = await authRemoteDatasources.getCurrentSession();
      if (user == null) {
        return left(Failure('User not loggged In !!!'));
      }
      return right(user);
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Stream<User?> authStateChanges() {
    final user = authRemoteDatasources.authStateChanges();
    return user;
  }

  @override
  Future<void> signOut() async {
    try {
      await authRemoteDatasources.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
