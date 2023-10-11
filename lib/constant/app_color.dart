import 'package:flutter/material.dart';

const primary = Color(0xff219ebc);
const onPrimary = Color(0xff8ecae6);
const appSecondary = Color(0xffff6b6b);
const onSecondary = Color(0xfff4a261);
const lightColor = Color(0xffe9c46a);
const onLightColor = Color(0xffedf2f4);
const appWhite = Color(0xffF7F7F7);
const appBlack = Color(0xff151923);
const blackVariant = Color(0xff161F21);
const appGrey = Color(0xffBBBBBB);
const white = Colors.white;

MaterialColor primarySwatch = MaterialColor(
  primary.value,
  <int, Color>{
    50: primary.withOpacity(0.1),
    100: primary.withOpacity(0.2),
    200: primary.withOpacity(0.3),
    300: primary.withOpacity(0.4),
    400: primary.withOpacity(0.5),
    500: primary.withOpacity(0.6),
    600: primary.withOpacity(0.7),
    700: primary.withOpacity(0.8),
    800: primary.withOpacity(0.9),
    900: primary.withOpacity(1.0),
  },
);

MaterialColor darkPrimarySwatch = MaterialColor(
  onPrimary.value,
  <int, Color>{
    50: primary.withOpacity(0.1),
    100: primary.withOpacity(0.2),
    200: primary.withOpacity(0.3),
    300: primary.withOpacity(0.4),
    400: primary.withOpacity(0.5),
    500: primary.withOpacity(0.6),
    600: primary.withOpacity(0.7),
    700: primary.withOpacity(0.8),
    800: primary.withOpacity(0.9),
    900: primary.withOpacity(1.0),
  },
);
