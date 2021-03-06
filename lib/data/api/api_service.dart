import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restauran_app/data/model/detail_restaurant.dart';
import 'package:restauran_app/data/model/list_restaurant.dart';
import 'package:restauran_app/data/model/review_restaurant.dart';
import 'package:restauran_app/data/model/search_restaurant.dart';

class ApiService {
  static final String urlImageSmall =
      "https://restaurant-api.dicoding.dev/images/small/";
  static final String urlImageMedium =
      "https://restaurant-api.dicoding.dev/images/medium/";

  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String _apiKey = "12345";

  Future<RestaurantResult> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<DetailRestaurantResult> detailRestaurant(String restaurantId) async {
    final response =
        await http.get(Uri.parse(_baseUrl + 'detail/' + restaurantId));

    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchRestaurantResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=$query'));

    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<ReviewRestaurantResult> postReview({
    required String restaurantId,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl + 'review'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Auth-Token': _apiKey,
      },
      body: jsonEncode(
        <String, String>{'id': restaurantId, 'name': name, 'review': review},
      ),
    );

    if (response.statusCode == 200) {
      return ReviewRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to submit restaurant review');
    }
  }
}
