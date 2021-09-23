import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/review_restaurant.dart';

enum ResourceReviewRestaurantState { Loading, Success, Error, None }

class ReviewRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewRestaurantProvider({required this.apiService});

  late ReviewRestaurantResult _searchResult;

  String _message = '';
  ResourceReviewRestaurantState _state = ResourceReviewRestaurantState.None;

  String get message => _message;

  ResourceReviewRestaurantState get state => _state;

  ReviewRestaurantResult get searchResult => _searchResult;

  Future<dynamic> postReview(
    String restaurantId,
    String name,
    String review,
  ) async {
    try {
      _state = ResourceReviewRestaurantState.Loading;
      notifyListeners();

      final data = await apiService.postReview(
        restaurantId: restaurantId,
        name: name,
        review: review,
      );
      _state = ResourceReviewRestaurantState.Success;
      notifyListeners();
      return _searchResult = data;
    } on SocketException catch (_) {
      _state = ResourceReviewRestaurantState.Error;
      notifyListeners();
      return _message =
          "Problem with your internet connection, please try again.";
    } catch (e) {
      _state = ResourceReviewRestaurantState.Error;
      notifyListeners();
      return _message = "Error: $e";
    }
  }
}
