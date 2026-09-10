import 'package:flutter/material.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  static void setLight() => themeMode.value = ThemeMode.light;
  static void setDark() => themeMode.value = ThemeMode.dark;
  static void setSystem() => themeMode.value = ThemeMode.system;
}