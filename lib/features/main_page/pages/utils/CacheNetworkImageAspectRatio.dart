import 'dart:async';

import 'package:aemet_radar/model/RadarImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

Future<ImageProvider> networkImageResizedToMaxWidth(
    RadarImage image, int maxWidth) async {
  Completer<ImageProvider> completer = Completer();

  if (image.isAlreadyLoaded()) {
    return Image.network(image.urlImage,
            cacheWidth: image.imageSize.width,
            cacheHeight: image.imageSize.height)
        .image;
  } else {
    AdvancedNetworkImage(image.urlImage,
            useDiskCache: false, disableMemoryCache: true)
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      imageCache.clear();
      DiskCache().clear();

      final newMaxWidth =
          (info.image.width > maxWidth) ? maxWidth : info.image.width;
      final newMaxHeight = (newMaxWidth * info.image.height) / info.image.width;

      image.setImageSize(ImageSize(newMaxHeight.round(), newMaxWidth));

      return completer.complete(Image.network(image.urlImage,
              cacheWidth: newMaxWidth, cacheHeight: newMaxHeight.round(), gaplessPlayback: true,)
          .image);
    }));
    return completer.future;
  }
}
