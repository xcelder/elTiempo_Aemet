
import 'dart:async';

import 'package:aemet_radar/features/main_page/pages/state/CurrentWeatherState.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

class MainPagePresenter {
  final AemetRepository repository;

  MainPagePresenter(this.repository);

  final StreamController<CurrentWeatherState> _stateController = StreamController();

  Stream<CurrentWeatherState> get currentWeatherStateStream => _stateController.stream;

  void dispose() {
    _stateController.close();
  }

}