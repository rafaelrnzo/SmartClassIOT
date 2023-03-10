// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/widget/widgetAppbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AcPage extends StatefulWidget {
  const AcPage({Key? key}) : super(key: key);

  @override
  State<AcPage> createState() => _AcPageState();
}

class _AcPageState extends State<AcPage> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: acAppbar(),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(flex: 2, child: CircleIndicator()),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardAC(
                            width: width,
                            textFeature: "Direction",
                            textFeatureSub: "Direction Down",
                          ),
                          CardAC(
                            width: width,
                            textFeature: "Fan",
                            textFeatureSub: "Auto",
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardAC(
                            width: width,
                            textFeature: "Timer",
                            textFeatureSub: "11.30-15.00",
                          ),
                          CardAC(
                            width: width,
                            textFeature: "Mode",
                            textFeatureSub: "Auto",
                          ),
                        ],
                      ),
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(
                        child: InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 42,
                        backgroundColor: primary,
                        child: Icon(
                          Ionicons.power,
                          size: 42,
                          color: highlight,
                        ),
                      ),
                    )),
                  ))
            ],
          ),
        ));
  }
}

class CardAC extends StatelessWidget {
  CardAC({
    Key? key,
    required this.width,
    required this.textFeature,
    required this.textFeatureSub,
  }) : super(key: key);

  String textFeature;
  String textFeatureSub;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width / 2.25,
      height: width / 3,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 12,
        shadowColor: primary50,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: primary,
                      radius: 16,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${textFeature}",
                      style: bold16Prim(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${textFeatureSub}",
                      style: med14prim50(),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleIndicator extends StatelessWidget {
  const CircleIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 1.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 95.0,
              animation: true,
              lineWidth: 15,
              percent: 0.25,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: primary,
              backgroundColor: secondary,
              center: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '20°C',
                        style: GoogleFonts.chakraPetch(
                          color: primary,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Celsius',
                        style: GoogleFonts.inter(
                          color: primary,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
