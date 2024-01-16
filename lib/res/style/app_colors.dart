import 'package:flutter/material.dart';

abstract class AppColors {
  static const PRIMARY_COLOR = Color(0xFF5FA8D3);
  static const PRIMARY_COLOR_LIGHT = Color(0xFFCAE9FF);
  static const PRIMARY_COLOR_DARK = Color(0xFF1B4965);
  static const BARRIER_COLOR = Color(0xAAF1F3FB);
  static const SECONDARY_COLOR = Color(0xFF262D5E);
  static const ACCENT_COLOR = Color(0xFFD69227);
  static const BACKGROUND_COLOR = Color(0xFFFFF9EE);
  static const GREY_LIGHT_COLOR = Color(0xFFF3F3F3);
  static const GREY_NORMAL_COLOR = Color(0xFFB9B9B9);
  static const GREY_DARK_COLOR = Color(0xFF707070);
  static const GREY_BORDER_COLOR = Color(0xFFDEDEDE);
  static const WHATS_APP_COLOR = Color(0xFF55CD6C);
  static const WALLET_SWITCH_CONTAINER_COLOR = Color(0xFFEAF2F6);
  static const CUSTOM_APP_PAGE_COLOR = Color(0xFFE9F4FC);
  static const SEARCH_ICON_CONTAINER_COLOR = Color(0xFFE8F1F2);

  static const AUTH_CONTAINER_COLOR = Colors.white;

  static const LIGHT_GRADIENT = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF3F3F3),
      Color(0xFFFFEBEB),
    ],
  );

  static const DRAWER_GRADIENT_COLOR = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFDC0E3A),
      Color(0xFF6E071D),
    ],
    stops: [0.0, 0.65],
  );

  static const SHADOW = [
    BoxShadow(
      color: Color(0x99000000),
      spreadRadius: 0.03,
      blurRadius: 6,
    ),
  ];

  static const SHADOW_LIGHT = [
    BoxShadow(
      color: Color(0x44000000),
      spreadRadius: 0.03,
      blurRadius: 6,
    ),
  ];
}
