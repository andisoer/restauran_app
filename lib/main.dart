import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/local/db/database_helper.dart';
import 'package:restauran_app/page/about.dart';
import 'package:restauran_app/page/detail.dart';
import 'package:restauran_app/page/favorite.dart';
import 'package:restauran_app/page/home.dart';
import 'package:restauran_app/page/search.dart';
import 'package:restauran_app/page/splash.dart';
import 'package:restauran_app/provider/database_provider.dart';
import 'package:restauran_app/provider/detail_restaurant_provider.dart';
import 'package:restauran_app/provider/list_restaurant_provider.dart';
import 'package:restauran_app/provider/review_restaurant_provider.dart';
import 'package:restauran_app/provider/search_restaurant_provider.dart';
import 'package:restauran_app/style/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        accentColor: secondaryColor,
      ),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        HomePage.routeName: (context) => ChangeNotifierProvider(
              create: (_) => ListRestaurantProvider(apiService: ApiService()),
              child: HomePage(),
            ),
        SearchPage.routeName: (context) => ChangeNotifierProvider(
              create: (_) => SearchRestaurantProvider(
                apiService: ApiService(),
                query: ModalRoute.of(context)?.settings.arguments as String,
              ),
              child: SearchPage(
                ModalRoute.of(context)?.settings.arguments as String,
              ),
            ),
        DetailPage.routeName: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => DetailRestaurantProvider(
                      apiService: ApiService(),
                      restaurantId:
                          ModalRoute.of(context)?.settings.arguments as String),
                ),
                ChangeNotifierProvider(
                  create: (_) => ReviewRestaurantProvider(
                    apiService: ApiService(),
                  ),
                )
              ],
              child: DetailPage(),
            ),
        AboutPage.routeName: (context) => AboutPage(),
        FavoritePage.routeName: (context) => ChangeNotifierProvider(
              create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
              child: FavoritePage(),
            ),
      },
    );
  }
}
