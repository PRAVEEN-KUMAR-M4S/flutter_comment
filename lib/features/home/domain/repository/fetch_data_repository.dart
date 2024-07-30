import 'package:flutter_comment/core/common/entities/data_entity.dart';
import 'package:flutter_comment/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FetchDataRepository {
  Future<Either<Failure, List<DataEntity>>> fetchData();

     Future<void> signOut();
}
