import 'dart:async';

class PlayerInputService {
  PlayerInputService() {
    _controller = StreamController<String>();
  }
  StreamController<String> _controller;
  Stream<String> get stream => _controller.stream;

  playerInput(String input) {
    assert(alphabet.contains(input));
    print('playerInput: $input');
    _controller.sink.add(input);
  }

  dispose() {
    _controller.close();
  }

  static final alphabet = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
}
