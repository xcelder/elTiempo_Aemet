import 'package:aemet_radar/model/RadarImage.dart';

abstract class RadarView {

  void onRadarImagesLoaded(List<RadarImage> radarImages);
}