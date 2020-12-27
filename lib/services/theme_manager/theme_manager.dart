import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_calculator/services/application/lifecycle_service.dart';
import 'package:riverpod_calculator/services/application/lifecycle_service_provider.dart';

final themeManagerProvider = ChangeNotifierProvider<ThemeManager>((ref) {
  return ThemeManager(ref.watch(lifecycleServiceProvider.stream));
});

class ThemeManager extends ChangeNotifier {
  ThemeManager(Stream<LifecycleEvent> _stream) {
    _theme = lightTheme; //TODO check with system or overrule with saved mode
    _stream.listen((event) {
      if (event is PlatformBrightnessEvent) {
        if (event.brightness == Brightness.light) {
          _setMode(ThemeMode.light);
          print('platform set to light mode');
        } else {
          _setMode(ThemeMode.dark);
          print('platform set to dark mode');
        }
      }
    });
  }

  ThemeData _theme;
  ThemeData get theme => _theme;

  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  _setMode(ThemeMode thememode) {
    switch (thememode) {
      case ThemeMode.light:
        _mode = ThemeMode.light;
        _setTheme(lightTheme);
        break;
      case ThemeMode.dark:
        _mode = ThemeMode.dark;
        _setTheme(darkTheme);
        break;
      case ThemeMode.system:
        break;
    }
  }

  _setTheme(ThemeData themeData) {
    _theme = themeData;
    notifyListeners();
  }

  toggle() {
    _setMode((_mode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light);
  }

  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.yellow[50],
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.purple[50],
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
