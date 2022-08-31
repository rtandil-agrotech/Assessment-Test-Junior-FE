// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modul_fe/bloc/cart/get_cart_list/get_cart_list_bloc.dart';
import 'package:flutter_modul_fe/theme/style.dart';
import 'package:flutter_modul_fe/views/checkout_page/widgets/checkout_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CheckoutCardList extends StatefulWidget {
  const CheckoutCardList({Key? key}) : super(key: key);

  @override
  CheckoutCardListState createState() => CheckoutCardListState();
}

class CheckoutCardListState extends State<CheckoutCardList> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartListBloc, GetCartListState>(
      builder: (context, state) {
        if (state is GetCartListDone) {
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
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return CheckoutCard(data: state.data[index]);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 80,
                  color: UsedColors.customGrey,
                ),
                SizedBox(height: 20),
                Text(
                  "Cart is Empty",
                  style: TextStyle(
                    fontSize: 24,
                    color: UsedColors.customGrey,
                  ),
                )
              ],
            );
          }
        } else if (state is GetCartListFailed) {
          return Center(child: Text(state.errorMessage));
        } else if (state is GetCartListLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );
  }
}
