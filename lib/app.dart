// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/bloc/login/user_login/user_login_bloc.dart';
import 'package:flutter_modul_fe/routes/routesManager.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final UserDataCubit userDataCubit = UserDataCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserLoginBloc>(
          create: (context) => UserLoginBloc(userDataCubit: userDataCubit),
        ),
        BlocProvider(create: (context) => userDataCubit),
      ],
      child: MaterialApp(
        title: 'Library',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: RouteManager.generateRoute,
        initialRoute: '/login',
        // home: const LoginPageRunner(),
      ),
    );
  }
}
