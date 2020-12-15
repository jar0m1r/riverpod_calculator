import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/counter/calculator_logic.dart';

final counterProvider = StreamProvider<int>((ref) {
  return CountService().countStream(Duration(seconds: 1), 100);
});
