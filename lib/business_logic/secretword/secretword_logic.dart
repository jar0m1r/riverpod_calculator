import 'dart:math' as math;
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_state.dart';

class SecretwordLogic extends StateNotifier<SecretwordState> {
  final Stream<String> inputStream;

  SecretwordLogic({this.inputStream})
      : super(SecretwordInitialState(<String>[])) {
    //not very solid
    if (inputStream != null)
      inputStream.listen((letter) {
        inputLetter(letter);
      });
  }

  final wordList = [
    'hallo',
    'zusje',
    'boek',
    'fiets',
    'auto',
    'katjes',
    'spelen',
    'slapen',
    'kamer',
    'doei',
    'steppen',
    'klimrek',
    'sint',
    'mama',
    'papa',
    'juf',
    'step',
    'konijn',
    'hond',
    'winkel',
    'vlam',
    'stoep',
    'straat',
    'lamp',
  ];

  newGame() {
    var rnd = math.Random();
    var word = wordList[rnd.nextInt(wordList.length)];
    state = SecretwordInitialState(word.split(''));
  }

  inputLetter(String letter) {
    print('tried $letter');
    if (state.playerInput.indexOf(letter) == -1) {
      state = SecretwordPlayState(state.word, [...state.playerInput, letter]);
      checkFinished();
    }
  }

  checkFinished() {
    if (state.word.every((letter) => state.playerInput.contains(letter))) {
      state = SecretwordFinishedState(
          state.word, state.playerInput, EndResultType.win);
    }
  }

  bool isPlayerInput(String letter) {
    assert(letter.length == 1);
    return state.playerInput.indexOf(letter) == -1 ? false : true;
  }
}
