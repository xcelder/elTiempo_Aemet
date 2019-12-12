import 'package:aemet_radar/features/main_page/pages/presenter/MainPagePresenter.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

MainPagePresenter injectMainPagePresenter() =>
    MainPagePresenter(AemetRepository());
