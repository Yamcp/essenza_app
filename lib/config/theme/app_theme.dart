import 'package:flutter/material.dart';

const costumColor = Color(0xFF9F7AEA); // Morado  principal

const List<Color> colorList = [
  Color(0xFFED64A6), // Rosa principal
  Color(0xFFB794F6), // Morado claro
  Color(0xFFF093FB), // Rosa claro
  Color(0xFFF5E6FF),    // Fondo rosa muy claro
  Color(0xFFE8D5F7), // Fondo lavanda

];

class AppTheme {
  int selector  = 0;

  AppTheme({required this.selector})
  : assert(selector >= 0, "El selector debe ser mayor o igual a 0");

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorList[selector],
  );
}