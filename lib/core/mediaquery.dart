import 'package:flutter/widgets.dart';

class MediaQueryUtil {
  static late MediaQueryData mediaQueryData;

  static void initialize(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
  }

  static double get screenWidth => mediaQueryData.size.width;
  static double get screenHeight => mediaQueryData.size.height;
  static double get devicePixelRatio => mediaQueryData.devicePixelRatio;
}