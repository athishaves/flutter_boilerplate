import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResponsiveSizer {
  static Size _designSize = const Size(1080, 1920);
  static Size _deviceScreenSize = const Size(1080, 1920);

  static double get deviceAspectRatio =>
      _deviceScreenSize.height / _deviceScreenSize.width;

  static double get designAspectRatio =>
      _designSize.height / _designSize.height;

  static double get _horizontalScaleFactor =>
      _deviceScreenSize.width / _designSize.width;

  static double get _verticalScaleFactor =>
      _deviceScreenSize.height / _designSize.height;

  static double get _fontScaleFactor => deviceAspectRatio <= designAspectRatio
      ? _verticalScaleFactor
      : _horizontalScaleFactor;

  static late BoxConstraints boxConstraints;

  static late Orientation orientation;

  static late DeviceType deviceType;

  static late double height;
  static late double width;

  static void setup(
      {required BuildContext context,
      required Size designSize,
      required DeviceType deviceType}) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    _deviceScreenSize = mediaQueryData.size;
    _designSize = designSize;
  }

  static double scaleHorizontally(num value) => value * _horizontalScaleFactor;

  static double scaleVertically(num value) => value * _verticalScaleFactor;

  static double scaleUniformly(num value) =>
      deviceAspectRatio <= designAspectRatio
          ? value * _verticalScaleFactor
          : value * _horizontalScaleFactor;

  static double scaleFont(num value) => value * _fontScaleFactor;
}

extension UIScaler on num {
  double get sw => ResponsiveSizer.scaleHorizontally(this);
  double get sh => ResponsiveSizer.scaleVertically(this);
  double get su => ResponsiveSizer.scaleUniformly(this);
  double get sf => ResponsiveSizer.scaleFont(this);
}
