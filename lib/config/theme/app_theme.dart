import 'package:flutter/material.dart';

const costumColor = Color(0xFF9F7AEA); // Morado  principal

const List<Color> colorList = [
  Color(0xFFF3ECE7), // 1 tono en degradado
  Color(0xFFFEFFFF), // Fondo neutro y 2do tono en degradado
  Color(0xFF9F7A7A), // Color de las partes principales
  Color(0xFF1E1F21), // Color de texto principal
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