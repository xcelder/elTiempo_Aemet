import 'package:aemet_radar/features/utils/PageState.dart';
import 'package:aemet_radar/model/RadarImage.dart';
import 'package:aemet_radar/values/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

Widget build(
    BuildContext context,
    PageState state,
    List<RadarImage> radarImages,
    int currentImage,
    bool isPlaying,
    Function(double value) onSliderChange) {
  switch (state) {
    case PageState.BUSY:
      return _buildLoading();
    case PageState.OK:
      return _buildContent(context, currentImage, radarImages, onSliderChange);
    case PageState.ERROR:
      return _buildError();
    default:
      return _buildLoading();
  }
}

Widget _buildLoading() => Center(
      child: CircularProgressIndicator(),
    );

Widget _buildContent(BuildContext context, int currentImage,
    List<RadarImage> radarImages, Function(double value) onSliderChange) {
  return Container(
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: PhotoView(
            backgroundDecoration: BoxDecoration(
              color: Colors.white,
            ),
            minScale: PhotoViewComputedScale.covered,
            imageProvider: radarImages[currentImage].image,
            gaplessPlayback: true,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 5.0,
                    thumbColor: blueSky,
                    activeTrackColor: blueSky,
                    inactiveTrackColor: blueSky,
                    activeTickMarkColor: blueSky,
                    inactiveTickMarkColor: blueSky,
                    valueIndicatorColor: blueSky,
                  ),
                  child: Slider(
                      min: 0,
                      max: (radarImages.length - 1).toDouble(),
                      divisions: radarImages.length - 1,
                      label: radarImages[currentImage].hour,
                      value: currentImage.toDouble(),
                      onChanged: (value) {
                        onSliderChange(value);
                      }),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Color(0x66FFFFFF)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          radarImages.first.hour,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          radarImages.last.hour,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

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
          Text("Something went wrong!")
        ],
      ),
    );
