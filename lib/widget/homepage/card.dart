// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_smartclass/widget/shimmerin.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class HeaderCard extends StatefulWidget {
  var temp;
  var weather;
  var icon;
  HeaderCard(
      {Key? key, required this.width, this.weather, this.icon, this.temp})
      : super(key: key);

  final double width;

  @override
  State<HeaderCard> createState() => _HeaderCardState();
}

class _HeaderCardState extends State<HeaderCard> {
  var temp;
  var weather;
  var icon;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
    getCurrentLocation();
  }

  Future<void> _getLocationPermission() async {
    final PermissionStatus permission =
        await Permission.locationWhenInUse.status;

    if (permission == PermissionStatus.denied) {
      final PermissionStatus permissionStatus =
          await Permission.locationWhenInUse.request();

      if (permissionStatus != PermissionStatus.granted) {
        throw Exception('Location permission is denied');
      }
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getWeatherData(position.latitude, position.longitude);
  }

  Future<void> getWeatherData(double lat, double lon) async {
    String apiKey = "ca2391bde7dc6773060f0709b7272a48";
    String apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
    http.Response response = await http.get(Uri.parse(apiUrl));
    var result = jsonDecode(response.body);
    setState (() {
      temp = result['main']['temp'];
      weather = result['weather'][0]['main'];
      icon = result['weather'][0]['icon'];
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: isLoading
          ? Card(
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return LinearColor()
                                            .createShader(bounds);
                                      },
                                      child: Column(
                                        children: [
                                          if (temp != null)
                                            Text(
                                                '${temp?.toStringAsFixed(0) ?? ''}\u00B0C',
                                                style: bold24White()),
                                        ],
                                      )),
                                  const SizedBox(height: 8),
                                  if (weather != null)
                                    Text(weather?.toString() ?? '',
                                        style: bold16White()),
                                  const SizedBox(height: 3),
                                  Text(
                                    DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()),
                                    style: med12Sec(),
                                  ),
                                ]),
                            if (icon != null)
                              Image.network(
                                "http://openweathermap.org/img/wn/$icon@2x.png",
                                fit: BoxFit.contain,
                                width: 100,
                                height: 100,
                              ),
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
                                '20??C',
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
                  )),
            )
          : const DegreeShimmer(),
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
                        height: 10,
                      ),
                      Text('${widget.deviceType}',
                          style: widget.varType
                              ? bold16Highlight()
                              : bold16Prim()),
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
  late List feature = [];
  bool isLoading = false;

  void initState() {
    fetchApiFeature();
    super.initState();
  }

  void fetchApiFeature() async {
    String apiUrl = 'http://smartlearning.solusi-rnd.tech/api/data-features';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var result = jsonDecode(response.body);
    setState(() {
      isLoading = true;
      feature = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text("Devices", style: bold20Prim()),
              ],
            ),
            const SizedBox(
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
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      audio = !audio;
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
                      board = !board;
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
      ),
      const SizedBox(
        height: 50,
      )
    ]);
  }
}
