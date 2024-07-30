import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_comment/features/auth/data/datsources/auth_remote_datasources.dart';
import 'package:flutter_comment/features/auth/data/repository/auth_repository_imp.dart';
import 'package:flutter_comment/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_comment/features/auth/domain/usecase/auth_state_chage.dart';
import 'package:flutter_comment/features/auth/domain/usecase/get_current_user.dart';
import 'package:flutter_comment/features/auth/domain/usecase/user_sign_in.dart';
import 'package:flutter_comment/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter_comment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_comment/features/home/data/datasources/fetch_data_datasources.dart';
import 'package:flutter_comment/features/home/data/repository/fetch_data_repository_imp.dart';
import 'package:flutter_comment/features/home/domain/repository/fetch_data_repository.dart';
import 'package:flutter_comment/features/home/domain/usecase/fetch_data_api.dart';
import 'package:flutter_comment/features/home/domain/usecase/sign_out_fun.dart';
import 'package:flutter_comment/features/home/presentation/bloc/fetch_data_bloc.dart';
import 'package:flutter_comment/firebase_options.dart';

import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  _initFetchData();



  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  serviceLocator.registerLazySingleton(() => firebaseAuth);
  serviceLocator.registerLazySingleton(() => firebaseFirestore);
}

void _initFetchData() {
  serviceLocator.registerFactory<FetchDataDatasources>(
      () => FetchDataDatasourcesImp(firebaseAuth: serviceLocator()));

  serviceLocator.registerFactory<FetchDataRepository>(
      () => FetchDataRepositoryImp(fetchDataDatasources: serviceLocator()));

        serviceLocator.registerFactory(
    () => SignOutFun(
       fetchDataRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
      () => FetchDataApi(fetchDataRepository: serviceLocator()));

  serviceLocator.registerLazySingleton(
      () => FetchDataBloc( serviceLocator(), fetchDataApi: serviceLocator() ,));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasources>(
    () => AuthRemoteDatasourcesImp(
      firebaseAuth: serviceLocator(),
      firebaseFirestore: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignIn(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );
  serviceLocator
      .registerFactory(() => AuthStateChage(authRepository: serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
      authStateChange: serviceLocator(),
    ),
  );
}
