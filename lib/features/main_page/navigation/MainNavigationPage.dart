import 'package:aemet_radar/features/main_page/pages/RadarPage.dart';
import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/model/Provinces.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/model/ProvincesWithCodes.dart';

class MainNavigationPage extends StatefulWidget {
  final title = "Radar";

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  GlobalKey<RadarPageState> radarKey = GlobalKey();

  Province currentProvince = provinces.firstWhere((province) => province.provinceType == Provinces.Palencia);

  @override
  void initState() {
    super.initState();
  }

  void onProvinceSelected(Province value) {
    setState(() {
      currentProvince = value;
      radarKey.currentState.update(currentProvince);
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
                    value: currentProvince,
                    items: provinces.map((province) => DropdownMenuItem(
                      child: Text(province.name),
                      value: province,
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
                radarKey.currentState.update(currentProvince);
              }),
        ],
      ),
      body: RadarPage(currentProvince, key: radarKey),
    );
  }
}
