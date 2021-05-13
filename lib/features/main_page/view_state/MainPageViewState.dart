import 'package:aemet_radar/features/main_page/state/CurrentWeatherState.dart';
import 'package:flutter/material.dart';

class MainPageViewState with ChangeNotifier {
  CurrentWeatherState weatherState = NoData();

  void updateCurrentWeatherState(CurrentWeatherState state) {
    weatherState = state;
    notifyListeners();
  }
}
