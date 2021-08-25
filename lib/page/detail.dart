import 'package:flutter/material.dart';
import 'package:restauran_app/data/restaurant.dart';
import 'package:restauran_app/style/colors.dart';

class DetailPage extends StatelessWidget {

  static final routeName = '/detail';

  final Restaurant restaurant;

  const DetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Image.network(restaurant.pictureId),
                ),
                SafeArea(child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withAlpha(100),
                          ),
                        )
                      ],
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
