// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_smartclass/model/room.dart';
import 'package:flutter_smartclass/services/user_services.dart';
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
  bool _locationPermissionRequested = false;
  late List device = [];

  @override
  void initState() {
    super.initState();
    try {
      _getLocationPermission();
      getCurrentLocation();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getLocationPermission() async {
    if (_locationPermissionRequested) {
      return;
    }

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
    setState(() {
      try {
        temp = result['main']['temp'];
        weather = result['weather'][0]['main'];
        icon = result['weather'][0]['icon'];
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
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
                          child: Column(
                            children: [
                              if (temp != null)
                                Text('${temp?.toStringAsFixed(0) ?? ''}\u00B0C',
                                    style: bold24White()),
                            ],
                          )),
                      const SizedBox(height: 8),
                      if (weather != null)
                        Text(weather?.toString() ?? '', style: bold16White()),
                      const SizedBox(height: 3),
                      Text(
                        DateFormat('dd MMMM yyyy').format(DateTime.now()),
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
            borderRadius: const BorderRadius.all(Radius.circular(20))),
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
                        "${widget.deviceValue} Devices",
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
                            print(value);
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
  allCard({
    super.key,
    required this.width,
    required this.varType,
  });
  bool varType;

  final double width;

  @override
  State<allCard> createState() => _allCardState();
}

class _allCardState extends State<allCard> {
  late List feature = [];
  late List room = [];
  bool isLoading = false;
  List<Room> rooms = [];
  Room? _selectedItem;
  late List _classData = [];

  @override
  void initState() {
    fetchApiFeature();
    _fetchDataClass();
    fetchApiRoom().then((items) {
      setState(() {
        rooms = items;
        _selectedItem = rooms[0];
      });
    });
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

  Future<void> _fetchDataClass() async {
    try {
      final response = await http.get(
        Uri.parse('http://smartlearning.solusi-rnd.tech/api/data-rooms'),
      );
      setState(() {
        _classData = jsonDecode(response.body);
      });
    } catch (e) {
      print("Exception: $e");
    }
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Devices", style: bold20Prim()),
                DropdownButton<Room>(
                  value: _selectedItem,
                  items: rooms.map((item) {
                    return DropdownMenuItem<Room>(
                      value: item,
                      child: Text('${item.name}'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedItem = newValue;
                      print(_selectedItem?.name);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Wrap(
                children: [
                  for (var data in feature)
                    InkWell(
                        onTap: () {
                          setState(() {
                            widget.varType = !widget.varType;
                          });
                        },
                        child: cardDeviceBoard(
                          deviceType: "${data['name_feature']}",
                          deviceValue: _selectedItem?.name == 'TEDK'
                              ? "${_classData[0]['available_devices']}"
                              : _selectedItem?.name == 'TAV1'
                                  ? "${_classData[1]['available_devices']}"
                                  : _selectedItem?.name == 'TAV2'
                                      ? "${_classData[2]['available_devices']}"
                                      : _selectedItem?.name == 'TFLM'
                                          ? "${_classData[3]['available_devices']}"
                                          : 'Device unknown',
                          width: widget.width,
                          varType: widget.varType,
                          iconData: data['name_feature'] == 'LAMP'
                              ? Ionicons.bulb
                              : data['name_feature'] == 'AC'
                                  ? Ionicons.snow
                                  : data['name_feature'] == 'SENSOR SUHU'
                                      ? Ionicons.thermometer
                                      : data['name_feature'] == 'KWH MONITORING'
                                          ? Ionicons.logo_electron
                                          : Icons.control_camera_sharp,
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
