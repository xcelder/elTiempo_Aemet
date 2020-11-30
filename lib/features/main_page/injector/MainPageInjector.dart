import 'package:aemet_radar/features/main_page/MainPageView.dart';
import 'package:aemet_radar/features/main_page/presenter/MainPagePresenter.dart';
import 'package:aemet_radar/features/main_page/view_state/MainPageViewState.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

MainPagePresenter injectMainPagePresenter(
  MainPageView view,
  MainPageViewState viewState,
) =>
    MainPagePresenter(AemetRepository(), view, viewState);
