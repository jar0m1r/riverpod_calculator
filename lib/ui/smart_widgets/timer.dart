import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/calculator/calculator_provider.dart';

class TimeoutCounter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final counter = watch(counterProvider);
    return Container(
      child: counter.when(
          loading: () => CircularProgressIndicator(),
          data: (value) => Text('$value'),
          error: (o, error) => Text('error $o $error')),
    );
  }
}
