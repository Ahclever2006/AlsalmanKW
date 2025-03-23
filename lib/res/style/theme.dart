import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

final theme = ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: TextTheme(
    displaySmall: _normalText(11.0),
    displayMedium: _normalText(13.0),
    displayLarge: _boldText(16.0),
    headlineSmall: _boldText(13.0),
    headlineMedium: _boldText(15.0),
    headlineLarge: _boldText(18.0),
    titleSmall: _boldText(21.0),
    titleMedium: _boldText(23.0),
    titleLarge: _boldText(29.0),
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
    overlayColor: WidgetStateColor.resolveWith(
      (states) => AppColors.GREY_NORMAL_COLOR,
    ),
    fillColor: WidgetStateColor.resolveWith(
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

const textHeight = 1.0;
const navbarHeight = 80.0;
const sliverAppbarExtensionHeight = 200.0;
