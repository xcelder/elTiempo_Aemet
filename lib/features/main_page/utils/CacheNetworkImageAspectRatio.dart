import 'dart:async';

import 'package:aemet_radar/model/RadarImage.dart';
import 'package:flutter/material.dart';

Future<ImageProvider> networkImageResizedToMaxWidth(
    RadarImage image, int maxWidth) async {
    return Image.network(image.urlImage,
            cacheWidth: image.imageSize.width,
            cacheHeight: image.imageSize.height)
        .image;
}
