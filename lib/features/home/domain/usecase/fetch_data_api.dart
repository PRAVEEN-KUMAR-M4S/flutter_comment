import 'package:flutter_comment/core/common/entities/data_entity.dart';
import 'package:flutter_comment/core/error/failure.dart';
import 'package:flutter_comment/core/usecase/usecase.dart';
import 'package:flutter_comment/features/home/domain/repository/fetch_data_repository.dart';
import 'package:fpdart/fpdart.dart';


class FetchDataApi implements UserCase<List<DataEntity>, Noparams> {
  final FetchDataRepository fetchDataRepository;

  FetchDataApi({required this.fetchDataRepository});
  @override
  Future<Either<Failure, List<DataEntity>>> call(Noparams params) async {
    return await fetchDataRepository.fetchData();
  }
}
