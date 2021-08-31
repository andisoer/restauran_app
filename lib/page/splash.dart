import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restauran_app/page/home.dart';
import 'package:restauran_app/style/colors.dart';

class SplashPage extends StatefulWidget {
  static final routeName = 'splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: FlutterLogo(
          size: 100,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),
        () => {Navigator.pushNamed(context, HomePage.routeName)});
  }
}
