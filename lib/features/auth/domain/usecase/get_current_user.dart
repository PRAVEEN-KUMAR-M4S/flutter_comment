
import 'package:flutter_comment/core/common/entities/user.dart';
import 'package:flutter_comment/core/error/failure.dart';
import 'package:flutter_comment/core/usecase/usecase.dart';
import 'package:flutter_comment/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UserCase<UserEntity, Noparams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(Noparams params) async{
    return await authRepository.currentUser();
  }
}
