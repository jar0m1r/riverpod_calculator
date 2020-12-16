import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:riverpod_calculator/ui/smart_widgets/push_pop_swap/push_pop_swap_provider.dart';

class PushPopSwap extends StatelessWidget {
  final AnimationController animationController;

  const PushPopSwap({Key key, @required this.animationController})
      : super(key: key);

  List<Widget> _buildBaseWidgets(List<String> stackBase) {
    return stackBase
        .map(
          (value) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(value, style: TextStyle(fontSize: 64)),
          ),
        )
        .toList();
  }

  List<Widget> _buildOutWidgets(List<String> stackOut) {
    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    return stackOut
        .map((input) => FadeTransition(
              opacity:
                  Tween<double>(begin: 1.0, end: 0.0).animate(curvedAnimation),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(input, style: TextStyle(fontSize: 64)),
              ),
            ))
        .toList();
  }

  List<Widget> _buildInWidgets(List<String> stackIn) {
    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    return stackIn
        .map((input) => ScaleTransition(
              scale: Tween<double>(begin: 4, end: 1).animate(curvedAnimation),
              child: SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(100, 100), end: Offset(0, 0))
                        .animate(curvedAnimation),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(input, style: TextStyle(fontSize: 64)),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding');
    return Consumer(
      builder: (BuildContext context, watch, _) {
        final state = watch(pushPopSwapProvider.state);

        print('resetting animationController');
        animationController
          ..reset()
          ..forward();

        print('rebuilding consumer');
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ..._buildBaseWidgets(state.stackBase),
            ..._buildOutWidgets(state.stackOut),
            ..._buildInWidgets(state.stackIn),
          ],
        );
      },
    );
  }
}
