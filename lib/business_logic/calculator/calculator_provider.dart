import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/calculator/calculator_logic.dart';
import 'package:riverpod_calculator/business_logic/player_input/player_input_provider.dart';

final calculatorProvider = ChangeNotifierProvider((ref) {
  final numbers = ref.read(numbersProvider);
  final operators = ref.read(operatorsProvider);
  final actions = ref.read(actionsProvider);

  final inputStream = ref
      .read(playerInputProvider)
      .stream; //! this should be using StreamProvider!
  return CalculatorLogic(inputStream, numbers, operators, actions);
});
