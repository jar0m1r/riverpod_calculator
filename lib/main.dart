import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/services/theme_manager/theme_manager.dart';
import 'package:riverpod_calculator/ui/waves/waves_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final themeManager = watch(themeManagerProvider);
    return MaterialApp(
      title: 'Riverpod Calculator',
      theme: themeManager.theme,
      home: WavesScreen(),
    );
  }
}
