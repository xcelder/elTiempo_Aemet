import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/values/ProvincesWithCodes.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _provinceRadarKey = "key:ProvinceRadar";
const String _weatherTownKey = "key:WeatherTown";

class RadarPreferences {
  final SharedPreferences preferences;

  RadarPreferences._(this.preferences);

  static Future<RadarPreferences> instance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return RadarPreferences._(prefs);
  }

  void saveProvinceRadar(Province province) {
    preferences.setString(_provinceRadarKey, province.code);
  }

  Province retrievePreferredProvinceRadar() {
    String savedCode = preferences.getString(_provinceRadarKey);
    return provinces.firstWhere(
      (province) => province.code == savedCode,
      orElse: () => provinces.first,
    );
  }
}
