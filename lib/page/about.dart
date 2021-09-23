import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static final routeName = 'about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Restaurant App',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text('Develop by: Andi Surya'),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      'This app was created to complete \'Belajar Fundamental Aplikasi Flutter\' courses',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
