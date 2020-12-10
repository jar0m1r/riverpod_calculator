import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_logic.dart';
import 'package:riverpod_calculator/business_logic/secretword_solver/secretword_solver.dart';

final secretwordProvider = StateNotifierProvider((ref) => SecretwordLogic());

final secretwordSolverProvider = StateNotifierProvider<SecretwordLogic>((ref) {
  final secretwordLogic = SecretwordLogic();
  SecretwordSolver(secretwordLogic.inputLetter)..solve();
  return secretwordLogic;
});
