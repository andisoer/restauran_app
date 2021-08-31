import 'dart:convert';

List<Restaurant> parseRestaurantsFromJsonString(String? json) {
  if (json == null) {
    return [];
  }

  var restaurants = parseFromJson(json);
  return restaurants.restaurants;
}

List<Restaurant> parseRestaurantsFromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return [];
  }

  var restaurants = Restaurants.fromJson(json);
  return restaurants.restaurants;
}

Restaurants parseFromJson(String str) => Restaurants.fromJson(json.decode(str));

class Restaurants {
  Restaurants({
    required this.restaurants,
  });

  late List<Restaurant> restaurants;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Menus menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
    menus: Menus.fromJson(json["menus"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
    "menus": menus.toJson(),
  };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Drink> foods;
  List<Drink> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}

class Drink {
  Drink({
    required this.name,
  });

  String name;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
