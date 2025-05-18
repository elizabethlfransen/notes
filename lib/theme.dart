import 'package:flutter/material.dart';

ThemeData _createBaseTheme(Brightness brightness) => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: brightness,
  ),
  brightness: brightness,
);

final ThemeData lightTheme = _createBaseTheme(Brightness.light);

final ThemeData darkTheme = _createBaseTheme(Brightness.dark);
