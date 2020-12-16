import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ShowResult extends StatefulWidget {
  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 4))
      ..play();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerCenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //CENTER -- Blast
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
          ),
        ),
      ],
    );
  }
}
