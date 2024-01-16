import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

final theme = ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: TextTheme(
    bodyText1: _normalText(14.0),
    bodyText2: _normalText(16.0),
    headline1: _boldText(16.0),
    headline2: _boldText(18.0),
    headline3: _boldText(21.0),
    headline4: _boldText(24.0),
    headline5: _boldText(28.0),
    headline6: _boldText(32.0),
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  colorScheme: const ColorScheme.light(primary: AppColors.PRIMARY_COLOR),
  radioTheme: RadioThemeData(
    overlayColor: MaterialStateColor.resolveWith(
      (states) => AppColors.GREY_NORMAL_COLOR,
    ),
    fillColor: MaterialStateColor.resolveWith(
      (states) => AppColors.PRIMARY_COLOR,
    ),
  ),
);

TextStyle _boldText(double size) {
  return TextStyle(
    color: Colors.black,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: size,
  );
}

TextStyle _normalText(double size) {
  return TextStyle(
    color: Colors.black,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: size,
  );
}

const navbarHeight = 80.0;
const sliverAppbarExtensionHeight = 200.0;
