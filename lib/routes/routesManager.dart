// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_modul_fe/views/borrowed_page/borrowed_page_runner.dart';
import 'package:flutter_modul_fe/views/checkout_page/checkout_page_runner.dart';
import 'package:flutter_modul_fe/views/detail_page/detail_page_runner.dart';
import 'package:flutter_modul_fe/views/home.dart';
import 'package:flutter_modul_fe/views/login_page/login_page_runner.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPageRunner());
      case '/home':
        return MaterialPageRoute(builder: (context) => Home());
      case '/detail':
        return MaterialPageRoute(
          builder: (context) => DetailPageRunner(
            bookId: (settings.arguments) as int,
          ),
        );
      case '/cart':
        return MaterialPageRoute(builder: (context) => CheckoutPageRunner());
      case '/borrowed':
        return MaterialPageRoute(builder: (context) => BorrowedPageRunner());
      default:
        return MaterialPageRoute(builder: (context) => LoginPageRunner());
    }
  }
}
