import 'dart:async';

import 'package:flutter/material.dart';

class LifecycleService extends WidgetsBindingObserver {
  ThemeMode _mode;
  ThemeMode get mode => _mode;

  StreamController _controller;
  Stream<LifecycleEvent> stream;

  LifecycleService() {
    WidgetsBinding.instance.addObserver(this);
    _controller = StreamController.broadcast();
    stream = _controller.stream;
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _controller.sink.add(PlatformBrightnessEvent(
        brightness: WidgetsBinding.instance.window.platformBrightness));
  }

  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
  }

  @override
  void didChangeLocales(List<Locale> locale) {
    super.didChangeLocales(locale);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
  }

  @override
  void didHaveMemoryPressure() {}

  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.close();
  }
}

abstract class LifecycleEvent {}

class PlatformBrightnessEvent extends LifecycleEvent {
  final Brightness brightness;

  PlatformBrightnessEvent({this.brightness});
}
