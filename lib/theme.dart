import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Define the theme modes
final lightTheme = ThemeData.light();
final darkTheme = ThemeData.dark();

/// current theme
ThemeData get currentTheme {
  var schedulerBinding = SchedulerBinding.instance;
  var brightness = schedulerBinding.platformDispatcher.platformBrightness;
  if (brightness == Brightness.dark) {
    return darkTheme;
  } else {
    return lightTheme;
  }
}
