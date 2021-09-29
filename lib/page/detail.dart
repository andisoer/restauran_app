import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/data/model/list_restaurant.dart';
import 'package:restauran_app/provider/database_provider.dart';
import 'package:restauran_app/provider/review_restaurant_provider.dart';
import 'package:restauran_app/widget/common.dart';
import 'package:restauran_app/data/api/api_service.dart';
import 'package:restauran_app/data/model/detail_restaurant.dart' as detail;
import 'package:restauran_app/provider/detail_restaurant_provider.dart';
import 'package:restauran_app/style/colors.dart';
import 'package:restauran_app/style/style.dart';

class DetailPage extends StatelessWidget {
  static final routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(245),
      body: Stack(
        children: [
          _buildContent(context),
          _buildNavigation(context),
        ],
      ),
    );
  }

  Widget _buildNavigation(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: primaryColor,
                  size: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: CircleBorder(),
              ),
            ),
            Consumer<DetailRestaurantProvider>(
              builder: (context, provider, child) {
                return FutureBuilder<bool>(
                  future: Provider.of<DatabaseProvider>(
                    context,
                    listen: false,
                  ).isFavorited(provider.restaurantsResult.restaurant.id),
                  builder: (context, snapshot) {
                    var isFavorite = snapshot.data ?? false;
                    return isFavorite
                        ? ElevatedButton(
                            onPressed: () {
                              addBookmark(
                                context,
                                provider.restaurantsResult.restaurant,
                              );
                            },
                            child: Icon(
                              Icons.favorite_border,
                              color: primaryColor,
                              size: 16,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: CircleBorder(),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              Provider.of<DatabaseProvider>(
                                context,
                                listen: false,
                              ).removeFavorite(
                                  provider.restaurantsResult.restaurant.id);
                            },
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: primaryColor,
                              size: 16,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: CircleBorder(),
                            ),
                          );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResourceState.Loading) {
          return circularProgressIndicator();
        } else if (state.state == ResourceState.HasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeaderImage(state.restaurantsResult.restaurant),
                Container(
                  transform: Matrix4.translationValues(0.0, -30.0, 0),
                  child: Column(
                    children: [
                      _buildAbout(context, state.restaurantsResult.restaurant),
                      _buildMenu(context, state.restaurantsResult.restaurant),
                      _buildReview(context, state.restaurantsResult.restaurant)
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state.state == ResourceState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResourceState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Stack _buildHeaderImage(detail.Restaurant restaurant) {
    return Stack(
      children: [
        Hero(
          tag: restaurant.name,
          child: Container(
            child: Image.network(
              ApiService.urlImageSmall + restaurant.pictureId,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAbout(BuildContext context, detail.Restaurant restaurant) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: cardDecoration(),
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headline4,
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: primaryColor,
                    size: 16,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: VerticalDivider(thickness: 1.5),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 16,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Text(
                      restaurant.city,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14),
            child: Text(
              'About',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              restaurant.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context, detail.Restaurant restaurant) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: EdgeInsets.all(12),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menus',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 4),
            child: Text('Foods'),
          ),
          Container(
            height: 33,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.foods.length,
              itemBuilder: (context, index) {
                var food = restaurant.menus.foods[index];
                return _buildMenuItem(food.name);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 4),
            child: Text('Drinks'),
          ),
          Container(
            height: 33,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                var drink = restaurant.menus.drinks[index];
                return _buildMenuItem(drink.name);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReview(BuildContext context, detail.Restaurant restaurant) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      padding: EdgeInsets.all(12),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review',
            style: Theme.of(context).textTheme.headline6,
          ),
          ListView.builder(
            padding: EdgeInsets.only(top: 0),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: restaurant.customerReviews.length,
            itemBuilder: (context, index) {
              var review = restaurant.customerReviews[index];
              return _buildReviewItem(review);
            },
          ),
          TextButton(
            onPressed: () {
              showRatingFormDialog(context, restaurant);
            },
            child: Text('Been here ? Rate this place'),
            style: TextButton.styleFrom(primary: primaryColor),
          )
        ],
      ),
    );
  }

  Widget _buildReviewItem(detail.CustomerReview review) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      "https://picsum.photos/id/1005/300/300",
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        review.date,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              review.review,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String menuName) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(8),
      child: Text(
        menuName,
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
    );
  }

  void showRatingFormDialog(
      BuildContext context, detail.Restaurant restaurant) {
    var name = "";
    var review = "";
    AlertDialog ratingDialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fill rating form',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.cancel, color: greyColor),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text('Name'),
          ),
          TextFormField(
            onChanged: (value) => name = value,
            decoration:
                InputDecoration(labelText: null, hintText: 'Input your name'),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text('Review about ${restaurant.name}'),
          ),
          TextFormField(
            onChanged: (value) => review = value,
            decoration:
                InputDecoration(labelText: null, hintText: 'Input your review'),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
                primary: primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
                submitReview(name, review, restaurant.id, context);
              },
              child: Text('Submit Review'),
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ratingDialog;
      },
    );
  }

  void submitReview(
    String name,
    String review,
    String restaurantId,
    BuildContext context,
  ) {
    Provider.of<ReviewRestaurantProvider>(context, listen: false).postReview(
      restaurantId,
      name,
      review,
    );

    Provider.of<DetailRestaurantProvider>(context, listen: false)
        .fetchDetailRestaurant(restaurantId);
  }

  void addBookmark(BuildContext context, detail.Restaurant restaurant) {
    var restaurantBookmark = Restaurant(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
    );

    Provider.of<DatabaseProvider>(
      context,
      listen: false,
    ).addBookmark(restaurantBookmark);
  }
}
