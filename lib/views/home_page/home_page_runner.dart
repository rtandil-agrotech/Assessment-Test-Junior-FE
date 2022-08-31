// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_list/get_book_list_bloc.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_list_additional_cubit/get_book_list_additional_cubit.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_list_settings_cubit/get_book_list_settings_cubit.dart';
import 'package:flutter_modul_fe/bloc/cart/add_to_cart/add_to_cart_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/views/home_page/home_page_ui.dart';

class HomePageRunner extends StatefulWidget {
  const HomePageRunner({Key? key}) : super(key: key);

  @override
  HomePageRunnerState createState() => HomePageRunnerState();
}

class HomePageRunnerState extends State<HomePageRunner> {
  final GetBookListSettingsCubit settingsCubit = GetBookListSettingsCubit();
  final GetBookListAdditionalCubit additionalCubit =
      GetBookListAdditionalCubit();
  final AddToCartBloc addToCartBloc = AddToCartBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetBookListBloc>(
            create: (context) => GetBookListBloc(
              settingsCubit: settingsCubit,
              additionalCubit: additionalCubit,
              addToCartBloc: addToCartBloc,
              userDataCubit: BlocProvider.of<UserDataCubit>(context),
            ),
          ),
          BlocProvider(create: (context) => settingsCubit),
          BlocProvider(create: (context) => additionalCubit),
          BlocProvider(create: (context) => addToCartBloc),
        ],
        child: HomePageUi(),
      ),
    );
  }
}
