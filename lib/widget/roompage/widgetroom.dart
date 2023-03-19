import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class CircleList extends StatelessWidget {
  String title;
  final VoidCallback onTap;
  IconData icon;
  Color color;
  Color iconColor;
  bool isSelected;
  CircleList({
    Key? key,
    required this.title,
    required this.onTap,
    required this.icon,
    this.color = bgWhite,
    this.iconColor = primary,
    this.isSelected = false,
  }) : super(key: key);

  void changeColor() {
    color = color == secondary ? primary : secondary;
    iconColor = iconColor == primary ? highlight : primary;
    print(color);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5.9,
        right: 5.9,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Transform.scale(
              scale: 0.9,
              child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),

                child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 11,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? primary : bgWhite,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      size: 34,
                      color: isSelected ? highlight : primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: bold15Prim(),
          ),
        ],
      ),
    );
  }
}

class CardDevice extends StatelessWidget {
  IconData icon;
  String status;
  String nameDevice;
  VoidCallback onTap;
  Widget leadingButton;
  Color iconColor;
  Color statsColor;
  CardDevice(
      {Key? key,
      required this.icon,
      required this.status,
      required this.nameDevice,
      required this.onTap,
      required this.leadingButton,
      this.iconColor = secondary,
      this.statsColor = primary50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 6,
                      decoration: const BoxDecoration(
                          color: bgWhite,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Icon(
                        icon,
                        size: 30,
                      )),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status: $status',
                          style: GoogleFonts.inter(
                            color: statsColor,
                          ),
                        ),
                        Text(
                          nameDevice,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [leadingButton],
              )
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
  final IconData icon;
  const RoomWidget({
    Key? key,
    required this.width,
    required this.onTap,
    required this.status,
    required this.roomName,
    required this.totalDevice,
    required this.icon,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
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
                          child: Icon(
                            icon,
                            size: 36.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              status,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: med14prim50(),
                            ),
                          ],
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
                const Icon(
                  Ionicons.chevron_forward,
                  size: 35,
                )
              ],
            ),
            // const SizedBox(height: 20,)
          ],
          
        ),
      ),
    );
  }
}

