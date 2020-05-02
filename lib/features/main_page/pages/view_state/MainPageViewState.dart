import 'dart:async';

import 'package:aemet_radar/features/main_page/pages/state/CurrentWeatherState.dart';
import 'package:flutter/material.dart';

class MainPageViewState extends InheritedWidget {
  final StreamController<CurrentWeatherState> weatherState;

  MainPageViewState(this.weatherState, {Widget child}) : super(child: child);

  static MainPageViewState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MainPageViewState>();

  void updateCurrentWeatherState(CurrentWeatherState state) {
    weatherState.sink.add(state);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  void dispose() {
    weatherState.close();
  }
}
