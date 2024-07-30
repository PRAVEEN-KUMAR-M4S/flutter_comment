
import 'package:flutter_comment/core/usecase/usecase.dart';
import 'package:flutter_comment/core/usecase/usercase_void.dart';
import 'package:flutter_comment/features/home/domain/repository/fetch_data_repository.dart';



class SignOutFun implements UserCaseVoid<void, Noparams> {
  final FetchDataRepository fetchDataRepository;

  SignOutFun({required this.fetchDataRepository});
  @override
  Future<void> call(Noparams params) async {
    return await fetchDataRepository.signOut();
  }
}
