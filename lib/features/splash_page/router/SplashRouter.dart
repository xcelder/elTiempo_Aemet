
import 'package:aemet_radar/features/main_page/container/MainPageContainer.dart';
import 'package:aemet_radar/features/search_page/container/SearchPageContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashRouter {
  final NavigatorState navigator;

  SplashRouter(this.navigator);

  void navigateToSearch() {
    navigator.pushReplacement(MaterialPageRoute(builder: (context) => SearchPageContainer()));
  }

  void navigateToMain(String locationCode) {
    navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => MainPageContainer(locationCode)));
  }
}
