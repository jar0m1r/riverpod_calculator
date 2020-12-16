import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_calculator/ui/smart_widgets/push_pop_swap/push_pop_swap.dart';

class PlayerInputView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlayerInputViewState();
}

class PlayerInputViewState extends State<PlayerInputView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PushPopSwap(animationController: _animationController);
  }
}

//! Remember this below, this is the state of things later solved via combined providers

// import 'package:riverpod_calculator/business_logic/secretword/secretword_provider.dart';
// import 'package:riverpod_calculator/business_logic/secretword/secretword_state.dart';

// class PlayerInputView extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => PlayerInputViewState();
// }

// class PlayerInputViewState extends State<PlayerInputView>
//     with SingleTickerProviderStateMixin {
//   AnimationController _animationController;

//   List<String> _previousInput = []; //! initial state not like this

//   List<String> _staticInput = [];
//   List<String> _incomingInput = [];
//   List<String> _outgoingInput = [];

//   PlayerInputViewState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 800),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _animationController.dispose();
//   }

//   _updatePlayerInput(List<String> newInput) {
//     if (_previousInput.length < newInput.length) {
//       //input added
//       _staticInput = _previousInput;
//       _incomingInput = newInput.sublist(_previousInput.length);
//       _outgoingInput = [];
//     } else if (_previousInput.length < newInput.length) {
//       //input removed
//       _staticInput = newInput;
//       _incomingInput = [];
//       _outgoingInput = _previousInput.sublist(newInput.length);
//     } else if (_previousInput.last != newInput.last) {
//       //input swapped (last)
//       _staticInput = newInput.sublist(0, newInput.length - 1);
//       _incomingInput = [newInput.last];
//       _outgoingInput = [_previousInput.last];
//     }

//     //setState(() {
//     _previousInput = newInput;
//     //});
//     _animationController.reset();
//     _animationController.forward();
//   }

//   List<Widget> _buildStaticInputWidgets() {
//     return _staticInput
//         .map(
//           (input) => Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Text(input, style: TextStyle(fontSize: 24)),
//           ),
//         )
//         .toList();
//   }

//   List<Widget> _buildOutgoingInputWidgets() {
//     final curvedAnimation =
//         CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
//     return _outgoingInput
//         .map((input) => FadeTransition(
//               opacity:
//                   Tween<double>(begin: 1.0, end: 0.0).animate(curvedAnimation),
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(input, style: TextStyle(fontSize: 24)),
//               ),
//             ))
//         .toList();
//   }

//   List<Widget> _buildIncomingInputWidgets() {
//     final curvedAnimation =
//         CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

//     return _incomingInput
//         .map((input) => SlideTransition(
//               position:
//                   Tween<Offset>(begin: Offset(200, 200), end: Offset(0, 0))
//                       .animate(curvedAnimation),
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(input, style: TextStyle(fontSize: 24)),
//               ),
//             ))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('rebuilding');
//     return ProviderListener(
//       provider: secretwordPlayerInputProvider.state,
//       onChange: (context, SecretwordState state) {
//         print('onChange');
//         _updatePlayerInput(state.playerInput);
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           ..._buildStaticInputWidgets(),
//           ..._buildOutgoingInputWidgets(),
//           ..._buildIncomingInputWidgets(),
//         ],
//       ),
//     );
//   }
// }
