import 'package:flutter/material.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_provider.dart';
import 'package:riverpod_calculator/services/theme_manager/theme_manager.dart';
import 'package:riverpod_calculator/ui/secretword/alphabet_view.dart';
import 'package:riverpod_calculator/ui/secretword/game_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecretwordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: GameView()),
              AlphabetView(),
            ],
          ),
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            context.read(themeManagerProvider).toggle();
            context.read(secretwordPlayerInputProvider).newGame();
          },
        ),
      ]),
    );
  }
}
