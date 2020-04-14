import 'package:aemet_radar/features/main_page/pages/MainPage.dart';
import 'package:aemet_radar/features/search_page/pages/SearchPage.dart';
import 'package:aemet_radar/features/search_page/router/SearchRouter.dart';
import 'package:aemet_radar/model/LocationWeather.dart';
import 'package:aemet_radar/values/AppColors.dart';
import 'package:flutter/material.dart';

class MainSearchPage extends StatefulWidget {
  @override
  _MainSearchPageState createState() => _MainSearchPageState();
}

class _MainSearchPageState extends State<MainSearchPage> {
  SearchRouter router;

  @override
  void initState() {
    router = SearchRouter(onNavigateToMainPage);

    super.initState();
  }

  void onNavigateToMainPage(LocationWeather locationWeather) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MainPage(locationWeather),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 34,
      fontWeight: FontWeight.w400,
      shadows: [
        Shadow(color: Colors.black45, offset: Offset(1, 1)),
      ],
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [nightSky, blueSky],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "elTiempo",
                        style: titleTextStyle,
                      ),
                      Text(
                        "AEMET",
                        style: titleTextStyle.copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 6,
              child: SearchPage(router),
            )
          ],
        ),
      ),
    );
  }
}
