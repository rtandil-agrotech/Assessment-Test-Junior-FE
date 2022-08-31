// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_modul_fe/views/login_page/login_page_ui.dart';

class LoginPageRunner extends StatefulWidget {
  const LoginPageRunner({Key? key}) : super(key: key);

  @override
  LoginPageRunnerState createState() => LoginPageRunnerState();
}

class LoginPageRunnerState extends State<LoginPageRunner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity, 475),
      //   child: Image.asset(
      //     "images/library-bg.jpg",
      //     fit: BoxFit.fill,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              // "images/library-bg.jpg"
              "assets/images/library-bg.jpg",
              fit: BoxFit.fill,
              width: double.infinity,
              height: 475,
            ),
            SizedBox(height: 56),
            LoginPageUi(),
          ],
        ),
      ),
    );
  }
}
