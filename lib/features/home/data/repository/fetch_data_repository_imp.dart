import 'package:flutter_comment/core/common/entities/data_entity.dart';
import 'package:flutter_comment/core/error/failure.dart';
import 'package:flutter_comment/features/home/data/datasources/fetch_data_datasources.dart';
import 'package:flutter_comment/features/home/domain/repository/fetch_data_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchDataRepositoryImp implements FetchDataRepository {
  final FetchDataDatasources fetchDataDatasources;

  FetchDataRepositoryImp({required this.fetchDataDatasources});
  @override
  Future<Either<Failure, List<DataEntity>>> fetchData() async {
    try {
      final res = await fetchDataDatasources.fetchData();
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    await fetchDataDatasources.signOut();
  }
}
