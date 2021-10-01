import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:restauran_app/data/model/detail_restaurant.dart';
import 'package:restauran_app/data/model/list_restaurant.dart';

void main() {
  group('Parsing JSON', () {
    test('Parsing Restaurant JSON List', () async {
      final testFileRestaurant =
          File('test/test_resource/restaurant.json').readAsStringSync();
      final restaurant = RestaurantResult.fromJson(
          jsonDecode(testFileRestaurant) as Map<String, dynamic>);

      expect(restaurant.error, false);
      expect(restaurant.message, "success");
      expect(restaurant.restaurants.length, 1);
      expect(restaurant.restaurants[0].name, "Melting Pot");
    });

    test('Parsing Restaurant JSON Detail', () async {
      final testFileRestaurant =
          File('test/test_resource/restaurant_detail.json').readAsStringSync();
      final restaurant = DetailRestaurantResult.fromJson(
          jsonDecode(testFileRestaurant) as Map<String, dynamic>);

      expect(restaurant.error, false);
      expect(restaurant.message, "success");
      expect(restaurant.restaurant.name, "Melting Pot");
    });
  });
}
