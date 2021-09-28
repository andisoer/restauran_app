import 'package:flutter/foundation.dart';
import 'package:restauran_app/data/local/db/database_helper.dart';
import 'package:restauran_app/data/model/list_restaurant.dart';

enum ResourceState {
  Loading, NoData, HasData, Error
}

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper});

  late ResourceState _state;
  ResourceState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();

    if (_favorites.length > 0) {
      _state = ResourceState.HasData;
    } else {
      _state = ResourceState.NoData;
      _message = 'No favorited restaurant';
    }

    notifyListeners();
  }

  void addBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResourceState.Error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteRestaurantById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {

    } catch (e) {
      _state = ResourceState.Error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}