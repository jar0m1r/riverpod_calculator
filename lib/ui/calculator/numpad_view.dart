import 'package:flutter/material.dart';
import 'package:riverpod_calculator/business_logic/player_input/player_input_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumpadItem<T> {
  final T value;
  final String symbol;

  NumpadItem(this.value, this.symbol);
}

class NumpadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = (MediaQuery.of(context).size.width / 5) * 4;

    final numberButtons = context
        .read(numbersProvider)
        .map((number) => NumpadItem<String>(number, number))
        .toList();

    final operatorButtons = context
        .read(operatorsProvider)
        .map((_operator) => NumpadItem<String>(_operator, _operator))
        .toList();

    final actionButtons = context
        .read(actionsProvider)
        .map((action) => NumpadItem<String>(action, action))
        .toList();

    final buttons = [...numberButtons, ...operatorButtons, ...actionButtons];
    return SizedBox(
      width: width,
      height: height,
      child: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        children: buttons.map((button) {
          return OutlineButton(
            onPressed: () =>
                context.read(playerInputProvider).playerInput(button.value),
            child: Center(
              child: Text(
                button.symbol,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
