import 'dart:async';

import 'package:aemet_radar/features/search_page/router/SearchRouter.dart';
import 'package:aemet_radar/model/LocationWeather.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

import '../../SearchState.dart';

class SearchPresenter {
  final AemetRepository repository;
  final SearchRouter router;

  // ignore: close_sinks
  final _stateController = StreamController<SearchState>();
  Stream<SearchState> get stateStream => _stateController.stream;

  SearchPresenter(this.repository, this.router);

  void searchLocation(String query) {
    _stateController.sink.add(Busy());

    repository.searchLocation(query).listen((result) {
      if (result.didFound) {
        _stateController.sink.add(Busy());
        getWeatherDataOfLocation(result.code);
      } else {
        if (result.options.length > 0) {
          _stateController.sink.add(OptionsResult(result.options));
        } else {
          _stateController.sink
              .add(Error("No se han encontrado resultados para su búsqueda"));
        }
      }
    }, onError: (e) {
      _stateController.sink.add(Error("Datos no disponibles"));
    });
  }

  void getWeatherDataOfLocation(String locationCode) async {
    String weekXmlLink = "";
    String hourlyXmlLink = "";

    try {
      weekXmlLink = await repository.getWeekXmlLink(locationCode).first;
      hourlyXmlLink = await repository.getHourlyXmlLink(locationCode).first;
    } catch(e) {}

    if (weekXmlLink == null ||
        weekXmlLink.isEmpty ||
        hourlyXmlLink == null ||
        hourlyXmlLink.isEmpty) {
      _stateController.sink.add(Error("Datos no disponibles"));
    } else {
      router.navigateToMainPage(
        LocationWeather(
          locationCode,
          weekXmlLink,
          hourlyXmlLink,
        ),
      );
    }
  }

  void dispose() {
    _stateController.close();
  }
}
