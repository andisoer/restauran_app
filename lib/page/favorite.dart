import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/provider/list_restaurant_provider.dart';
import 'package:restauran_app/style/colors.dart';
import 'package:restauran_app/widget/common.dart';
import 'package:restauran_app/widget/item_restaurant.dart';

class FavoritePage extends StatelessWidget {
  static final routeName = 'favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurant'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () {},
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<ListRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResourceState.Loading) {
          return circularProgressIndicator();
        } else if (state.state == ResourceState.HasData) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildRestaurantItem(
                context,
                state.restaurantsResult.restaurants[index],
              );
            },
            itemCount: state.restaurantsResult.restaurants.length,
          );
        } else if (state.state == ResourceState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResourceState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

}
