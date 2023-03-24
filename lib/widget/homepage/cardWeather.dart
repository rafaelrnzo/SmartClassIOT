

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
    try {
      _getLocationPermission();
      getCurrentLocation();
    } catch (e) {
      print(e);
    }
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
      setState(() {
      try {
        temp = result['main']['temp'];
        weather = result['weather'][0]['main'];
        icon = result['weather'][0]['icon'];
        isLoading = true;
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: const EdgeInsets.symmetric(horizontal: 16,),
      child: isLoading
          ? Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
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
                  )),
            )
          : const DegreeShimmer(),
    );
  }
}