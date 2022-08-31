// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/cart/delete_from_cart/delete_from_cart_bloc.dart';
import 'package:flutter_modul_fe/models/cart_model/cart_list_model.dart';
import 'package:flutter_modul_fe/theme/style.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({Key? key, required this.data}) : super(key: key);

  final GetCartListDataModel data;

  @override
  CheckoutCardState createState() => CheckoutCardState();
}

class CheckoutCardState extends State<CheckoutCard> {
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
              flex: 35,
              fit: FlexFit.tight,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 135),
                      color: UsedColors.blueButton,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4,
                      top: 4,
                      bottom: 4,
                      right: 6,
                    ),
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
              flex: 55,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 11, bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: Text(
                        widget.data.author,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    ElevatedButton(
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
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 48),
                      color: UsedColors.starColor,
                    ),
                  ),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        BlocProvider.of<DeleteFromCartBloc>(context).add(
                          DeleteBookFromCart(bookId: widget.data.id),
                        );
                      },
                      icon: Icon(Icons.close, color: Colors.white),
                      splashRadius: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
