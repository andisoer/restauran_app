import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:restauran_app/data/model/list_restaurant.dart';

void main() {
  group('Parsing Testing', () {
    test('Test Parsing JSON 1', () {
      final testFileRestaurant = File('test/test_resource/restaurant.json').readAsStringSync();
      final restaurant = RestaurantResult.fromJson(jsonDecode(testFileRestaurant) as Map<String, dynamic>);

      expect(restaurant.error, false);
      expect(restaurant.message, "success");
      expect(restaurant.restaurants.length, 1);

      // final restaurant = Restaurant(
      //   id: '1',
      //   name: 'Warung',
      //   description: 'Deskripsi',
      //   pictureId: 'PictureId',
      //   city: 'City',
      //   rating: 0,
      // );
      //
      // expect(restaurant.id, '1');
      // expect(restaurant.name, 'Warung');
      // expect(restaurant.description, 'Deskripsi');
      // expect(restaurant.pictureId, 'PictureId');
      // expect(restaurant.city, 'City');
      // expect(restaurant.rating, 0);
    });
  });
}
