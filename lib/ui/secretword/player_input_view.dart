import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_provider.dart';

class PlayerInputView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: Duration(milliseconds: 2000),
    )..forward();
    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    final gameState = useProvider(secretwordPlayerInputProvider.state);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: gameState.playerInput
          .map((letter) => ScaleTransition(
                scale: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(curvedAnimation),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(letter, style: TextStyle(fontSize: 24)),
                ),
              ))
          .toList(),
    );
  }
}
