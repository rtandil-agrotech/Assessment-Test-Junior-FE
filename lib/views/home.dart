// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modul_fe/routes/routesManager.dart';
import 'package:flutter_modul_fe/views/borrowed_page/borrowed_page_runner.dart';
import 'package:flutter_modul_fe/views/checkout_page/checkout_page_runner.dart';
import 'package:flutter_modul_fe/views/detail_page/detail_page_runner.dart';
import 'package:flutter_modul_fe/views/home_page/home_page_runner.dart';
import 'package:flutter_modul_fe/views/login_page/login_page_runner.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  bool hideNavbar = false;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
      hideNavigationBar: hideNavbar,
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomePageRunner(),
      CheckoutPageRunner(),
      BorrowedPageRunner(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          // onGenerateRoute: RouteManager.generateRoute,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(builder: (context) => Home());
              case '/detail':
                setState(() {
                  hideNavbar = true;
                });

                return MaterialPageRoute(
                  builder: (context) => DetailPageRunner(
                    bookId: (settings.arguments) as int,
                  ),
                );
              default:
                return MaterialPageRoute(
                  builder: (context) => LoginPageRunner(),
                );
            }
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_bag_outlined),
        title: ("Checkout"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          // onGenerateRoute: RouteManager.generateRoute,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(builder: (context) => Home());
              case '/cart':
                return MaterialPageRoute(
                    builder: (context) => CheckoutPageRunner());
              case '/detail':
                setState(() {
                  hideNavbar = true;
                });

                return MaterialPageRoute(
                  builder: (context) => DetailPageRunner(
                    bookId: (settings.arguments) as int,
                  ),
                );
              default:
                return MaterialPageRoute(
                    builder: (context) => LoginPageRunner());
            }
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.collections_bookmark_outlined),
        title: ("Borrowed"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          // onGenerateRoute: RouteManager.generateRoute,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(builder: (context) => Home());
              case '/borrowed':
                return MaterialPageRoute(
                    builder: (context) => BorrowedPageRunner());
              case '/detail':
                setState(() {
                  hideNavbar = true;
                });

                return MaterialPageRoute(
                  builder: (context) => DetailPageRunner(
                    bookId: (settings.arguments) as int,
                  ),
                );
              default:
                return MaterialPageRoute(
                    builder: (context) => LoginPageRunner());
            }
          },
        ),
      ),
    ];
  }
}
