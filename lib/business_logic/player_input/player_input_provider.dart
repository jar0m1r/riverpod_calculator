import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/player_input/player_input_service.dart';

final playerInputProvider =
    Provider<PlayerInputService>((ref) => PlayerInputService());
