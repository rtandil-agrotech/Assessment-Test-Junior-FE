// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/cart/add_to_cart/add_to_cart_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/models/book_model/book_list_model.dart';
import 'package:flutter_modul_fe/models/cart_model/add_to_cart_model.dart';
import 'package:flutter_modul_fe/models/cart_model/cart_list_model.dart';
import 'package:flutter_modul_fe/theme/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookCard extends StatefulWidget {
  const BookCard({
    Key? key,
    required this.data,
    required this.cartData,
  }) : super(key: key);

  final GetBookListDataPerPageModel data;
  final List<GetCartListDataModel> cartData;

  @override
  BookCardState createState() => BookCardState();
}

class BookCardState extends State<BookCard> {
  bool isInList = false;

  @override
  void initState() {
    for (int i = 0; i < widget.cartData.length; i++) {
      if (widget.data.id == widget.cartData[i].id) {
        setState(() {
          isInList = true;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      elevation: 3,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 30,
              fit: FlexFit.tight,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 142),
                      color: UsedColors.blueButton,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 125,
                          minHeight: double.infinity,
                        ),
                        child: Image.network(
                          widget.data.imageL,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              widget.data.imageL,
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 70,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 11, bottom: 14),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: Text(
                              widget.data.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 13),
                          child: Column(
                            children: [
                              Text(
                                "${widget.data.ratingCount} Rating",
                                style: TextStyle(fontSize: 8),
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.data.averageRating
                                        .toStringAsPrecision(2),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: UsedColors.starColor,
                                    size: 12,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 21),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data.author,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "Qty : ${widget.data.stok}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              primary: Colors.white,
                              side: BorderSide(color: UsedColors.blueButton),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                "/detail",
                                arguments: widget.data.id,
                              );
                            },
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                fontSize: 10,
                                color: UsedColors.blueButton,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: BlocBuilder<AddToCartBloc, AddToCartState>(
                            builder: (context, state) {
                              if (state is AddToCartLoading &&
                                  state.bookId == widget.data.id) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: null,
                                  child: SpinKitThreeBounce(
                                    size: 30,
                                    color: UsedColors.customGrey,
                                  ),
                                );
                              } else {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 0,
                                    primary: widget.data.stok > 0 &&
                                            isInList == false
                                        ? UsedColors.blueButton
                                        : UsedColors.greyButton,
                                  ),
                                  onPressed: () {
                                    if (widget.data.stok > 0 &&
                                        isInList == false) {
                                      return () {
                                        BlocProvider.of<AddToCartBloc>(context)
                                            .add(
                                          AddBookToCart(
                                            data: AddBookToCartModel(
                                              userId: BlocProvider.of<
                                                      UserDataCubit>(context)
                                                  .state
                                                  .userData!
                                                  .id,
                                              bookId: widget.data.id,
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
                                    style: TextStyle(fontSize: 10),
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
