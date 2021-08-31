import 'package:flutter/material.dart';
import 'package:restauran_app/data/restaurant.dart';
import 'package:restauran_app/page/about.dart';
import 'package:restauran_app/page/detail.dart';
import 'package:restauran_app/page/home.dart';
import 'package:restauran_app/page/search.dart';
import 'package:restauran_app/page/splash.dart';
import 'package:restauran_app/style/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          accentColor: secondaryColor),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        HomePage.routeName: (context) => HomePage(),
        SearchPage.routeName: (context) =>
            SearchPage(ModalRoute.of(context)?.settings.arguments as String),
        DetailPage.routeName: (context) => DetailPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
        AboutPage.routeName: (context) => AboutPage()
      },
    );
  }
}
