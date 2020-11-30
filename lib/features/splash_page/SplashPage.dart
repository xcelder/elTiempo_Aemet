import 'package:aemet_radar/features/splash_page/router/SplashRouter.dart';
import 'package:aemet_radar/features/splash_page/SplashView.dart';
import 'package:aemet_radar/features/splash_page/presenter/SplashPresenter.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/features/splash_page/interface_builder/SplashIB.dart' as InterfaceBuilder;
import 'package:aemet_radar/features/splash_page/injector/SplashInjector.dart' as Injector;

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> implements SplashView {

  SplashPresenter presenter;
  SplashRouter router;

  @override
  void initState() {
    presenter = Injector.injectPresenter(this);
    presenter.loadPreferredProvince();
    router = SplashRouter(Navigator.of(context));

    super.initState();
  }

  @override
  void onPreferredProvinceLoaded(String locationCode) {
    if (locationCode != null && locationCode.isNotEmpty) {
      router.navigateToMain(locationCode);
    } else {
      router.navigateToSearch();
    }
  }

  @override
  Widget build(BuildContext context) => InterfaceBuilder.build();
}
