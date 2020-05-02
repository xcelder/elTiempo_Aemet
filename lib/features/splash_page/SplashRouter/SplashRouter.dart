import 'dart:async';

import 'package:aemet_radar/features/main_page/pages/MainPage.dart';
import 'package:aemet_radar/features/main_page/pages/state/CurrentWeatherState.dart';
import 'package:aemet_radar/features/main_page/pages/view_state/MainPageViewState.dart';
import 'package:aemet_radar/features/search_page/navigation/MainSearchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashRouter {
  final NavigatorState navigator;

  SplashRouter(this.navigator);

  void navigateToSearch() {
    navigator.pushReplacement(MaterialPageRoute(builder: (context) => MainSearchPage()));
  }

  void navigateToMain(String locationCode) {
    navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => MainPageViewState(
          StreamController<CurrentWeatherState>(),
          child: MainPage(locationCode),
        )));
  }
}
