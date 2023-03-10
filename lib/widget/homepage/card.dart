// ignore_for_file: camel_case_types, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: primary,
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearColor().createShader(bounds);
                          },
                          child: Text("18°C", style: bold24White())),
                      const SizedBox(height: 8),
                      Text('Cloudy', style: bold16White()),
                      const SizedBox(height: 3),
                      Text(
                        DateFormat('dd MMMM yyyy').format(DateTime.now()),
                        style: med12Sec(),
                      ),
                    ]),
                Icon(
                  Icons.cloud,
                  size: 70,
                  color: secondary,
                )
              ]),
              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Indor Temp',
                        style: med14Sec(),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '20°C',
                        style: bold16White(),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Indor Temp',
                        style: med14Sec(),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '10%',
                        style: bold16White(),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        decoration: BoxDecoration(
            color: widget.varType ? primary : secondary,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          height: widget.width / 2.35,
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
                      CircleAvatar(
                        radius: 23,
                        backgroundColor:
                            widget.varType ? Colors.white : primary,
                        child: Icon(
                          widget.iconData,
                          color: widget.varType ? highlight : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('${widget.deviceType}',
                          style: widget.varType
                              ? bold16Highlight()
                              : bold16Prim()),
                      Text(
                        "${widget.deviceValue}",
                        style: GoogleFonts.inter(
                            color: widget.varType ? Colors.white : primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlutterSwitch(
                        activeToggleColor: highlight,
                        toggleColor: secondary,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        width: widget.width / 7.5,
                        height: widget.width * 0.08,
                        value: widget.varType,
                        onToggle: (value) {
                          setState(() {
                            widget.varType = value;
                          });
                        },
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class allCard extends StatefulWidget {
  const allCard({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<allCard> createState() => _allCardState();
}

class _allCardState extends State<allCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text("Devices", style: bold20Prim()),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      lamp = !lamp;
                    });
                  },
                  child: cardDeviceBoard(
                    deviceType: "Smart Lamp",
                    deviceValue: "4 Devices",
                    width: widget.width,
                    varType: lamp,
                    iconData: Ionicons.bulb,
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      ac = !ac;
                    });
                  },
                  child: cardDeviceBoard(
                    deviceType: "Smart AC",
                    deviceValue: "4 Devices",
                    width: widget.width,
                    varType: ac,
                    iconData: Ionicons.snow,
                  )),
            ]),
          ],
        ),
      ),
      Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              curtain = !curtain;
                            });
                          },
                          child: cardDeviceBoard(
                            deviceType: "Smart Curtain",
                            deviceValue: "2 Devices",
                            width: widget.width,
                            varType: curtain,
                            iconData: Icons.curtains_closed_rounded,
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              switchs = !switchs;
                            });
                          },
                          child: cardDeviceBoard(
                            deviceType: "Smart Switchs",
                            deviceValue: "4 Devices",
                            width: widget.width,
                            varType: switchs,
                            iconData: Ionicons.toggle,
                          )),
                    ]),
              ],
            ),
          )),
      Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              board = !board;
                            });
                          },
                          child: cardDeviceBoard(
                            deviceType: "Smart Audio",
                            deviceValue: "2 Devices",
                            width: widget.width,
                            varType: audio,
                            iconData: Ionicons.musical_notes,
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              audio = !audio;
                            });
                          },
                          child: cardDeviceBoard(
                            deviceType: "Smart Board",
                            deviceValue: "1 Devices",
                            width: widget.width,
                            varType: board,
                            iconData: Ionicons.tv,
                          )),
                    ]),
              ],
            ),
          )),
      SizedBox(
        height: 50,
      )
    ]);
  }
}
