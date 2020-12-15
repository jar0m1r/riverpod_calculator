import 'package:flutter/material.dart';
import 'package:riverpod_calculator/business_logic/player_input/player_input_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlphabetItem<T> {
  final T value;
  final String symbol;

  AlphabetItem(this.value, this.symbol);
}

class AlphabetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = (MediaQuery.of(context).size.width / 7) * 4;

    final buttons = context
        .read(alphabetProvider)
        .map((letter) => AlphabetItem<String>(letter, letter))
        .toList();

    return SizedBox(
      width: width,
      height: height,
      child: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
        children: buttons.map((alphabetItem) {
          return OutlineButton(
            onPressed: () => context
                .read(playerInputProvider)
                .playerInput(alphabetItem.value),
            child: Center(
              child: Text(
                alphabetItem.symbol,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
