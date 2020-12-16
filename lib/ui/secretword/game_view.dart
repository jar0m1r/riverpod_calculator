import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_provider.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_state.dart';
import 'package:riverpod_calculator/ui/secretword/player_input_view.dart';
import 'package:riverpod_calculator/ui/secretword/show_result.dart';

class GameView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final game = watch(secretwordPlayerInputProvider);
    final gameState = watch(secretwordPlayerInputProvider.state);
    return Container(
      child: Column(
        children: [
          SizedBox(height: 100, child: PlayerInputView()),
          if (gameState is SecretwordFinishedState)
            SizedBox(height: 300, child: Center(child: ShowResult())),
          Expanded(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: gameState.word
                      .map((letter) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                                game.isPlayerInput(letter) ? letter : '.',
                                style: TextStyle(fontSize: 32)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
