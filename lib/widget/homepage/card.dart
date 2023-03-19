// ignore_for_file: camel_case_types, avoid_print, annotate_overrides, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_const, unused_import

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_smartclass/model/modelRoom.dart';
import 'package:flutter_smartclass/widget/shimmerin.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class cardDeviceBoard extends StatefulWidget {
  cardDeviceBoard({
    super.key,
    required this.width,
    required this.deviceType,
    required this.deviceValue,
    required this.varType,
    required this.iconData,
  });

  IconData iconData;
  bool varType;
  String deviceType;
  String deviceValue;
  double width;

  @override
  State<cardDeviceBoard> createState() => _cardDeviceBoardState();
}

class _cardDeviceBoardState extends State<cardDeviceBoard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: AnimatedContainer(
        decoration: const BoxDecoration(
            color: secondary,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          height: widget.width / 3,
          width: widget.width / 2.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor:
                                widget.varType ? highlight : primary,
                            child: Icon(
                              widget.iconData,
                              color: Colors.white,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: FlutterSwitch(
                              activeToggleColor: highlight,
                              toggleColor: primary,
                              activeColor: bgWhite,
                              inactiveColor: bgWhite,
                              width: widget.width * 0.11,
                              height: widget.width * 0.07,
                              value: widget.varType,
                              onToggle: (value) {
                                setState(() {
                                  widget.varType = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text('${widget.deviceType}',
                          style: widget.varType
                              ? bold15Highlight()
                              : bold15Prim()),
                      SizedBox(height: 2),
                      Text(
                        "${widget.deviceValue}",
                        style: GoogleFonts.inter(
                            color: widget.varType ? highlight : primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  //
                ]),
          ),
        ),
      ),
    );
  }
}
