import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_calculator/business_logic/player_input/player_input_provider.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_logic.dart';
import 'package:riverpod_calculator/business_logic/secretword_solver/secretword_solver.dart';

final secretwordProvider = StateNotifierProvider((ref) => SecretwordLogic());

final secretwordPlayerInputProvider =
    StateNotifierProvider<SecretwordLogic>((ref) {
  final inputProvider = ref.watch(playerInputProvider);
  return SecretwordLogic(inputStream: inputProvider.stream);
});

final secretwordSolverProvider = StateNotifierProvider<SecretwordLogic>((ref) {
  final secretwordLogic = SecretwordLogic();
  SecretwordSolver(secretwordLogic.inputLetter)..solve();
  return secretwordLogic;
});
