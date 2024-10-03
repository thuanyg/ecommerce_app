import 'package:flutter/material.dart';

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);

  static final ThemeState lightTheme = ThemeState(ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
  ));
  static final ThemeState darkTheme = ThemeState(ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      color: Colors.black,
    ),
  ));
}