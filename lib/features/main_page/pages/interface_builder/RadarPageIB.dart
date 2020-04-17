import 'package:aemet_radar/features/main_page/pages/utils/CacheNetworkImageAspectRatio.dart';
import 'package:aemet_radar/features/utils/PageState.dart';
import 'package:aemet_radar/model/RadarImage.dart';
import 'package:aemet_radar/values/AppColors.dart';
import 'package:aemet_radar/values/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:photo_view/photo_view.dart';

import '../RadarPage.dart';

Widget build(
    BuildContext context,
    PageState state,
    List<RadarImage> radarImages,
    int currentImage,
    bool isPlaying,
    Function(double value) onSliderChange,
    Function onReload) {
  Widget content;
  switch (state) {
    case PageState.BUSY:
      content = _buildLoading();
      break;
    case PageState.OK:
      content =
          _buildContent(context, currentImage, radarImages, onSliderChange);
      break;
    case PageState.ERROR:
      content = _buildError();
      break;
    default:
      content = _buildError();
  }

  return _buildContainer(content, onReload);
}

Widget _buildContainer(Widget content, Function onReload) => Container(
      child: Stack(
        children: [
          content,
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                child: Icon(Icons.autorenew),
                elevation: 7,
                backgroundColor: blueSky,
                onPressed: () => onReload(),
              ),
            ),
          )
        ],
      ),
    );

Widget _buildLoading() => Center(
      child: CircularProgressIndicator(),
    );

Widget _buildContent(
  BuildContext context,
  int currentImage,
  List<RadarImage> radarImages,
  Function(double value) onSliderChange,
) {
  return Container(
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: ClipRect(
            child: _buildPhotoView(radarImages[currentImage]),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _buildSlider(
              context,
              radarImages.length - 1,
              currentImage,
              radarImages[currentImage],
              _getFormatedDateFromImage(radarImages.first),
              _getFormatedDateFromImage(radarImages.last),
              onSliderChange,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPhotoView(RadarImage overlayImage) => PhotoView(
      backgroundDecoration: BoxDecoration(
        color: Colors.white,
      ),
      minScale: PhotoViewComputedScale.contained,
      imageProvider: Image.network(overlayImage.urlImage).image,
      gaplessPlayback: true,
    );

Widget _buildMap(RadarImage overlayImage) => FutureBuilder<ImageProvider>(
      future: networkImageResizedToMaxWidth(overlayImage, MAX_WIDTH_IMAGE),
      builder: (BuildContext context, AsyncSnapshot<ImageProvider> snapshot) {
        if (!snapshot.hasData) {
          return _buildLoading();
        } else {
          return FlutterMap(
            options: MapOptions(
              center: LatLng(42.0095500, -4.5240600),
              zoom: 7,
              minZoom: 6,
              maxZoom: 9,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoieGNlbGRlciIsImEiOiJjazh1NWV0NXYwMWY5M2dtem9iMW4xNm03In0.fti5oBiGMK3FYibeRfP7Rg',
                  'id': 'mapbox.streets',
                },
              ),
              OverlayImageLayerOptions(overlayImages: [
                OverlayImage(
                  opacity: 0.9,
                  bounds: LatLngBounds(
                    LatLng(33.80094852216654, 4.391150189144839),
                    LatLng(50.155888099999984, -13.600951899999998),
                  ),
                  imageProvider: snapshot.data,
                )
              ])
            ],
          );
        }
      },
    );

Widget _buildSlider(
  BuildContext context,
  int length,
  int currentPos,
  RadarImage currentImage,
  String firstHour,
  String lastHour,
  Function(double value) onSliderChange,
) =>
    Card(
      elevation: 7,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(firstHour),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 5.0,
                thumbColor: blueSky,
                activeTrackColor: blueSky,
                inactiveTrackColor: blueSky,
                activeTickMarkColor: blueSky,
                inactiveTickMarkColor: blueSky,
                valueIndicatorColor: blueSky,
                valueIndicatorTextStyle: TextStyle(color: Colors.white),
              ),
              child: Slider(
                min: 0,
                max: length.toDouble(),
                divisions: length,
                label: _getFormatedDateFromImage(currentImage),
                value: currentPos.toDouble(),
                onChanged: (value) {
                  onSliderChange(value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(lastHour),
          )
        ],
      ),
    );

Widget _buildError() => Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning,
            size: 50,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              radarErrorMessage,
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
            ),
          ),
        ],
      ),
    );

String _getFormatedDateFromImage(RadarImage radarImage) =>
    radarImage != null ? DateFormat("HH:mm").format(radarImage.hour) : "";
