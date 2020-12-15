import 'dart:async';

class PlayerInputService {
  StreamController<String> _controller;
  Stream<String> get stream => _controller.stream;

  final List<String> acceptedValues;

  PlayerInputService(this.acceptedValues) {
    _controller = StreamController<String>();
  }

  playerInput(String input) {
    print('player input : $input');
    if (acceptedValues.contains(input)) {
      _controller.sink.add(input);
    }
  }

  dispose() {
    _controller.close();
  }
}
