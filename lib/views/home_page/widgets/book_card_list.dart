// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_list/get_book_list_bloc.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_list_additional_cubit/get_book_list_additional_cubit.dart';
import 'package:flutter_modul_fe/theme/style.dart';
import 'package:flutter_modul_fe/views/home_page/widgets/book_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:visibility_detector/visibility_detector.dart';

class BookCardList extends StatefulWidget {
  const BookCardList({Key? key}) : super(key: key);

  @override
  BookCardListState createState() => BookCardListState();
}

class BookCardListState extends State<BookCardList> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBookListBloc, GetBookListState>(
      builder: (context, state) {
        if (state is GetBookListDone) {
          if (state.data.isNotEmpty) {
            return SingleChildScrollView(
              controller: _controller,
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  StaggeredGridView.countBuilder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    crossAxisCount: 2,
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return BookCard(
                        data: state.data[index],
                        cartData: state.cartData,
                      );
                    },
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                  ),
                  _bottomDataNotifier(),
                  VisibilityDetector(
                    key: Key(
                      'key-${DateTime.now().millisecondsSinceEpoch}',
                    ),
                    child: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onVisibilityChanged: (VisibilityInfo info) {
                      if (info.visibleBounds.bottom != 0.0) {
                        BlocProvider.of<GetBookListBloc>(context)
                            .add(GetBookListFromApiNextPage());
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "No Books Found...",
                style: TextStyle(
                  fontSize: 24,
                  color: UsedColors.customGrey,
                ),
              ),
            );
          }
        } else if (state is GetBookListLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetBookListFailed) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is GetBookListBySearchFailed) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is GetBookListBySearchDone) {
          if (state.data.isNotEmpty) {
            return SingleChildScrollView(
              controller: _controller,
              physics: ClampingScrollPhysics(),
              child: StaggeredGridView.countBuilder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 27),
                crossAxisCount: 2,
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return BookCard(
                    data: state.data[index],
                    cartData: state.cartData,
                  );
                },
                staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
              ),
            );
          } else {
            return Center(
              child: Text(
                "No Books Found...",
                style: TextStyle(
                  fontSize: 24,
                  color: UsedColors.customGrey,
                ),
              ),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  _bottomDataNotifier() {
    return BlocBuilder<GetBookListAdditionalCubit, GetBookListAdditionalState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 6, bottom: 8),
          child: () {
            if (state is GetBookListAdditionalLoading) {
              return Center(
                child: SpinKitThreeBounce(
                  size: 30,
                  color: UsedColors.blueButton,
                ),
              );
            } else if (state is GetBookListAdditionalFailed) {
              return Text(
                'Failed to Load Data',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return SizedBox(height: 30);
            }
          }(),
        );
      },
    );
  }
}
