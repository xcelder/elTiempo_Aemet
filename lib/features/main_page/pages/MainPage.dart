import 'package:aemet_radar/features/main_page/pages/preferences/RadarPreferences.dart';
import 'package:aemet_radar/features/main_page/pages/presenter/MainPagePresenter.dart';
import 'package:aemet_radar/model/LocationWeather.dart';
import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/values/ProvincesWithCodes.dart';
import 'package:aemet_radar/widgets/Backdrop.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/features/main_page/pages/interface_builder/MainPageIB.dart'
    as mainPageIB;
import 'package:aemet_radar/features/main_page/pages/injector/MainPageInjector.dart'
    as injector;

import 'RadarPage.dart';

class MainPage extends StatefulWidget {
  final LocationWeather locationWeather;

  MainPage(this.locationWeather);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<RadarPageState> radarKey = GlobalKey();

  MainPagePresenter presenter;

  BackdropController bdController = BackdropController();

  Province currentProvince = provinces.first;

  @override
  void initState() {
    presenter = injector.injectMainPagePresenter();
    loadPreferredProvince();
    super.initState();
  }

  void loadPreferredProvince() async {
    final radarPreferences = await RadarPreferences.instance();
    final preferredRadar = radarPreferences.retrievePreferredProvinceRadar();
    updateProvince(preferredRadar);
  }

  void savePreferredProvince(Province selectedProvince) async {
    final radarPreferences = await RadarPreferences.instance();
    radarPreferences.saveProvinceRadar(selectedProvince);
  }

  void updateProvince(Province selectedProvince) {
    setState(() {
      currentProvince = selectedProvince;
      radarKey.currentState.update(currentProvince);
    });
  }

  void onProvinceSelected(Province selectedProvince) {
    savePreferredProvince(selectedProvince);
    setState(() {
      currentProvince = selectedProvince;
      radarKey.currentState.update(currentProvince);
      bdController.toggleFrontLayer();
    });
  }

  @override
  Widget build(BuildContext context) => mainPageIB.build(
        context,
        radarKey,
        bdController,
        presenter.currentWeatherStateStream,
        currentProvince,
        onProvinceSelected,
      );
}
