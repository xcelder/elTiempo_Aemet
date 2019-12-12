import 'package:aemet_radar/features/main_page/pages/presenter/RadarPresenter.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

import '../RadarView.dart';

RadarPresenter injectRadarPresenter(RadarView view) =>
    RadarPresenter(view, AemetRepository());
