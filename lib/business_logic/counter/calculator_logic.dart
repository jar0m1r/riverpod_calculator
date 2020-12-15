import 'package:flutter/material.dart';

class CountService {
  Stream<int> countStream(Duration interval, [int maxCount]) async* {
    await Future.delayed(Duration(seconds: 3)); //see loading at work
    int i = 0;
    while (true) {
      await Future.delayed(interval);
      yield i++;
      if (i == maxCount) break;
    }
  }
}
