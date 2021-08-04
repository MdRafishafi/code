import 'package:flutter/material.dart';

class FontCustomizer {
  static void fieldFocusChange({
    @required BuildContext context,
    @required FocusNode currentFocus,
    @required FocusNode nextFocus,
  }) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static double textFontSize({
    @required double fontSize,
    @required double screenWidth,
  }) {
    return fontSize * screenWidth / 360;
  }
}
