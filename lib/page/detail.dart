import 'package:flutter/cupertino.dart';
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
      backgroundColor: Colors.white.withAlpha(245),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Image.network(restaurant.pictureId),
                ),
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor, shape: CircleBorder()),
                  ),
                )),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(restaurant.name),
                      Row(
                        children: [
                          Icon(Icons.star, color: primaryColor),
                          Text(restaurant.rating.toString()),
                          Icon(Icons.location_on, color: primaryColor),
                          Text(restaurant.name)
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text('About')),
                      Text(restaurant.description)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Menus'),
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 4),
                          child: Text('Foods')),
                      Container(
                        height: 33,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: restaurant.menus.foods.length,
                          itemBuilder: (context, index) {
                            var food = restaurant.menus.foods[index];
                            return Container(
                              margin: EdgeInsets.only(right: 8),
                              padding: EdgeInsets.all(8),
                              child: Text(food.name),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(100),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                            );
                          },
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 12, bottom: 4),
                          child: Text('Drinks')),
                      Container(
                        height: 33,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: restaurant.menus.drinks.length,
                          itemBuilder: (context, index) {
                            var drink = restaurant.menus.drinks[index];
                            return Container(
                              margin: EdgeInsets.only(right: 8),
                              padding: EdgeInsets.all(8),
                              child: Text(drink.name),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(100),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
