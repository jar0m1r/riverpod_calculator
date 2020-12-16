import 'package:flutter_riverpod/all.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_state.dart';

class SecretwordLogic extends StateNotifier<SecretwordState> {
  final Stream<String> inputStream;

  SecretwordLogic({this.inputStream}) : super(_initialValue) {
    //not very solid
    if (inputStream != null)
      inputStream.listen((letter) {
        inputLetter(letter);
      });
  }

  static final _initialValue =
      SecretwordInitialState(['g', 'e', 'h', 'e', 'i', 'm']);

  startGame() => state = SecretwordPlayState(state.word, state.playerInput);

  newGame() => state = SecretwordInitialState(['a', 'n', 'd', 'e', 'r']);

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
