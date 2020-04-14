
class RadarImage {

  final String urlImage;
  final DateTime hour;

  ImageSize imageSize;

  RadarImage(this.urlImage, this.hour);

  void setImageSize(ImageSize imageSize) {
    this.imageSize = imageSize;
  }

  bool isAlreadyLoaded() => imageSize != null;
}

class ImageSize {

  final int height;
  final int width;

  ImageSize(this.height, this.width);

}