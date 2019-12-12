import 'package:aemet_radar/features/main_page/pages/presenter/RadarPresenter.dart';
import 'package:aemet_radar/model/RadarImage.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/features/main_page/pages/interface_builder/RadarPageIB.dart'
    as interfaceBuilder;
import 'package:aemet_radar/features/main_page/pages/injector/RadarInjector'
    '.dart' as injector;
import 'package:aemet_radar/features/main_page/pages/RadarView.dart';
import 'package:aemet_radar/features/utils/PageState.dart';

class RadarPage extends StatefulWidget {

  final String provinceCode;

  RadarPage(this.provinceCode, {Key key}) : super(key: key);

  @override
  RadarPageState createState() => RadarPageState();
}

class RadarPageState extends State<RadarPage> implements RadarView {
  RadarPresenter presenter;

  PageState state = PageState.BUSY;
  bool isDataLoaded = false;
  List<RadarImage> radarImages = List<RadarImage>();
  int currentImage = 0;
  bool isPlaying = false;

  @override
  void initState() {
    this.presenter = injector.injectRadarPresenter(this);
    presenter.loadRadarImagesOf(widget.provinceCode);

    super.initState();
  }

  @override
  void onRadarImagesLoaded(List<RadarImage> radarImages) {
    setState(() {
      radarImages.forEach((image) => precacheImage(image.image, context));
      state = PageState.OK;
      this.radarImages = radarImages;
    });
  }

  void update(String provinceCode) {
    setState(() {
      state = PageState.BUSY;
    });
    presenter.loadRadarImagesOf(provinceCode);
  }

  void onSliderChange(double value) {
    setState(() {
      currentImage = value.round();
    });
  }

  @override
  Widget build(BuildContext context) => interfaceBuilder.build(
      context, state, radarImages, currentImage, isPlaying, onSliderChange);
}
