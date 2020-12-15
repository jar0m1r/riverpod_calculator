import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_provider.dart';
import 'package:riverpod_calculator/business_logic/secretword/secretword_state.dart';

class PlayerInputView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlayerInputViewState();
}

class PlayerInputViewState extends State<PlayerInputView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  List<String> playerInput = []; //! initial state not like this

  PlayerInputViewState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  _updatePlayerInput(List<String> input) {
    setState(() {
      playerInput = input;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);

    return ProviderListener(
      provider: secretwordPlayerInputProvider.state,
      onChange: (context, SecretwordState state) {
        _updatePlayerInput(state.playerInput);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: playerInput
            .map((letter) => ScaleTransition(
                  scale: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(curvedAnimation),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(letter, style: TextStyle(fontSize: 24)),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
