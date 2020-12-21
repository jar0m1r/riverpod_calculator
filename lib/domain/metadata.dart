import 'package:hooks_riverpod/hooks_riverpod.dart';

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
