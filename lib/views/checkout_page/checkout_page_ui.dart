// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/cart/get_cart_list/get_cart_list_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/bloc/transaction/post_new_transaction/post_new_transaction_bloc.dart';
import 'package:flutter_modul_fe/models/transaction_model/add_new_transaction_model.dart';
import 'package:flutter_modul_fe/theme/style.dart';
import 'package:flutter_modul_fe/views/checkout_page/widgets/checkout_card_list.dart';
import 'package:flutter_modul_fe/views/confirmation_dialog.dart';

class CheckoutPageUi extends StatefulWidget {
  const CheckoutPageUi({Key? key}) : super(key: key);

  @override
  CheckoutPageUiState createState() => CheckoutPageUiState();
}

class CheckoutPageUiState extends State<CheckoutPageUi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          color: UsedColors.blueButton,
        ),
        SizedBox(height: 17),
        BlocBuilder<GetCartListBloc, GetCartListState>(
          builder: (context, state) {
            if (state is GetCartListDone) {
              if (state.data.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: UsedColors.blueButton,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          fixedSize: Size(135, 32),
                        ),
                        onPressed: () async {
                          bool submit = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return ConfirmationDialog();
                            },
                          );

                          if (submit == true) {
                            BlocProvider.of<PostNewTransactionBloc>(context)
                                .add(
                              CreateNewTransaction(
                                data: AddNewTransactionModel(
                                  userId:
                                      BlocProvider.of<UserDataCubit>(context)
                                          .state
                                          .userData!
                                          .id,
                                  returnDate: DateTime.now().add(
                                    Duration(days: 1),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Borrow",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(
                        "Books in Cart : ${state.data.length}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          },
        ),
        SizedBox(height: 17),
        Expanded(child: CheckoutCardList()),
      ],
    );
  }
}
