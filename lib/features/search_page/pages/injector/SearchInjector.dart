import 'package:aemet_radar/features/search_page/pages/presenter/SearchPresenter.dart';
import 'package:aemet_radar/features/search_page/router/SearchRouter.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

import '../SearchView.dart';

SearchPresenter injectSearchPresenter(SearchRouter router) =>
    SearchPresenter(AemetRepository(), router);
