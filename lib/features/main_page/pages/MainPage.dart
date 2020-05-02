import 'package:aemet_radar/features/main_page/pages/MainPageView.dart';
import 'package:aemet_radar/features/main_page/pages/presenter/MainPagePresenter.dart';
import 'package:aemet_radar/features/main_page/pages/view_state/MainPageViewState.dart';
import 'package:aemet_radar/model/LocationOption.dart';
import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/values/ProvincesWithCodes.dart';
import 'package:aemet_radar/widgets/Backdrop.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/features/main_page/pages/interface_builder/MainPageIB.dart'
    as mainPageIB;
import 'package:aemet_radar/features/main_page/pages/injector/MainPageInjector.dart'
    as injector;

class MainPage extends StatefulWidget {
  final String locationCode;

  MainPage(this.locationCode);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> implements MainPageView {
  MainPagePresenter presenter;

  BackdropController bdController = BackdropController();

  Province currentProvince = provinces.first;

  @override
  void didChangeDependencies() {
    presenter =
        injector.injectMainPagePresenter(this, MainPageViewState.of(context));
    presenter.loadPreferredProvince();
    presenter.loadWeatherData(widget.locationCode);

    super.didChangeDependencies();
  }

  @override
  void onPreferredProvinceLoaded(Province selectedProvince) {
    setState(() {
      currentProvince = selectedProvince;
    });
  }

  void onProvinceSelected(Province selectedProvince) {
    presenter.savePreferredProvince(selectedProvince);
    setState(() {
      currentProvince = selectedProvince;
      bdController.toggleFrontLayer();
    });
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => mainPageIB.build(
        context,
        bdController,
        currentProvince,
        onProvinceSelected,
      );
}
