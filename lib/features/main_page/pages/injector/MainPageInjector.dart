import 'package:aemet_radar/features/main_page/pages/MainPageView.dart';
import 'package:aemet_radar/features/main_page/pages/presenter/MainPagePresenter.dart';
import 'package:aemet_radar/features/main_page/pages/view_state/MainPageViewState.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

MainPagePresenter injectMainPagePresenter(
  MainPageView view,
  MainPageViewState viewState,
) =>
    MainPagePresenter(AemetRepository(), view, viewState);
