// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/page/accessibility/room/mainRoom.dart';
import 'package:flutter_smartclass/widget/widgetAppbar.dart';
import 'package:ionicons/ionicons.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: accesAppbar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              RoomWidget(
                  width: width,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RoomPage()),
                    );
                  },
                  status: 'Connected',
                  roomName: 'Room 1',
                  totalDevice: '4')
            ],
          ),
        ),
      ),
    );
  }
}

class RoomWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String status;
  final String roomName;
  final String totalDevice;
  const RoomWidget({
    Key? key,
    required this.width,
    required this.onTap,
    required this.status,
    required this.roomName,
    required this.totalDevice,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: width * 0.2,
                    width: width * 0.2,
                    child: Container(
                        color: primary,
                        child: const Icon(
                          Ionicons.bulb,
                          size: 50,
                          color: Colors.white,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      status,
                      style: med14prim50(),
                    ),
                    Text(
                      roomName,
                      style: bold20Prim(),
                    ),
                    Container(
                      width: 50,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: primary,
                      ),
                      child: Center(
                          child: Text(
                        totalDevice,
                        style: bold16White(),
                      )),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Ionicons.chevron_forward,
              size: 35,
            )
          ],
        ),
      ),
    );
  }
}
