//  import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// Widget _dropDown({
//     Widget? underline,
//     Widget? icon,
//     TextStyle? style,
//     TextStyle? hintStyle,
//     Color? dropdownColor,
//     Color? iconEnabledColor,
//   }) =>
//       DropdownButton<String>(
//           value: _selectedFruit,
//           underline: underline,
//           icon: icon,
//           dropdownColor: dropdownColor,
//           style: style,
//           iconEnabledColor: iconEnabledColor,
//           onChanged: (String? newValue) {
//             setState(() {
//               _selectedFruit = newValue;
//             });
//           },
//           hint: Text("Select a fruit", style: hintStyle),
//           items: _fruits
//               .map((fruit) =>
//                   DropdownMenuItem<String>(value: fruit, child: Text(fruit)))
//               .toList());
// }