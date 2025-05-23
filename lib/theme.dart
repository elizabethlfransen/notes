import 'package:flutter/material.dart';

ThemeData _createBaseTheme(Brightness brightness) => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: brightness,
  ),
  brightness: brightness,
  textTheme: TextTheme(
    labelLarge: TextStyle(
      fontSize: 20,
      color:
          brightness == Brightness.dark
              ? Colors.grey.shade400
              : Colors.grey.shade600,
    ),
  ),
);

final ThemeData lightTheme = _createBaseTheme(Brightness.light);

final ThemeData darkTheme = _createBaseTheme(Brightness.dark);
