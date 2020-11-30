import 'dart:async';

import 'package:aemet_radar/features/main_page/utils/TownProvider.dart' as TownProvider;
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
  }
}
