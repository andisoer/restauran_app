import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restauran_app/data/restaurant.dart';
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
  List<Restaurant> unfilteredRestaurants = [];

  late Future _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSearchbar(),
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildSearchbar() {
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: greyColor.withAlpha(70),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ],
          ),
          child: TextFormField(
            initialValue: widget.searchQuery,
            onChanged: (query) => _searchRestaurants(query),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (restaurants.length > 0) {
              return Center(
                child: Text('Failed to find restaurant you searched for :('),
              );
              // return ListView.builder(
              //   shrinkWrap: true,
              //   itemBuilder: (context, index) {
              //     return buildRestaurantItem(
              //       context,
              //       restaurants[index],
              //     );
              //   },
              //   itemCount: restaurants.length,
              // );
            } else {
              return Center(
                child: Text('Failed to find restaurant you searched for :('),
              );
            }
          },
        ),
      ),
    );
  }

  Future loadRestaurants() async {
    var loadedRestaurantAssets =
        json.decode(await rootBundle.loadString('assets/restaurants.json'));

    var restaurantList = parseRestaurantsFromJson(loadedRestaurantAssets);

    setState(() {
      restaurants = restaurantList;
      unfilteredRestaurants = restaurantList;
    });

    return restaurantList;
  }

  void _searchRestaurants(String query) {
    if (query.isEmpty) {
      setState(() {
        restaurants = unfilteredRestaurants;
      });
    } else {
      var filteredRestaurant = restaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        restaurants = filteredRestaurant;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _future = loadRestaurants();
    _future.then((_) => _searchRestaurants(widget.searchQuery));
  }
}
