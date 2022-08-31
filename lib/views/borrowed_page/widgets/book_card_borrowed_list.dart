// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/transaction/get_transaction_history/get_transaction_history_bloc.dart';
import 'package:flutter_modul_fe/theme/style.dart';
import 'package:flutter_modul_fe/views/borrowed_page/widgets/book_card_borrowed.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookCardBorrowedList extends StatefulWidget {
  const BookCardBorrowedList({Key? key}) : super(key: key);

  @override
  BookCardBorrowedListState createState() => BookCardBorrowedListState();
}

class BookCardBorrowedListState extends State<BookCardBorrowedList> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTransactionHistoryBloc, GetTransactionHistoryState>(
      builder: (context, state) {
        if (state is GetTransactionHistoryDone) {
          if (state.data.isNotEmpty) {
            return SingleChildScrollView(
              controller: _controller,
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  StaggeredGridView.countBuilder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    crossAxisCount: 2,
                    itemCount: state.data[0].bookData.length,
                    itemBuilder: (context, index) {
                      return BookCardBorrowed(
                        data: state.data[0].bookData[index],
                      );
                    },
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                  ),
                ],
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.collections_bookmark_outlined,
                  size: 80,
                  color: UsedColors.customGrey,
                ),
                SizedBox(height: 20),
                Text(
                  "No books",
                  style: TextStyle(
                    fontSize: 24,
                    color: UsedColors.customGrey,
                  ),
                ),
                Text(
                  "borrowed",
                  style: TextStyle(
                    fontSize: 24,
                    color: UsedColors.customGrey,
                  ),
                )
              ],
            );
          }
        } else if (state is GetTransactionHistoryFailed) {
          return Center(child: Text(state.errorMessage));
        } else if (state is GetTransactionHistoryLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );
  }
}
