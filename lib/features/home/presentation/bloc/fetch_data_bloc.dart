import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comment/core/common/entities/data_entity.dart';
import 'package:flutter_comment/core/usecase/usecase.dart';
import 'package:flutter_comment/features/home/domain/usecase/fetch_data_api.dart';
import 'package:flutter_comment/features/home/domain/usecase/sign_out_fun.dart';
import 'package:fpdart/fpdart.dart';

part 'fetch_data_event.dart';
part 'fetch_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  final SignOutFun _signOutFun;
  final FetchDataApi _fetchDataApi;
  FetchDataBloc(this._signOutFun,
      {required FetchDataApi fetchDataApi})
      : _fetchDataApi = fetchDataApi,
        super(FetchDataInitial()) {
    on<FetchData>((event, emit) async {
      emit(FetchDataLoading());
      final res = await _fetchDataApi(Noparams());
      res.fold((l) => left(emit(FetchDataFailure(error: l.error))),
          (r) => right(emit(FetchDataSuccess(dataModel: r))));
    });

    on<SignOutEvent>((event, emit) async {
      emit(FetchDataLoading());
      await _signOutFun(Noparams());
    });
  }
}
