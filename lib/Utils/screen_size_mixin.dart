import 'package:flutter/cupertino.dart';

mixin class ScreenSizeMixin {
  double screenWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
  double screenHeight(BuildContext context) => MediaQuery.sizeOf(context).height;
}