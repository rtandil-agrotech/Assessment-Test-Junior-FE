// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/cart/delete_from_cart/delete_from_cart_bloc.dart';
import 'package:flutter_modul_fe/bloc/cart/get_cart_list/get_cart_list_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/bloc/transaction/post_new_transaction/post_new_transaction_bloc.dart';
import 'package:flutter_modul_fe/views/checkout_page/checkout_page_ui.dart';

class CheckoutPageRunner extends StatefulWidget {
  const CheckoutPageRunner({Key? key}) : super(key: key);

  @override
  CheckoutPageRunnerState createState() => CheckoutPageRunnerState();
}

class CheckoutPageRunnerState extends State<CheckoutPageRunner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetCartListBloc>(
            create: (context) => GetCartListBloc(
              userDataCubit: BlocProvider.of<UserDataCubit>(context),
            ),
          ),
          BlocProvider<DeleteFromCartBloc>(
            create: (context) => DeleteFromCartBloc(
              userDataCubit: BlocProvider.of<UserDataCubit>(context),
            ),
          ),
          BlocProvider<PostNewTransactionBloc>(
            create: (context) => PostNewTransactionBloc(),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<DeleteFromCartBloc, DeleteFromCartState>(
              listener: (context, state) {
                if (state is DeleteFromCartDone) {
                  BlocProvider.of<GetCartListBloc>(context)
                      .add(GetCartListFromApi());
                }
              },
            ),
            BlocListener<PostNewTransactionBloc, PostNewTransactionState>(
              listener: (context, state) {
                if (state is PostNewTransactionDone) {
                  BlocProvider.of<GetCartListBloc>(context)
                      .add(GetCartListFromApi());
                }
              },
            )
          ],
          child: CheckoutPageUi(),
        ),
      ),
    );
  }
}
