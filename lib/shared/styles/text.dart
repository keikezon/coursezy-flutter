// import 'colors.dart';

import 'package:coursezy/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle gilroyBold = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static TextStyle gilroyMediumAlpha = TextStyle(
    fontFamily: 'Gilroy-Medium',
    fontSize: 20,
    color: AppColor.grayPrimary.withAlpha(100),
  );

  static TextStyle gilroyMedium = TextStyle(
    fontFamily: 'Gilroy-Medium',
    fontSize: 20,
  );

  static TextStyle gilroyBoldAlpha = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 16,
    color: AppColor.grayPrimary.withAlpha(100),
  );

  static TextStyle gilroyBold16 = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 16,
  );
}
