import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/restaurant.dart';

enum ResourceState {
  Loading, NoData, HasData, Error
}

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchRestaurants();
  }

  late RestaurantResult _restaurantResult;

  String _message = '';
  late ResourceState _state;

  String get message => _message;
  ResourceState get state => _state;

  RestaurantResult get restaurantsResult => _restaurantResult;

  Future<dynamic> _fetchRestaurants() async {
    try {

      _state = ResourceState.Loading;
      notifyListeners();

      final data = await apiService.listRestaurant();
      if (data.restaurants.isEmpty) {
        _state = ResourceState.NoData;
        notifyListeners();
        return _message = "Empty data";
      } else {
        _state = ResourceState.HasData;
        notifyListeners();
        return _restaurantResult = data;
      }

    } on SocketException catch (_) {
      _state = ResourceState.Error;
      notifyListeners();
      return _message = "Problem with your internet connection, please try again";
    } catch (e) {
      _state = ResourceState.Error;
      notifyListeners();
      return _message = "Error: $e";
    }
  }
}