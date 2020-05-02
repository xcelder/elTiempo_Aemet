import 'package:aemet_radar/values/AppColors.dart';
import 'package:aemet_radar/values/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget build() {
  final titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 34,
    fontWeight: FontWeight.w400,
    shadows: [
      Shadow(color: Colors.black45, offset: Offset(1, 1)),
    ],
  );

  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [nightSky, blueSky],
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title1,
            style: titleTextStyle,
          ),
          Text(
            title2,
            style: titleTextStyle.copyWith(fontSize: 24),
          ),
        ],
      ),
    ),
  );
}