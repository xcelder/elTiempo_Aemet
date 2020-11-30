import 'package:aemet_radar/features/radar/presenter/RadarPresenter.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

import '../RadarView.dart';

RadarPresenter injectRadarPresenter(RadarView view) =>
    RadarPresenter(view, AemetRepository());
