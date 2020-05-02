import 'package:aemet_radar/features/main_page/pages/MainPage.dart';
import 'package:aemet_radar/features/search_page/pages/SearchPage.dart';
import 'package:aemet_radar/features/search_page/router/SearchRouter.dart';
import 'package:aemet_radar/features/splash_page/SplashPage.dart';
import 'package:aemet_radar/model/LocationWeather.dart';
import 'package:aemet_radar/values/AppColors.dart';
import 'package:flutter/material.dart';

import 'features/search_page/navigation/MainSearchPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radar',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          fontFamily: "ProductSans",
          textTheme: TextTheme(
            body1: TextStyle(
              fontFamily: "ProductSans",
            ),
            body2: TextStyle(
              fontFamily: "ProductSans",
            ),
            display1: TextStyle(
              fontFamily: "ProductSans",
            ),
          ),
          accentTextTheme: TextTheme(body2: TextStyle(color: Colors.white)),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(),
              labelStyle: TextStyle(fontSize: 24, color: Colors.white)),
          primarySwatch: Colors.lightBlue,
          accentColor: nightSky),
      home: Scaffold(
        body: SplashPage(),
      ),
    );
  }
}
