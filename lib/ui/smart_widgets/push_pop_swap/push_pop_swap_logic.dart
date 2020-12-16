import 'package:hooks_riverpod/all.dart';

//TODO make generic
class PushPopSwapLogic extends StateNotifier<PushPopSwapState> {
  PushPopSwapLogic(Stream<List<String>> stream)
      : super(PushPopSwapState<String>([], [], [])) {
    stream.listen((stack) {
      changeStackTo(stack);
    });
  }

  changeStackTo(List<String> newStack) {
    final List<String> previousStack = [...state.stackBase, ...state.stackIn];
    if (previousStack.length < newStack.length) {
      //stack.push
      state = PushPopSwapState<String>(
          previousStack, [], newStack.sublist(previousStack.length));
    } else if (previousStack.length < newStack.length) {
      //stack.pop
      state = PushPopSwapState<String>(
          newStack, previousStack.sublist(newStack.length), []);
    } else if (previousStack.isNotEmpty &&
        newStack.isNotEmpty &&
        previousStack.last != newStack.last) {
      //stack.swap (only last)
      state = PushPopSwapState<String>(newStack.sublist(0, newStack.length - 1),
          [previousStack.last], [newStack.last]);
    }
  }
}

class PushPopSwapState<T> {
  final List<T> stackBase;
  final List<T> stackOut;
  final List<T> stackIn;

  PushPopSwapState(this.stackBase, this.stackOut, this.stackIn);
}
