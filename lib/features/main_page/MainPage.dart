import 'package:aemet_radar/features/main_page/MainPageView.dart';
import 'package:aemet_radar/features/main_page/presenter/MainPagePresenter.dart';
import 'package:aemet_radar/features/main_page/view_state/MainPageViewState.dart';
import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/values/ProvincesWithCodes.dart';
import 'package:aemet_radar/widgets/Backdrop.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/features/main_page/interface_builder/MainPageIB.dart'
    as layout;
import 'package:aemet_radar/features/main_page/injector/MainPageInjector.dart'
    as injector;

class MainPage extends StatefulWidget {
  final String locationCode;

  MainPage(this.locationCode);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver implements MainPageView {
  MainPagePresenter presenter;

  BackdropController bdController = BackdropController();

  Province currentProvince = provinces.first;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

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
//    setState(() {
//      currentProvince = selectedProvince;
//    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      presenter.loadWeatherData(widget.locationCode);
    }
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
    WidgetsBinding.instance.removeObserver(this);
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => layout.build(
        context,
        bdController,
        currentProvince,
        onProvinceSelected,
      );
}
