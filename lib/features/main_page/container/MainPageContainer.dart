import 'package:aemet_radar/features/main_page/view_state/MainPageViewState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MainPage.dart';


class MainPageContainer extends StatefulWidget {

  final String locationCode;

  MainPageContainer(this.locationCode);

  @override
  _MainPageContainerState createState() => _MainPageContainerState();
}

class _MainPageContainerState extends State<MainPageContainer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => MainPageViewState(),
        child: MainPage(widget.locationCode),
      ),
    );
  }
}
