import 'package:aemet_radar/model/LocationWeather.dart';

class SearchRouter {
  final Function(LocationWeather) onRoute;

  SearchRouter(this.onRoute);

  void navigateToMainPage(LocationWeather locationWeather) {
    onRoute(locationWeather);
  }
}