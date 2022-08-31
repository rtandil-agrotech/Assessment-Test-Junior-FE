// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/bloc/transaction/get_transaction_history/get_transaction_history_bloc.dart';
import 'package:flutter_modul_fe/views/borrowed_page/borrowed_page_ui.dart';

class BorrowedPageRunner extends StatefulWidget {
  const BorrowedPageRunner({Key? key}) : super(key: key);

  @override
  BorrowedPageRunnerState createState() => BorrowedPageRunnerState();
}

class BorrowedPageRunnerState extends State<BorrowedPageRunner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<GetTransactionHistoryBloc>(
        create: (context) => GetTransactionHistoryBloc(
          userDataCubit: BlocProvider.of<UserDataCubit>(context),
        ),
        child: BorrowedPageUi(),
      ),
    );
  }
}
