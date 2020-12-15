import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/player_input/player_input_service.dart';

final playerInputProvider = Provider<PlayerInputService>((ref) {
  final alphabet = ref.read(alphabetProvider);
  final numbers = ref.read(numbersProvider);
  final operators = ref.read(operatorsProvider);
  final actions = ref.read(actionsProvider);

  return PlayerInputService([
    ...alphabet,
    ...numbers,
    ...operators,
    ...actions,
  ]);
});

final operatorsProvider = Provider((ref) => ['+', '-', '*', '/']);

final actionsProvider = Provider((ref) => ['<', 'C', '=']);

final numbersProvider =
    Provider((ref) => ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']);

final alphabetProvider = Provider((ref) => [
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
    ]);
