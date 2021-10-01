import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/page/detail.dart';
import 'package:restauran_app/page/favorite.dart';
import 'package:restauran_app/utils/notification_helper.dart';
import 'package:restauran_app/widget/common.dart';
import 'package:restauran_app/page/about.dart';
import 'package:restauran_app/widget/item_restaurant.dart';
import 'package:restauran_app/page/search.dart';
import 'package:restauran_app/provider/list_restaurant_provider.dart';
import 'package:restauran_app/style/colors.dart';
import 'package:restauran_app/style/style.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

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
              decoration: BoxDecoration(
                color: primaryColor,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildHeader(context),
                    _buildList(context),
                  ],
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
                    "https://picsum.photos/id/1005/300/300",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16),
                child: Text(
                  'Welcome !',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, FavoritePage.routeName);
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 24),
          child: Text(
            'Browse the best restaurant in town !',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
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
            onFieldSubmitted: (query) => {
              Navigator.pushNamed(
                context,
                SearchPage.routeName,
                arguments: query,
              )
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
          child: Text(
            'Explore',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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

  @override
  void initState() {
    _notificationHelper.configureSelectNotificationSubject(DetailPage.routeName);
    super.initState();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
