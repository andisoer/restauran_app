import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restauran_app/style/colors.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                                "https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY",
                              ))),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          'Welcome !',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Text(
                      'Explore the best restaurant in town !',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: greyColor.withAlpha(70),
                            spreadRadius: 1,
                            blurRadius: 10)
                      ]),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: greyColor,
                      ),
                      hintText: 'Search restaurant . . .',
                      labelText: null,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                              style: BorderStyle.solid)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                              style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                              style: BorderStyle.solid)),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Text('Explore',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
