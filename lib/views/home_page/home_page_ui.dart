// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_modul_fe/views/home_page/widgets/book_card_list.dart';
import 'package:flutter_modul_fe/views/home_page/widgets/searchbox_and_category.dart';

class HomePageUi extends StatefulWidget {
  const HomePageUi({Key? key}) : super(key: key);

  @override
  HomePageUiState createState() => HomePageUiState();
}

class HomePageUiState extends State<HomePageUi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchboxAndCategory(),
        SizedBox(height: 14),
        Expanded(
          child: BookCardList(),
        ),
      ],
    );
  }
}
