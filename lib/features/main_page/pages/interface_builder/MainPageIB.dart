import 'package:aemet_radar/features/main_page/pages/state/CurrentWeatherState.dart';
import 'package:aemet_radar/model/Provinces.dart';
import 'package:aemet_radar/model/ProvincesWithCodes.dart';
import 'package:aemet_radar/values/AppColors.dart';
import 'package:aemet_radar/widgets/Backdrop.dart';
import 'package:flutter/material.dart';

import '../RadarPage.dart';

Widget build(BuildContext context, BackdropController bdController, Stream<CurrentWeatherState> cwStream) =>
    Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [nightSky, blueSky],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            _buildCurrentWeather(cwStream),
            Expanded(child: _buildBackdrop(bdController)),
          ],
        ),
      ),
    );

//region CURRENT WEATHER
Widget _buildCurrentWeather(Stream<CurrentWeatherState> cwStream) =>
    StreamBuilder<CurrentWeatherState>(
      initialData: NoData(),
      stream: cwStream,
      builder: (context, snapshot) {
        String name = "Valladolid";
        String town = "Valladolid";
        String rainProbability = "20";
        String sensation = "1";
        String maxTemp = "7";
        String minTemp = "0";
        String temp = "22";

        final whiteText = TextStyle(color: Colors.white);

        return Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
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
                        Text(
                          name,
                          style: whiteText.copyWith(fontSize: 32),
                        ),
                        Text(
                          "($town)",
                          style: whiteText.copyWith(fontSize: 18),
                        ),
                        SizedBox(
                          height: 12,
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
                          child: Icon(
                            Icons.cloud,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Row(
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
                                ),
                                Center(
                                  child: Row(
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
      },
    );
//endregion

//region BACKDROP
Widget _buildBackdrop(BackdropController bdController) {
  return Backdrop(
    controller: bdController,
    frontLayer: Container(
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
                            "Palencia",
                            style: TextStyle(fontSize: 18, color: Colors.black45),
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
                        Icons.arrow_drop_up,
                        size: 30,
                        )
                      : Icon(
                        Icons.arrow_drop_down,
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
            child: RadarPage(provinces.firstWhere((province) => province.provinceType == Provinces.Palencia)),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Icon(Icons.keyboard_arrow_up, size: 30,),
            ),
          )
        ],
      ),
    ),
    backLayer: Container(),
    frontAction: Icon(Icons.menu),
  );
}
//endregion
