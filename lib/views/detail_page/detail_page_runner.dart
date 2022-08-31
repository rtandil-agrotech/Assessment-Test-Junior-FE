// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_detail/get_book_detail_bloc.dart';
import 'package:flutter_modul_fe/bloc/cart/add_to_cart/add_to_cart_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/views/detail_page/detail_page_ui.dart';

class DetailPageRunner extends StatefulWidget {
  const DetailPageRunner({Key? key, required this.bookId}) : super(key: key);

  final int bookId;

  @override
  DetailPageRunnerState createState() => DetailPageRunnerState();
}

class DetailPageRunnerState extends State<DetailPageRunner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetBookDetailBloc(
              userDataCubit: BlocProvider.of<UserDataCubit>(context),
            ),
          ),
          BlocProvider<AddToCartBloc>(create: (context) => AddToCartBloc()),
        ],
        child: SingleChildScrollView(
          child: DetailPageUi(bookId: widget.bookId),
        ),
      ),
    );
  }
}
