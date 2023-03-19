// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/widget/bottomSheet.dart';
import 'package:flutter_smartclass/widget/chartTest.dart';
import 'package:flutter_smartclass/widget/widgetAppbar.dart';
import 'package:ionicons/ionicons.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: kwhAppbar(),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardMonitoring(
                        iconData: Ionicons.flash,
                        width: width,
                        desc: 'Total Per Day',
                        kwh: '100',
                        height: width / 2.5,
                      ),
                      CardMonitoring(
                        iconData: Ionicons.flash,
                        width: width,
                        desc: 'Total Per Day',
                        kwh: '100',
                        height: width / 2.5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Usage',
                        style: bold16Prim(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardMonitoring(
                            iconData: Ionicons.bulb,
                            width: width,
                            kwh: '10',
                            desc: 'Lamp',
                            height: width / 5,
                          ),
                          CardMonitoring(
                            iconData: Ionicons.snow,
                            width: width,
                            kwh: '20',
                            desc: 'AC',
                            height: width / 5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardMonitoring(
                            iconData: Ionicons.bulb,
                            width: width,
                            kwh: '10',
                            desc: 'Switch',
                            height: width / 5,
                          ),
                          CardMonitoring(
                            iconData: Ionicons.snow,
                            width: width,
                            desc: 'Total Per Day',
                            kwh: '8',
                            height: width / 5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardMonitoring(
                            iconData: Ionicons.bulb,
                            width: width,
                            desc: 'Total Per Day',
                            kwh: '100',
                            height: width / 5,
                          ),
                          CardMonitoring(
                            iconData: Ionicons.snow,
                            width: width,
                            desc: 'Total Per Day',
                            kwh: '100',
                            height: width / 5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                    flex: 3,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: primary,
                        child: LineChartSample2()))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class CardMonitoring extends StatelessWidget {
  const CardMonitoring({
    Key? key,
    required this.width,
    required this.height,
    required this.desc,
    required this.kwh,
    required this.iconData,
  }) : super(key: key);

  final String desc;
  final String kwh;
  final double width;
  final double height;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width / 2.21,
      height: height,
      child: Card(
          color: secondary,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: primary,
                      child: Icon(
                        iconData,
                        color: highlight,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$kwh KwH',
                          style: bold16Prim(),
                        ),
                        Text(
                          '$desc',
                          style: med14prim50(),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
