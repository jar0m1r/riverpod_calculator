// import 'package:flutter/material.dart';

// class NumpadItem<T> {
//   final T value;
//   final String symbol;

//   NumpadItem(this.value, this.symbol);

// class NumpadView extends StatelessWidget {
//   final List<NumpadItem<String> inputTypeSymbols = [

//   ];

//   @override
//   Widget build(BuildContext context) {
//     final calculatorBloc = BlocProvider.of<CalculationBloc>(context);
//     final width = MediaQuery.of(context).size.width;
//     final height = (MediaQuery.of(context).size.width / 5) * 4;
//     return SizedBox(
//       width: width,
//       height: height,
//       child: GridView(
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
//         children: inputTypeSymbols.map((numpadItem) {
//           return OutlineButton(
//             onPressed: () => calculatorBloc.add(numpadItem.event),
//             child: Center(
//               child: Text(
//                 numpadItem.symbol,
//                 style: const TextStyle(fontSize: 24),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
