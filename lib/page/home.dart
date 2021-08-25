import 'package:flutter/material.dart';
import 'package:restauran_app/data/restaurant.dart';
import 'package:restauran_app/page/detail.dart';
import 'package:restauran_app/page/search.dart';
import 'package:restauran_app/style/colors.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(245),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeader(context),
                FutureBuilder<String>(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/restaurants.json'),
                    builder: (context, snapshot) {
                      final restaurants =
                          parseRestaurantsFromJson(snapshot.data);
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildRestaurantItem(
                              context, restaurants[index]);
                        },
                        itemCount: restaurants.length,
                      );
                    })
              ],
            ),
          ),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ))
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 24),
            child: Text(
              'Browse the best restaurant in town !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
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

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: greyColor.withAlpha(70),
                  spreadRadius: 1,
                  blurRadius: 10)
            ]),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
          },
          child: Row(
            children: [
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(restaurant.pictureId),
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            restaurant.city,
                            style: TextStyle(color: Colors.grey),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: primaryColor,
                              size: 16,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                restaurant.rating.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: primaryColor,
                ),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder searchTextFieldFormStyle() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: Colors.white, width: 0, style: BorderStyle.solid));
  }
}
