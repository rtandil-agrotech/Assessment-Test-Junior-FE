// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/transaction/get_transaction_history/get_transaction_history_bloc.dart';
import 'package:flutter_modul_fe/theme/style.dart';
import 'package:flutter_modul_fe/views/borrowed_page/widgets/book_card_borrowed_list.dart';
import 'package:intl/intl.dart';

class BorrowedPageUi extends StatefulWidget {
  const BorrowedPageUi({Key? key}) : super(key: key);

  @override
  BorrowedPageUiState createState() => BorrowedPageUiState();
}

class BorrowedPageUiState extends State<BorrowedPageUi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          color: UsedColors.blueButton,
        ),
        SizedBox(height: 14),
        BlocBuilder<GetTransactionHistoryBloc, GetTransactionHistoryState>(
          builder: (context, state) {
            if (state is GetTransactionHistoryDone) {
              if (state.data.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Borrowed at :", style: TextStyle(fontSize: 20)),
                      Text(
                        DateFormat("d MMM yyyy")
                            .format(state.data[0].borrowedTime),
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
        SizedBox(height: 14),
        Expanded(
          child: BookCardBorrowedList(),
        ),
      ],
    );
  }
}
