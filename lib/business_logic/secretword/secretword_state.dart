import 'package:equatable/equatable.dart';

abstract class SecretwordState extends Equatable {
  final List<String> word;
  final List<String> playerInput;

  const SecretwordState(this.word, this.playerInput);
}

class SecretwordInitialState extends SecretwordState {
  const SecretwordInitialState(word) : super(word, const ['h', 'm']);

  @override
  List<Object> get props => [word];
}

class SecretwordPlayState extends SecretwordState {
  const SecretwordPlayState(word, playerInput) : super(word, playerInput);

  @override
  List<Object> get props => [word, playerInput];
}

class SecretwordPausedState extends SecretwordState {
  const SecretwordPausedState(word, playerInput) : super(word, playerInput);

  @override
  List<Object> get props => [word, playerInput];
}

class SecretwordFinishedState extends SecretwordState {
  final EndResultType result;
  const SecretwordFinishedState(word, playerInput, this.result)
      : super(word, playerInput);

  @override
  List<Object> get props => [word, playerInput];
}

enum EndResultType { win, lose }
