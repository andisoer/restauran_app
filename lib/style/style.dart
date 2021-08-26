import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restauran_app/style/colors.dart';

BoxDecoration cardDecoration() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      boxShadow: [
        BoxShadow(
            blurRadius: 10, spreadRadius: 1, color: greyColor.withAlpha(70))
      ]);
}