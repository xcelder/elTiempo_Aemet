import 'package:aemet_radar/model/LocationOption.dart';

class SearchRouter {
  final Function(LocationOption) onRoute;

  SearchRouter(this.onRoute);

  void navigateToMainPage(LocationOption locationOption) {
    onRoute(locationOption);
  }
}