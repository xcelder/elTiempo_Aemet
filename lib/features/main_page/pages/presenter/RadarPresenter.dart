import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/service/AemetRepository.dart';

import '../RadarView.dart';

class RadarPresenter {
  final RadarView view;
  final AemetRepository repository;

  RadarPresenter(this.view, this.repository);

  void loadRadarImagesOf(Province province) {
    repository
        .getRadarImagesFromNetwork(province)
        .listen((radarImages) {
      view.onRadarImagesLoaded(radarImages);
    }).onError((error) {
      print("error: $error");
    });
  }
}
