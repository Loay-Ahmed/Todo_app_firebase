import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = true;

  late ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: isDark ? Brightness.dark : Brightness.light,
    dynamicSchemeVariant: DynamicSchemeVariant.fruitSalad,
  );

  late ThemeData theme = ThemeData(colorScheme: colorScheme);

  void toggleTheme() {
    isDark = !isDark;
    colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: isDark ? Brightness.dark : Brightness.light,
      dynamicSchemeVariant: DynamicSchemeVariant.fruitSalad,
    );
    notifyListeners();
  }
}
