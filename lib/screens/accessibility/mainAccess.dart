// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/screens/accessibility/room/mainRoom.dart';
import 'package:flutter_smartclass/widget/roompage/widgetroom.dart';
import 'package:flutter_smartclass/widget/shimmerin.dart';
import 'package:flutter_smartclass/widget/widgetAppbar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  late List cardRoom = [];
  bool isLoadingAcs = false ;
  @override
  void initState() {
    try {
      fetchApi();
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  void fetchApi() async {
    String apiUrl = 'http://smartlearning.solusi-rnd.tech/api/rooms';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var result = jsonDecode(response.body);
     setState(() {
      isLoadingAcs = true;
      cardRoom = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: accesAppbar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16,),
          child: 
          isLoadingAcs?
          Column(
            children: [
              for (var data in cardRoom)
                RoomWidget(
                    width: width,
                    onTap: () {
                      if (data['available_devices'] == 0) {
                        print('not device connected');
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoomPage(
                                    roomName: '${data['name_room']}',
                                  )),
                        );
                      }
                    },
                    status: data['available_devices'] > 0
                        ? 'Connected'
                        : 'Not Connected',
                    roomName: '${data['name_room']}',
                    totalDevice: '${data['available_devices']}',
                    icon: data['name_room'].contains('TEDK')
                        ? Icons.electric_bolt
                        : data['name_room'].contains('TAV')
                            ? Icons.movie_sharp
                            : data['name_room'].contains('TFLM')
                                ? Icons.precision_manufacturing
                                : Icons.device_unknown)
            ],
          ): Column(
            children: [
              AccessRoomShimmer(width: width),
              AccessRoomShimmer(width: width),
              AccessRoomShimmer(width: width),
              AccessRoomShimmer(width: width),
              AccessRoomShimmer(width: width),
              AccessRoomShimmer(width: width),
              AccessRoomShimmer(width: width),
            ],
          )
        ),
      ),
    );
  }
}
