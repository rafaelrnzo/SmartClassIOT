import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';

Future<dynamic> acBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: bgWhite,
      context: context,
      shape: const RoundedRectangleBorder( // <-- SEE HERE
        borderRadius: BorderRadius.vertical( 
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              
            ],
          ),
        );
      });
  }