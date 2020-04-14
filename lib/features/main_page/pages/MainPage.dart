import 'package:aemet_radar/features/main_page/pages/presenter/MainPagePresenter.dart';
import 'package:aemet_radar/model/LocationWeather.dart';
import 'package:aemet_radar/widgets/Backdrop.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/features/main_page/pages/interface_builder/MainPageIB.dart'
    as mainPageIB;
import 'package:aemet_radar/features/main_page/pages/injector/MainPageInjector.dart'
    as injector;

class MainPage extends StatefulWidget {
  final LocationWeather locationWeather;

  MainPage(this.locationWeather);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainPagePresenter presenter;

  BackdropController bdController = BackdropController();

  @override
  void initState() {
    presenter = injector.injectMainPagePresenter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainPageIB.build(
        context,
        bdController,
        presenter.currentWeatherStateStream,
      );
}
