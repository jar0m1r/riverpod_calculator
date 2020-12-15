import 'package:flutter/foundation.dart';

class CalculatorLogic extends ChangeNotifier {
  List<String> firstOperand;
  List<String> secondOperand;
  String theOperator;
  String result;

  final List<String> numbers;
  final List<String> operators;
  final List<String> actions;

  CalculatorLogic(
      Stream<String> inputStream, this.numbers, this.operators, this.actions) {
    inputStream.listen((event) {
      _handleInput(event);
    });
  }

  _handleInput(String input) {
    print('input >> $input');
    if (numbers.contains(input)) {
      if (result == null) _handleNumberInput(input);
    } else if (operators.contains(input)) {
      if (result == null) _handleOperatorInput(input);
    } else if (actions.contains(input)) {
      _handleActionInput(input);
    }
  }

  _handleNumberInput(String input) {
    if (theOperator == null) {
      _handleFirstOperandInput(input);
    } else {
      _handleSecondOperandInput(input);
    }
  }

  _handleFirstOperandInput(String input) {
    if (firstOperand == null ||
        (firstOperand.length == 1 && firstOperand[0] == '0')) firstOperand = [];
    firstOperand.add(input);
    notifyListeners();
  }

  _handleSecondOperandInput(String input) {
    if (secondOperand == null ||
        (secondOperand.length == 1 && secondOperand[0] == '0'))
      secondOperand = [];
    secondOperand.add(input);
    notifyListeners();
  }

  _handleOperatorInput(String input) {
    if (theOperator == null) {
      theOperator = input;
      notifyListeners();
    }
  }

  _handleActionInput(String input) {
    if (input == '<') {
      if (result == null) {
        if (theOperator == null) {
          if (firstOperand.length > 1) {
            firstOperand.removeAt(firstOperand.length - 1);
          } else {
            firstOperand = ['0'];
          }
        } else {
          if (secondOperand.length > 1) {
            secondOperand.removeAt(secondOperand.length - 1);
          } else {
            secondOperand = ['0'];
          }
        }
      }
      notifyListeners();
    } else if (input == 'C') {
      firstOperand = ['0'];
      secondOperand = null;
      theOperator = null;
      result = null;
      notifyListeners();
    } else if (input == '=') {
      if (firstOperand != null &&
          firstOperand != [] &&
          secondOperand != null &&
          secondOperand != [] &&
          theOperator != null) {
        final first = int.tryParse(
                firstOperand.fold('', (result, value) => '$result$value')) ??
            0;
        final second = int.tryParse(
                secondOperand.fold('', (result, value) => '$result$value')) ??
            0;

        switch (theOperator) {
          case '+':
            result = '${first + second}';
            notifyListeners();
            break;
          case '-':
            result = '${first - second}';
            notifyListeners();
            break;
          case '*':
            result = '${first * second}';
            notifyListeners();
            break;
          case '/':
            if (second != 0) {
              result = (first / second).toStringAsFixed(2);
            } else {
              result = 'err';
            }
            notifyListeners();
            break;
          default:
            break;
        }
      }
    }
  }
}
