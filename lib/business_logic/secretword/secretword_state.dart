import 'package:equatable/equatable.dart';

abstract class SecretwordState extends Equatable {
  final List<String> word;
  final List<String> playerInput;

  const SecretwordState(this.word, this.playerInput);
}

class SecretwordInitialState extends SecretwordState {
  const SecretwordInitialState(List<String> word) : super(word, const []);

  @override
  List<Object> get props => [word];
}

class SecretwordPlayState extends SecretwordState {
  const SecretwordPlayState(List<String> word, List<String> playerInput)
      : super(word, playerInput);

  @override
  List<Object> get props => [word, playerInput];
}

class SecretwordPausedState extends SecretwordState {
  const SecretwordPausedState(List<String> word, List<String> playerInput)
      : super(word, playerInput);

  @override
  List<Object> get props => [word, playerInput];
}

class SecretwordFinishedState extends SecretwordState {
  final EndResultType result;
  const SecretwordFinishedState(
      List<String> word, List<String> playerInput, this.result)
      : super(word, playerInput);

  @override
  List<Object> get props => [word, playerInput];
}

enum EndResultType { win, lose }
