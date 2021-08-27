import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restauran_app/data/restaurant.dart';
import 'package:restauran_app/page/partials/item_restaurant.dart';
import 'package:restauran_app/style/colors.dart';
import 'package:restauran_app/style/style.dart';

class SearchPage extends StatefulWidget {
  static final routeName = '/search';

  final String searchQuery;

  const SearchPage(this.searchQuery);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Restaurant> restaurants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: primaryColor,
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                          color: greyColor.withAlpha(70),
                          spreadRadius: 1,
                          blurRadius: 10)
                    ]),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Search restaurant...',
                      labelText: null,
                      enabledBorder: searchTextFieldFormStyle(),
                      border: searchTextFieldFormStyle(),
                      focusedBorder: searchTextFieldFormStyle(),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: restaurants.length > 0
                    ? ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return buildRestaurantItem(
                        context, restaurants[index]);
                  },
                  itemCount: restaurants.length,
                )
                    : Center(
                  child: Text('Ooops, no restaurant found !'),
                )),
          )
        ],
      ),
    );
  }

  // void loadRestaurants() {
  //   var stringAsset = DefaultAssetBundle.of(context)
  //       .loadString('assets/restaurants.json');
  //
  //   parseRestaurantsFromJson(stringAsset);
  // }

  @override
  void initState() {
    super.initState();
  }
}
