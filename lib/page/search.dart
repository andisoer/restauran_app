import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/page/partials/item_restaurant.dart';
import 'package:restauran_app/provider/search_restaurant_provider.dart';
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
            onFieldSubmitted: (query) => _searchRestaurants(query),
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
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResourceState.Loading) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else if (state.state == ResourceState.HasData) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 8),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return buildRestaurantItem(
                    context,
                    state.searchResult.restaurants[index],
                  );
                },
                itemCount: state.searchResult.restaurants.length,
              ),
            );
          } else if (state.state == ResourceState.NoData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResourceState.Error) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }

  void _searchRestaurants(String query) {
    Provider.of<SearchRestaurantProvider>(context, listen: false)
        .searchRestaurant(query);
  }

  @override
  void initState() {
    super.initState();
  }
}
