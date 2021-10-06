import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/common/common.dart';
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
import 'package:restauran_app/provider/preferences_provider.dart';
import 'package:restauran_app/provider/review_restaurant_provider.dart';
import 'package:restauran_app/provider/scheduling_provider.dart';
import 'package:restauran_app/provider/search_restaurant_provider.dart';
import 'package:restauran_app/style/colors.dart';
import 'package:restauran_app/utils/background_service.dart';
import 'package:restauran_app/utils/notification_helper.dart';
import 'package:restauran_app/utils/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewRestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          accentColor: secondaryColor,
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => SplashPage(),
          HomePage.routeName: (context) => HomePage(),
          SearchPage.routeName: (context) => ChangeNotifierProvider(
                create: (_) => SearchRestaurantProvider(
                  apiService: ApiService(),
                  query: ModalRoute.of(context)?.settings.arguments as String,
                ),
                child: SearchPage(
                  ModalRoute.of(context)?.settings.arguments as String,
                ),
              ),
          DetailPage.routeName: (context) => ChangeNotifierProvider(
                create: (_) => DetailRestaurantProvider(
                    apiService: ApiService(),
                    restaurantId:
                        ModalRoute.of(context)?.settings.arguments as String),
                child: DetailPage(),
              ),
          AboutPage.routeName: (context) => AboutPage(),
          FavoritePage.routeName: (context) => FavoritePage(),
        },
      ),
    );
  }
}
