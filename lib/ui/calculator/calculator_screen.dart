import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_calculator/business_logic/calculator/calculator_provider.dart';
import 'package:riverpod_calculator/ui/calculator/numpad_view.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Consumer(
                  builder: (context, watch, child) {
                    final model = watch(calculatorProvider);
                    return Center(
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [
                          if (model.firstOperand != null)
                            CalculationUnitText(model.firstOperand
                                .fold('', (result, value) => '$result$value')),
                          if (model.theOperator != null)
                            CalculationUnitText(model.theOperator),
                          if (model.secondOperand != null)
                            CalculationUnitText(model.secondOperand
                                .fold('', (result, value) => '$result$value')),
                          if (model.result != null)
                            CalculationUnitText('=${model.result}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(child: NumpadView())
            ],
          ),
        ),
      ),
    );
  }
}

class CalculationUnitText extends StatelessWidget {
  final String text;

  const CalculationUnitText(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 64),
    );
  }
}
