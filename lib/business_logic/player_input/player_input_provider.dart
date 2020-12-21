import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/player_input/player_input_service.dart';
import 'package:riverpod_calculator/domain/metadata.dart';

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
