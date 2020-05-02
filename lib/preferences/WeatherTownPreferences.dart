import 'package:shared_preferences/shared_preferences.dart';

const String _weatherTownKey = "key:WeatherTown";

class WeatherTownPreferences {
  final SharedPreferences preferences;

  WeatherTownPreferences._(this.preferences);

  static Future<WeatherTownPreferences> instance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return WeatherTownPreferences._(prefs);
  }

  void saveWeatherTown(String locationCode) {
    preferences.setString(_weatherTownKey, locationCode);
  }

  String retrievePreferredWeatherTown() {
    String locationCode = preferences.getString(_weatherTownKey);
    return locationCode;
  }
}