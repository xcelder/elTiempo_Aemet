import 'dart:async';

import 'package:aemet_radar/features/main_page/pages/utils/TownProvider.dart' as TownProvider;
import 'package:aemet_radar/features/search_page/view_state/SearchViewState.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

import '../../SearchState.dart';

class SearchPresenter {
  final AemetRepository repository;

  final SearchViewState viewState;

  SearchPresenter(this.repository, this.viewState);

  void loadProvinceData() async {
    showLoading();
    final provinceData = await TownProvider.provideLocations();
    viewState.updateState(OptionsResult(provinceData));
  }

  void showLoading() {
    viewState.updateState(Busy());
  }

  void obtainWeatherDataForLocation(String locationCode) {
    viewState.updateState(Busy());


//    repository.searchLocation(query).listen((result) {
//      if (result.didFound) {
//        _stateController.sink.add(Busy());
//        getWeatherDataOfLocation(result.code);
//      } else {
//        if (result.options.length > 0) {
//          _stateController.sink.add(OptionsResult(result.options));
//        } else {
//          _stateController.sink
//              .add(Error("No se han encontrado resultados para su búsqueda"));
//        }
//      }
//    }, onError: (e) {
//      _stateController.sink.add(Error("Datos no disponibles"));
//    });
  }
}
