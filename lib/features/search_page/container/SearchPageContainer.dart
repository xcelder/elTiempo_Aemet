import 'dart:async';

import 'package:aemet_radar/features/main_page/MainPage.dart';
import 'package:aemet_radar/features/main_page/view_state/MainPageViewState.dart';
import 'package:aemet_radar/features/search_page/pages/SearchPage.dart';
import 'package:aemet_radar/features/search_page/router/SearchRouter.dart';
import 'package:aemet_radar/features/search_page/view_state/SearchViewState.dart';
import 'package:aemet_radar/model/LocationOption.dart';
import 'package:aemet_radar/values/AppColors.dart';
import 'package:aemet_radar/values/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../SearchState.dart';

class SearchPageContainer extends StatefulWidget {
  @override
  _SearchPageContainerState createState() => _SearchPageContainerState();
}

class _SearchPageContainerState extends State<SearchPageContainer> {
  SearchRouter router;

  final stateController = StreamController<SearchState>();

  @override
  void initState() {
    router = SearchRouter(onNavigateToMainPage);

    super.initState();
  }

  void onNavigateToMainPage(LocationOption locationOption) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => MainPageViewState(),
          child: MainPage(locationOption.locationCode),
        ),
      ),
    );
  }

  @override
  void dispose() {
    stateController.close();
    super.dispose();
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
          children: [
            Expanded(
                flex: 4,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title1,
                        style: titleTextStyle,
                      ),
                      Text(
                        title2,
                        style: titleTextStyle.copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 6,
              child: SearchViewState(
                stateController,
                child: SearchPage(router),
              ),
            )
          ],
        ),
      ),
    );
  }
}
