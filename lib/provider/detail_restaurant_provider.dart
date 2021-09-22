import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/detail_restaurant.dart';

enum ResourceState { Loading, NoData, HasData, Error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  DetailRestaurantProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchDetailRestaurant();
  }

  late DetailRestaurantResult _detailRestaurantResult;

  String _message = '';
  late ResourceState _state;

  String get message => _message;
  ResourceState get state => _state;

  DetailRestaurantResult get restaurantsResult => _detailRestaurantResult;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResourceState.Loading;
      notifyListeners();

      final data = await apiService.detailRestaurant(restaurantId);
      _state = ResourceState.HasData;
      notifyListeners();
      return _detailRestaurantResult = data;
    } on SocketException catch (_) {
      _state = ResourceState.Error;
      notifyListeners();
      return _message =
          "Problem with your internet connection, please try again";
    } catch (e) {
      _state = ResourceState.Error;
      notifyListeners();
      return _message = "Error: $e";
    }
  }
}
