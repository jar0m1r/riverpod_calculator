import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_provider.dart';
import 'package:riverpod_calculator/ui/smart_widgets/push_pop_swap/push_pop_swap_logic.dart';

//TODO make generic (final step)

final pushPopSwapProvider = StateNotifierProvider<PushPopSwapLogic>((ref) {
  final inputStateProvider = ref.read(secretwordPlayerInputProvider);

  final controller = StreamController<List<String>>();

  ref.onDispose(() => controller.close());

  inputStateProvider.addListener((state) {
    //reason to make this is to not respond to every change in state. only changes to playerInput if not sasme as previous.
    //Now just forwarded a stream of everything. Change this!
    controller.sink.add(state.playerInput);
  });

  return PushPopSwapLogic<String>(controller.stream);
});
