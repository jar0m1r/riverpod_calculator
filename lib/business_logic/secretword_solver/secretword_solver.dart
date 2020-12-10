import 'dart:math' as math;

import 'package:riverpod_calculator/business_logic/secretword/secretword_logic.dart';

class SecretwordSolver {
  final Function inputLetterCallback;
  bool _activated = false;

  void stopSolver() => _activated = false;

  void startSolver() => _activated = true;

  solve() async {
    print('solver started');
    _activated = true;
    while (_activated) {
      await Future.delayed(Duration(seconds: 5));
      print('solver called callback');
      inputLetterCallback(generateRandomLetter());
    }
  }

  SecretwordSolver(this.inputLetterCallback);

  final _rnd = math.Random();
  final _alphabet = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];

  String generateRandomLetter() => _alphabet[_rnd.nextInt(_alphabet.length)];

  // Stream<String> letterGenerator() async* {
  //   _activated = true;
  //   while (_activated) {
  //     Future.delayed(Duration(seconds: 5));
  //     yield generateRandomLetter();
  //   }
  // }
}
