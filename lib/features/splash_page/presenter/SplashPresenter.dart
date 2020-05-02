import 'package:aemet_radar/preferences/WeatherTownPreferences.dart';

import '../SplashView.dart';

class SplashPresenter {
  final SplashView view;

  SplashPresenter(this.view);

  void loadPreferredProvince() async {
    final weatherPreferences = await WeatherTownPreferences.instance();
    final locationCode = weatherPreferences.retrievePreferredWeatherTown();
    view.onPreferredProvinceLoaded(locationCode);
  }
}