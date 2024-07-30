part of 'fetch_data_bloc.dart';

@immutable
sealed class FetchDataEvent {}

final class FetchData extends FetchDataEvent{}


final class SignOutEvent extends FetchDataEvent{}