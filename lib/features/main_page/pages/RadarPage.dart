import 'dart:async';

import 'package:aemet_radar/features/main_page/pages/presenter/RadarPresenter.dart';
import 'package:aemet_radar/features/main_page/pages/utils/CacheNetworkImageAspectRatio.dart';
import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/model/RadarImage.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/features/main_page/pages/interface_builder/RadarPageIB.dart'
    as interfaceBuilder;
import 'package:aemet_radar/features/main_page/pages/injector/RadarInjector'
    '.dart' as injector;
import 'package:aemet_radar/features/main_page/pages/RadarView.dart';
import 'package:aemet_radar/features/utils/PageState.dart';

const int MAX_WIDTH_IMAGE = 900;

class RadarPage extends StatefulWidget {
  final Province province;

  RadarPage(this.province, {Key key}) : super(key: key);

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
    presenter.loadRadarImagesOf(widget.province);

    super.initState();
  }

  @override
  void onRadarImagesLoaded(List<RadarImage> radarImages) {
    setState(() {
      _precacheImages(radarImages);
      state = PageState.OK;
      this.radarImages = radarImages;
    });
  }

  void update(Province province) {
    setState(() {
      state = PageState.BUSY;
    });
    presenter.loadRadarImagesOf(province);
  }

  void onSliderChange(double value) {
    setState(() {
      currentImage = value.round();
    });
  }

  void _precacheImages(List<RadarImage> radarImages) async {
    radarImages.forEach((radarImage) =>
        precacheImage(Image.network(radarImage.urlImage).image, context));
  }

  void _preacacheImageAsync(RadarImage image, int waitSec) async {
    Timer(Duration(milliseconds: ((waitSec / 4) * 1000).round()), () async {
      final provider =
          await networkImageResizedToMaxWidth(image, MAX_WIDTH_IMAGE);
      precacheImage(provider, context);
    });
  }

  void onReload() {
    update(widget.province);
  }

  @override
  void onRadarError() {
    setState(() {
      state = PageState.ERROR;
    });
  }

  @override
  Widget build(BuildContext context) => interfaceBuilder.build(context, state,
      radarImages, currentImage, isPlaying, onSliderChange, onReload);
}
