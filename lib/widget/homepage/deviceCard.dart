import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_smartclass/model/modelRoom.dart';
import 'package:flutter_smartclass/widget/homepage/card.dart';
import 'package:flutter_smartclass/widget/shimmerin.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

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
  late List roomAja = [];
  bool isLoading = false;
  List<Room> roomApi = [];
  Room? selectedItems;
  late List _classData = [];
  String dropdownValue = 'Option 1'; // opsi default yang terpilih

  Future<List<Room>> fetchApiRoom() async {
    final response = await http
        .get(Uri.parse('http://smartlearning.solusi-rnd.tech/api/rooms'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Room> rooms = body.map((room) => Room.fromJson(room)).toList();
      return rooms;
    } else {
      throw "Failed to fetch items";
    }
  }

  @override
  void initState() {
    try {
      fetchApiRoom().then((items) {
        setState(() {
          roomApi = items;
          selectedItems = roomApi[0];
        });
      });
      fetchApiFeature();
      fetchApiRooms();
      super.initState();
    } catch (e) {
      print(e);
    }
  }

  void fetchApiRooms() async {
    String apiUrl = 'http://smartlearning.solusi-rnd.tech/api/rooms';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var result = jsonDecode(response.body);
    setState(() {
      try {
        isLoading = true;
        roomAja = jsonDecode(response.body);
      } catch (e) {
        print(e);
      }
    });
  }

  void fetchApiFeature() async {
    String apiUrl = 'http://smartlearning.solusi-rnd.tech/api/rooms';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var result = jsonDecode(response.body);
    setState(() {
      try {
        isLoading = true;
        _classData = jsonDecode(response.body);
      } catch (e) {
        print(e);
      }
    });
  }

  // bool ${data['name_feature']} = ${data['name_feature']};

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Devices", style: bold20Prim()),
                        DropdownButton<Room>(
                            value: selectedItems,
                            icon: const Icon(
                                Ionicons.chevron_down), // ikon panah bawah
                            iconSize: 24,
                            elevation: 16,
                            style: med16Prim(),
                            underline: Container(
                              height: 2,
                              color: highlight,
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedItems = value;
                              });
                            },
                            items: roomApi.map((item) {
                              return DropdownMenuItem<Room>(
                                value: item,
                                child: Text(
                                  '${item.name}',
                                  style: med16Prim(),
                                ),
                              );
                            }).toList())
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(spacing: 10, runSpacing: 10, children: [
                    for (var data in _classData)
                      InkWell(
                          onTap: () {
                            // TODO = ganti variable bool nya
                            setState(() {
                              data['name_feature'] == 'LAMP'
                                  ? lamp = !lamp
                                  : data['name_feature'] == 'AC'
                                      ? ac = !ac
                                      : data['name_feature'] == 'SENSOR SUHU'
                                          ? curtain = !curtain
                                          : data['name_feature'] ==
                                                  'KWH MONITORING'
                                              ? switchs = !switchs
                                              : audio = !audio;
                            });
                          },
                          child: cardDeviceBoard(
                            deviceType: "${data['name_feature']}",
                            deviceValue: selectedItems?.name == 'TEDK'
                                ? "${roomAja[0]['available_devices']} Devices"
                                : selectedItems?.name == 'TAV1'
                                    ? "${roomAja[1]['available_devices']} Devices"
                                    : selectedItems?.name == 'TAV2'
                                        ? "${roomAja[2]['available_devices']} Devices"
                                        : selectedItems?.name == 'TFLM'
                                            ? "${roomAja[3]['available_devices']} Devices"
                                            : 'Device unknown',
                            width: widget.width,
                            varType: data['name_feature'] == 'LAMP'
                                ? lamp
                                : data['name_feature'] == 'AC'
                                    ? ac
                                    : data['name_feature'] == 'SENSOR SUHU'
                                        ? curtain
                                        : data['name_feature'] ==
                                                'KWH MONITORING'
                                            ? switchs
                                            : audio,
                            iconData: data['name_feature'] == 'LAMP'
                                ? Ionicons.bulb
                                : data['name_feature'] == 'AC'
                                    ? Ionicons.snow
                                    : data['name_feature'] == 'SENSOR SUHU'
                                        ? Ionicons.thermometer
                                        : data['name_feature'] ==
                                                'KWH MONITORING'
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
          ])
        : HomeCardShimmer();
  }
}
