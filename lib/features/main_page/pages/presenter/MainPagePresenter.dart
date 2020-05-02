import 'dart:async';

import 'package:aemet_radar/features/main_page/pages/MainPageView.dart';
import 'package:aemet_radar/preferences/RadarPreferences.dart';
import 'package:aemet_radar/features/main_page/pages/state/CurrentWeatherState.dart';
import 'package:aemet_radar/features/main_page/pages/view_state/MainPageViewState.dart';
import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

class MainPagePresenter {
  final AemetRepository repository;
  final MainPageView view;

  final MainPageViewState viewState;

  MainPagePresenter(this.repository, this.view, this.viewState);

  void loadWeatherData(String locationCode) {
    viewState.updateCurrentWeatherState(Busy());

    repository.getFullPredictionForLocation(locationCode).listen(
      (data) {
        viewState.updateCurrentWeatherState(Result(data));
      },
      onError: (error) {
        viewState.updateCurrentWeatherState(Error());
      },
    );
  }

  void loadPreferredProvince() async {
    final radarPreferences = await RadarPreferences.instance();
    final preferredRadar = radarPreferences.retrievePreferredProvinceRadar();
    view.onPreferredProvinceLoaded(preferredRadar);
  }

  void savePreferredProvince(Province selectedProvince) async {
    final radarPreferences = await RadarPreferences.instance();
    radarPreferences.saveProvinceRadar(selectedProvince);
  }

  void dispose() {
    viewState.dispose();
  }
}
