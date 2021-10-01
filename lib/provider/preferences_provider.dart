import 'package:flutter/material.dart';
import 'package:restauran_app/utils/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreferences();
  }

  bool _isDailyRestauransActive = false;
  bool get isDailyRestaurantsActive => _isDailyRestauransActive;

  void _getDailyRestaurantPreferences() async {
    _isDailyRestauransActive = await preferencesHelper.isDailyRestaurantsActive;
    notifyListeners();
  }

  void enableDailyRestaurants(bool value) {
    preferencesHelper.setDailyRestaurants(value);
    _getDailyRestaurantPreferences();
  }
}
