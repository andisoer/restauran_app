import 'package:flutter/material.dart';
import 'package:restauran_app/data/restaurant.dart';
import 'package:restauran_app/page/partials/item_restaurant.dart';
import 'package:restauran_app/page/search.dart';
import 'package:restauran_app/style/colors.dart';
import 'package:restauran_app/style/style.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(245),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 210,
              decoration: BoxDecoration(color: primaryColor),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [_buildHeader(context), _buildList(context)],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        "https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY",
                      ))),
            ),
            Container(
                margin: EdgeInsets.only(left: 16),
                child: Text(
                  'Welcome !',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ))
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 24),
            child: Text(
              'Browse the best restaurant in town !',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )),
        Container(
          margin: EdgeInsets.only(top: 16),
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
            onFieldSubmitted: (query) => {
              Navigator.pushNamed(context, SearchPage.routeName,
                  arguments: query)
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: greyColor,
              ),
              hintText: 'Search restaurant...',
              labelText: null,
              enabledBorder: searchTextFieldFormStyle(),
              border: searchTextFieldFormStyle(),
              focusedBorder: searchTextFieldFormStyle(),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 24, bottom: 8),
            child: Text('Explore',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/restaurants.json'),
        builder: (context, snapshot) {
          final restaurants = parseRestaurantsFromJsonString(snapshot.data);
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildRestaurantItem(context, restaurants[index]);
            },
            itemCount: restaurants.length,
          );
        });
  }
}
