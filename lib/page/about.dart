import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/provider/preferences_provider.dart';
import 'package:restauran_app/provider/scheduling_provider.dart';
import 'package:restauran_app/style/colors.dart';
import 'package:restauran_app/widget/custom_dialog.dart';

class AboutPage extends StatelessWidget {
  static final routeName = 'about';

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
          'About',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Restaurant App',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text('Develop by: Andi Surya'),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      'This app was created to complete \'Belajar Fundamental Aplikasi Flutter\' courses',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Setting',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Daily Restaurant Reminder'),
                      Consumer<PreferencesProvider>(
                        builder: (context, provider, child) {
                          return Consumer<SchedulingProvider>(
                            builder: (context, scheduled, _) {
                              return Switch.adaptive(
                                value: provider.isDailyRestaurantsActive,
                                onChanged: (value) async {
                                  if (Platform.isIOS) {
                                    customDialog(context);
                                  } else {
                                    scheduled.scheduledRestaurant(value);
                                    provider.enableDailyRestaurants(value);
                                  }
                                },
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
