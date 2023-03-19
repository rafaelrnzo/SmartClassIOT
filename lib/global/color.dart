// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

// import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

const Color primary = Color.fromRGBO(18, 40, 61, 1);
const Color highlight = Color.fromRGBO(20, 124, 218, 1);
const Color bgWhite = Color.fromRGBO(238, 238, 238,1)	;
const Color secondary = Color.fromRGBO(255, 255, 255, 1)	;

const Color secondary60 = Color.fromRGBO(214, 228, 240, 0.8);
const Color primary50 = Color.fromRGBO(18, 40, 61, 0.5);
const Color highlight2 = Color.fromRGBO(210, 4, 253, 1);

LinearGradient LinearColor() {
  return LinearGradient(
        colors: const [highlight, highlight2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
LinearGradient nullb() {
  return LinearGradient(
        colors: const [primary, primary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
