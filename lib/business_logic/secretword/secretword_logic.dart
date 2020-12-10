import 'package:flutter_riverpod/all.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_state.dart';

class SecretwordLogic extends StateNotifier<SecretwordState> {
  SecretwordLogic() : super(_initialValue);

  static final _initialValue =
      SecretwordInitialState(['g', 'e', 'h', 'e', 'i', 'm']);

  startGame() => state = SecretwordPlayState(state.word, state.playerInput);

  inputLetter(String letter) {
    print('tried $letter');
    if (state.playerInput.indexOf(letter) == -1) {
      state = SecretwordPlayState(state.word, [...state.playerInput, letter]);
    }
  }

  bool isPlayerInput(String letter) {
    assert(letter.length == 1);
    return state.playerInput.indexOf(letter) == -1 ? false : true;
  }
}
