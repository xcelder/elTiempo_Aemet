import 'dart:async';

import 'package:aemet_radar/features/main_page/state/CurrentWeatherState.dart';
import 'package:aemet_radar/features/main_page/view_state/MainPageViewState.dart';
import 'package:flutter/material.dart';

import '../MainPage.dart';


class MainPageContainer extends StatefulWidget {

  final String locationCode;

  MainPageContainer(this.locationCode);

  @override
  _MainPageContainerState createState() => _MainPageContainerState();
}

class _MainPageContainerState extends State<MainPageContainer> {

  final weatherStateController = StreamController<CurrentWeatherState>();

  @override
  void dispose() {
    weatherStateController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPageViewState(
        weatherStateController,
        child: MainPage(widget.locationCode),
      ),
    );
  }
}
