import 'package:restauran_app/data/model/list_restaurant.dart';

class SearchRestaurantResult {
  SearchRestaurantResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory SearchRestaurantResult.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map(
            (x) => Restaurant.fromJson(x),
          ),
        ),
      );
}
