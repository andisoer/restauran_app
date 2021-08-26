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
            _buildHeader(context),
            _buildContent(context)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.network(restaurant.pictureId),
        ),
        SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 4),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Icon(Icons.arrow_back_ios, size: 16,),
                ),
                style: ElevatedButton.styleFrom(
                    primary: primaryColor, shape: CircleBorder()),
              ),
            )),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -30.0, 0),
      child: Column(
        children: [
          _buildAbout(context),
          _buildMenu(context)
        ],
      ),
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 1,
                color: greyColor.withAlpha(70))
          ]),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name,
              style: Theme.of(context).textTheme.headline4),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Icon(Icons.star, color: primaryColor, size: 16),
                  Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Text(restaurant.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .caption)),
                  Container(
                      margin: EdgeInsets.only(left: 12),
                      child: VerticalDivider(
                        thickness: 1.5,
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Icon(Icons.location_on,
                          color: primaryColor, size: 16)),
                  Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Text(restaurant.city,
                          style: Theme.of(context)
                              .textTheme
                              .caption))
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 14),
              child: Text('About',
                  style: Theme.of(context).textTheme.headline6)),
          Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(restaurant.description,
                  style: Theme.of(context).textTheme.bodyText2))
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 1,
                color: greyColor.withAlpha(70))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menus',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
              margin: EdgeInsets.only(top: 8, bottom: 4),
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
                  child: Text(food.name,
                      style:
                      TextStyle(fontWeight: FontWeight.w300)),
                  decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(25),
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
                  child: Text(drink.name,
                      style:
                      TextStyle(fontWeight: FontWeight.w300)),
                  decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(25),
                      borderRadius:
                      BorderRadius.all(Radius.circular(4))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
