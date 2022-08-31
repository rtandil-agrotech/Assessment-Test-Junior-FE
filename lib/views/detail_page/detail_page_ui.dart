// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_detail/get_book_detail_bloc.dart';
import 'package:flutter_modul_fe/bloc/cart/add_to_cart/add_to_cart_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/models/cart_model/add_to_cart_model.dart';
import 'package:flutter_modul_fe/theme/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailPageUi extends StatefulWidget {
  const DetailPageUi({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  final int bookId;

  @override
  DetailPageUiState createState() => DetailPageUiState();
}

class DetailPageUiState extends State<DetailPageUi> {
  bool isInList = false;

  @override
  void didChangeDependencies() {
    BlocProvider.of<GetBookDetailBloc>(context)
        .add(GetBookDetailFromApi(id: widget.bookId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetBookDetailBloc, GetBookDetailState>(
          listener: (context, state) {
            if (state is GetBookDetailDone) {
              for (int i = 0; i < state.cartData.length; i++) {
                if (state.data[0].id == state.cartData[i].id) {
                  setState(() {
                    isInList = true;
                  });
                }
              }
            }
          },
        ),
        BlocListener<AddToCartBloc, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartDone) {
              BlocProvider.of<GetBookDetailBloc>(context)
                  .add(GetBookDetailFromApi(id: widget.bookId));
            }
          },
        ),
      ],
      child: BlocBuilder<GetBookDetailBloc, GetBookDetailState>(
        builder: (context, state) {
          if (state is GetBookDetailDone) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100,
                      color: UsedColors.blueButton,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18, top: 55, bottom: 22),
                      child: IconButton(
                        onPressed: () {
                          // Navigator.pop(context);

                          Navigator.of(context).pushNamed("/home");
                        },
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        ),
                        splashRadius: 1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 24,
                    top: 44,
                    bottom: 47,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 180,
                                  constraints: BoxConstraints(maxWidth: 180),
                                  color: UsedColors.blueButton,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: double.infinity,
                                    maxWidth: 180,
                                  ),
                                  child: Image.network(
                                    state.data[0].imageM,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                        state.data[0].imageM,
                                        fit: BoxFit.fill,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 31),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.data[0].author),
                                  SizedBox(height: 5),
                                  Text(
                                    state.data[0].title,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Quantity Left : ${state.data[0].stok}"),
                                  BlocBuilder<AddToCartBloc, AddToCartState>(
                                    builder: (context, addState) {
                                      if (addState is AddToCartLoading) {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            minimumSize: Size(175, 35),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: null,
                                          child: SpinKitThreeBounce(
                                            color: UsedColors.customGrey,
                                            size: 30,
                                          ),
                                        );
                                      } else {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary: state.data[0].stok > 0 &&
                                                    isInList == false
                                                ? UsedColors.blueButton
                                                : UsedColors.greyButton,
                                            minimumSize: Size(175, 35),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (state.data[0].stok > 0 &&
                                                isInList == false) {
                                              return () {
                                                BlocProvider.of<AddToCartBloc>(
                                                        context)
                                                    .add(
                                                  AddBookToCart(
                                                    data: AddBookToCartModel(
                                                      userId: BlocProvider.of<
                                                                  UserDataCubit>(
                                                              context)
                                                          .state
                                                          .userData!
                                                          .id,
                                                      bookId: state.data[0].id,
                                                    ),
                                                  ),
                                                );
                                              };
                                            } else {
                                              return null;
                                            }
                                          }(),
                                          child: Text(
                                            () {
                                              if (isInList == false) {
                                                return "Add to Cart";
                                              } else {
                                                return "Already Added";
                                              }
                                            }(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 30,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(),
                            bottom: BorderSide(),
                            right: BorderSide(),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.data[0].averageRating
                                  .toStringAsPrecision(2),
                              style: TextStyle(fontSize: 18),
                            ),
                            Icon(
                              Icons.star,
                              color: UsedColors.starColor,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 70,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(),
                            bottom: BorderSide(),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Center(
                          child: Text(
                            "ISBN : ${state.data[0].isbn}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          } else if (state is GetBookDetailLoading) {
            return Center(
              heightFactor: 250,
              child: CircularProgressIndicator(),
            );
          } else if (state is GetBookDetailFailed) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100,
                      color: UsedColors.blueButton,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18, top: 55, bottom: 22),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        ),
                        splashRadius: 1,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    "Failed to Load Data",
                    style: TextStyle(
                      fontSize: 24,
                      color: UsedColors.customGrey,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
