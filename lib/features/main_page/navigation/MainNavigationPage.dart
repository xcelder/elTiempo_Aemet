import 'package:aemet_radar/features/main_page/pages/RadarPage.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/model/Provinces.dart';

class MainNavigationPage extends StatefulWidget {
  final title = "Radar";

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  GlobalKey<RadarPageState> radarKey = GlobalKey();

  String provinceCode = "vd";

  @override
  void initState() {
    super.initState();
  }

  void onProvinceSelected(String value) {
    setState(() {
      provinceCode = value;
      radarKey.currentState.update(provinceCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(widget.title),
            SizedBox(width: 8,),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    value: provinceCode,
                    items: provinces.entries.map((province) => DropdownMenuItem(
                      child: Text(province.value),
                      value: province.key,
                    )).toList(),
                    onChanged: (value) {
                      onProvinceSelected(value);
                    },
                    underline: Container(),
                    iconEnabledColor: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                radarKey.currentState.update(provinceCode);
              }),
        ],
      ),
      body: RadarPage(provinceCode, key: radarKey),
    );
  }
}
