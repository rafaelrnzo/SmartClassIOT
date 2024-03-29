// ignore_for_file: file_names, implementation_imports, unnecessary_import, unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_smartclass/widget/homepage/card.dart';
import 'package:flutter_smartclass/widget/homepage/cardWeather.dart';
import 'package:flutter_smartclass/widget/homepage/deviceCard.dart';
import 'package:flutter_smartclass/widget/widgetAppbar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  var temp;
  var weather;
  var icon;
  final String uuid;

  HomePage({super.key, required this.uuid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgWhite,
      appBar: homeAppbar(context),
      body: RefreshIndicator(
        displacement: 20,
        backgroundColor: bgWhite,
        color: highlight,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1500));
          setState(() {});
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: Colors.white,
                child: Column(children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: HeaderCard(
                      width: width,
                      icon: '${widget.icon}',
                      temp: '${widget.temp}',
                      weather: '${widget.weather}',
                    ),
                  ),
                  Flexible(flex: 4 , child: allCard(width: width)),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
