import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/provider/database_provider.dart';
import 'package:restauran_app/style/colors.dart';
import 'package:restauran_app/widget/common.dart';
import 'package:restauran_app/widget/item_restaurant.dart';

class FavoritePage extends StatelessWidget {
  static final routeName = 'favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        if (state.state == LocalResourceState.Loading) {
          return circularProgressIndicator();
        } else if (state.state == LocalResourceState.HasData) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildRestaurantItem(
                context,
                state.favorites[index],
              );
            },
            itemCount: state.favorites.length,
          );
        } else if (state.state == LocalResourceState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == LocalResourceState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

}
