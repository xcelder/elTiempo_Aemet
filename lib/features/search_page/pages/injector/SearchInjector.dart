import 'package:aemet_radar/features/search_page/pages/presenter/SearchPresenter.dart';
import 'package:aemet_radar/features/search_page/router/SearchRouter.dart';
import 'package:aemet_radar/features/search_page/view_state/SearchViewState.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

SearchPresenter injectSearchPresenter(
  SearchViewState searchViewState,
) =>
    SearchPresenter(AemetRepository(), searchViewState);
