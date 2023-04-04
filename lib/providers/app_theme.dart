import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../database/lcaol_data.dart';

//
// Local Data means
// 0 -> system
// 1 -> light
// 2 -> dask

class AppThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode =
      LocalData.themeMode() == null || LocalData.themeMode() == 0
          ? ThemeMode.system
          : LocalData.themeMode() == 1
              ? ThemeMode.light
              : ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      final Brightness brightness =
          SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return _themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme() {
    final int? value = LocalData.themeMode();
    if (value == null || value == 0) {
      _themeMode = ThemeMode.light;
      LocalData.setThemeMode(1);
    } else if (value == 1) {
      _themeMode = ThemeMode.dark;
      LocalData.setThemeMode(2);
    } else {
      _themeMode = ThemeMode.system;
      LocalData.setThemeMode(0);
    }
    notifyListeners();
  }
}

class AppThemes {
  static const Color _primary = Colors.blue;
  static const Color _secondary = Color.fromRGBO(2, 122, 190, 1);
  //
  // Dark
  //
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF101018),
    primaryColor: _primary,
    iconTheme: const IconThemeData(color: Colors.white),
    dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 0.5),
    dividerColor: Colors.grey.shade600,
    colorScheme: const ColorScheme.dark(
      primary: _primary,
      secondary: _secondary,
    ),
  );

  //
  // Light
  //
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: _primary,
    iconTheme: const IconThemeData(color: Colors.black),
    dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 0.5),
    dividerColor: Colors.grey.shade300,
    colorScheme: const ColorScheme.light(
      primary: _primary,
      secondary: _secondary,
    ),
  );
}
