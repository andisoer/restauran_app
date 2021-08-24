import 'package:flutter/material.dart';
import 'package:restauran_app/page/home.dart';
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
        accentColor: secondaryColor
      ),
      home: HomePage(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage()
      },
    );
  }
}
