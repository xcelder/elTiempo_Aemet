import 'package:aemet_radar/model/Province.dart';

abstract class MainPageView {
  void onPreferredProvinceLoaded(Province selectedProvince);
}