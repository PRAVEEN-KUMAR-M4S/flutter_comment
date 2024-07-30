import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comment/core/common/widgets/loader.dart';
import 'package:flutter_comment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_comment/features/auth/presentation/pages/sign_in.dart';
import 'package:flutter_comment/features/auth/presentation/pages/sign_up.dart';
import 'package:flutter_comment/features/home/presentation/bloc/fetch_data_bloc.dart';
import 'package:flutter_comment/features/home/presentation/pages/home_screen.dart';
import 'package:flutter_comment/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) =>
              serviceLocator<AuthBloc>()..add(AuthStateChangeEvent())),
      BlocProvider<FetchDataBloc>(
          create: (context) =>
              serviceLocator<FetchDataBloc>()..add(FetchData()))
    ],
    child: const MyApp(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/SignUpPage': (context) => const SignUpScreen(),
        '/SignInPage': (context) => const SignInScreen(),
        '/HomePage': (context) => const HomeScreen(),
      },
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateChageSuccess) {
            return StreamBuilder(
                stream: state.user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return (const Center(
                      child: CircularProgressIndicator(),
                    ));
                  } else if (snapshot.hasError) {
                    return (const Center(
                      child: Text("Something went wrong !"),
                    ));
                  } else if (snapshot.hasData) {
                    return const HomeScreen();
                  } else {
                    return  SignInScreen();
                  }
                });
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}
