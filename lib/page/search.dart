import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {

  static final routeName = '/search';

  final String searchQuery;

  const SearchPage(this.searchQuery);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Container(
        child: Center(
          child: Text(searchQuery),
        ),
      ),
    );
  }
}
