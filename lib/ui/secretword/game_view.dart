import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_provider.dart';

class GameView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final game = watch(secretwordPlayerInputProvider);
    final gameState = watch(secretwordPlayerInputProvider.state);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: gameState.word
            .map((letter) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(game.isPlayerInput(letter) ? letter : '.',
                      style: TextStyle(fontSize: 32)),
                ))
            .toList(),
      ),
    );
  }
}
