part of 'fetch_data_bloc.dart';

@immutable
sealed class FetchDataState {}

final class FetchDataInitial extends FetchDataState {}

final class FetchDataSuccess extends FetchDataState {
  final List<DataEntity> dataModel;

  FetchDataSuccess({required this.dataModel});
}

final class FetchDataFailure extends FetchDataState {
  final String error;

  FetchDataFailure({required this.error});

}


final class FetchDataLoading extends FetchDataState{} 


final class SignOutSuccess extends FetchDataState{}



