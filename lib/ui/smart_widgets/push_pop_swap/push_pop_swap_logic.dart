import 'package:hooks_riverpod/all.dart';

class PushPopSwapLogic<T> extends StateNotifier<PushPopSwapState<T>> {
  PushPopSwapLogic(Stream<List<T>> stream)
      : super(PushPopSwapState<T>(<T>[], <T>[], <T>[])) {
    stream.listen((List<T> stack) {
      changeStackTo(stack);
    });
  }

  changeStackTo(List<T> newStack) {
    final List<T> previousStack = [...state.stackBase, ...state.stackIn];
    if (previousStack.length < newStack.length) {
      //stack.push
      state = PushPopSwapState<T>(
          previousStack, [], newStack.sublist(previousStack.length));
    } else if (previousStack.length < newStack.length) {
      //stack.pop
      state = PushPopSwapState<T>(
          newStack, previousStack.sublist(newStack.length), []);
    } else if (previousStack.isNotEmpty &&
        newStack.isNotEmpty &&
        previousStack.last != newStack.last) {
      //stack.swap (only last)
      state = PushPopSwapState<T>(newStack.sublist(0, newStack.length - 1),
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
