import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restauran_app/style/colors.dart';

//Card style
BoxDecoration cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    boxShadow: [
      BoxShadow(blurRadius: 10, spreadRadius: 5, color: greyColor.withAlpha(70))
    ],
  );
}

//Search form style
OutlineInputBorder searchTextFieldFormStyle() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide:
        BorderSide(color: Colors.white, width: 0, style: BorderStyle.solid),
  );
}
