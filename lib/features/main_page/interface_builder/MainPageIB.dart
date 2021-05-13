import 'package:aemet_radar/features/main_page/state/CurrentWeatherState.dart';
import 'package:aemet_radar/features/main_page/view_state/MainPageViewState.dart';
import 'package:aemet_radar/features/radar/RadarPage.dart';
import 'package:aemet_radar/model/FullPrediction.dart';
import 'package:aemet_radar/model/HourlyPrediction.dart';
import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/values/ProvincesWithCodes.dart';
import 'package:aemet_radar/values/AppColors.dart';
import 'package:aemet_radar/values/Strings.dart';
import 'package:aemet_radar/widgets/Backdrop.dart';
import 'package:aemet_radar/widgets/CloudLoading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/values/WeatherIconCodes.dart' as WeatherIcons;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget build(
  BuildContext context,
  BackdropController bdController,
  Province currentProvince,
  Function(Province province) onSelectProvince,
) =>
    Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [nightSky, blueSky],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Consumer<MainPageViewState>(
            builder: (context, value, child) => AnimatedSwitcher(
              duration: Duration(seconds: 1),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  child: child,
                  opacity: animation,
                );
              },
              child: _buildWeatherForState(
                bdController,
                currentProvince,
                onSelectProvince,
                value.weatherState,
              ),
            ),
          ),
        ),
      ),
    );

Widget _buildWeatherForState(
  BackdropController bdController,
  Province currentProvince,
  Function(Province province) onSelectProvince,
  CurrentWeatherState state,
) {
  switch (state.runtimeType) {
    case Busy:
      return _buildLoading();
    case Result:
      return _buildDataContent(
        bdController,
        currentProvince,
        onSelectProvince,
        (state as Result).result,
      );
    case Error:
      return _buildError();
    default:
      return Container();
  }
}

Widget _buildDataContent(
  BackdropController bdController,
  Province currentProvince,
  Function(Province province) onSelectProvince,
  FullPrediction prediction,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 25,
        child: _buildCurrentWeather(prediction),
      ),
      Expanded(
          flex: 75,
          child: _buildBackdrop(
            bdController,
            currentProvince,
            onSelectProvince,
          )),
    ],
  );
}

Widget _buildLoading() => Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CloudLoading(),
          SizedBox(
            height: 8,
          ),
          Text(
            loadingLabel,
            style: TextStyle(fontSize: 24, color: Colors.white),
          )
        ],
      ),
    );

//region CURRENT WEATHER
Widget _buildCurrentWeather(FullPrediction fullPrediction) {
  String town = fullPrediction.town;
  String province = fullPrediction.province;

  final now = DateTime.now();

  final todayPrediction = fullPrediction.getPredictionForDay(now);

  final currentHourPrediction = todayPrediction.getPredictionForHour(now);

  PredictionHourRange currentPeriod =
      fullPrediction.getPredictionRangeForHour(now);

  String rainProbability = (currentPeriod.rainProbability.isNotEmpty)
      ? currentPeriod.rainProbability
      : "0";
  String sensation = currentHourPrediction.thermalSensation;
  String maxTemp = todayPrediction.temperature.max;
  String minTemp = todayPrediction.temperature.min;
  String temp = currentHourPrediction.temperature;
  String imagePath = WeatherIcons.weatherIcons[currentHourPrediction.skyStatus];

  final imageSize = 110.0;

  final whiteText = TextStyle(color: Colors.white);

  return Container(
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 12,
                  ),
                  AutoSizeText(
                    town,
                    style: whiteText.copyWith(fontSize: 32),
                    maxLines: 1,
                  ),
                  Text(
                    "($province)",
                    style: whiteText.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "prob. precipitación: $rainProbability%",
                    style: whiteText.copyWith(fontSize: 18),
                  ),
                  Text(
                    "sensación térmica: $sensation",
                    style: whiteText.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(0, 10),
                      child: SvgPicture.asset(
                        imagePath,
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.arrow_upward,
                                size: 18,
                                color: Colors.white,
                              ),
                              Text(
                                "$maxTempºC",
                                style: whiteText,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.arrow_downward,
                                size: 18,
                                color: Colors.white,
                              ),
                              Text(
                                "$minTempºC",
                                style: whiteText,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Center(
                        child: Text(
                          "$tempºC",
                          style: whiteText.copyWith(fontSize: 38),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
//endregion

//region BACKDROP
Widget _buildBackdrop(
  BackdropController bdController,
  Province currentProvince,
  Function(Province province) onSelectProvince,
) {
  return Backdrop(
    controller: bdController,
    frontLayer: _buildFrontLayer(bdController, currentProvince),
    backLayer: _buildBackLayer(currentProvince, onSelectProvince),
    frontAction: Icon(Icons.menu),
  );
}

Widget _buildFrontLayer(
  BackdropController bdController,
  Province currentProvince,
) =>
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () => bdController.toggleFrontLayer(),
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 36, top: 12),
                            child: Text(
                              "Radar",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 36),
                          child: Text(
                            currentProvince.name,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black45),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Center(
                      child: bdController.isOpen()
                          ? Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                            )
                          : Icon(
                              Icons.arrow_drop_up,
                              size: 30,
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: RadarPage(
              currentProvince,
            ),
          ),
        ],
      ),
    );

Widget _buildBackLayer(
  Province currentProvince,
  Function(Province province) onSelectProvince,
) =>
    ListView(
      padding: const EdgeInsets.only(bottom: 120),
      children: provinces.map((province) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Card(
            elevation: 0,
            color: (province == currentProvince)
                ? Colors.white30
                : Colors.transparent,
            child: InkWell(
              onTap: () => onSelectProvince(province),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: Text(
                    province.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
//endregion

Widget _buildError() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorLabel,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}
