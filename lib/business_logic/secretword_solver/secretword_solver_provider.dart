import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/secretword_solver/secretword_solver.dart';

final solverProvider = Provider.family((ref, secretwordLogicProvider) =>
    SecretwordSolver(secretwordLogicProvider));
