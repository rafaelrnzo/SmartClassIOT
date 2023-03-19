// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class AccessRoomShimmer extends StatelessWidget {
  const AccessRoomShimmer({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Color(0xFFEBEBF4),
          highlightColor: Color(0xFFF4F4F4),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ShimmerWidget(
                      width: width * 0.2,
                      height: width * 0.2,
                      radius: 15,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ShimmerWidget(
                          width: width * 0.21,
                          height: width * 0.05,
                          radius: 15,
                        ),
                      ),
                      SizedBox(height: 8),
                      ShimmerWidget(
                        width: width * 0.5,
                        height: width * 0.05,
                        radius: 15,
                      ),
                      SizedBox(height: 8),
                      ShimmerWidget(
                        width: width * 0.16,
                        height: width * 0.05,
                        radius: 15,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }
}

class DegreeShimmer extends StatelessWidget {
  const DegreeShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Color(0xFFEBEBF4),
          highlightColor: Color(0xFFF4F4F4),
          child: ShimmerWidget(width: width, height: width / 5, radius: 20)),
    );
  }
}

class HomeCardShimmer extends StatelessWidget {
  const HomeCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Color(0xFFEBEBF4),
          highlightColor: Color(0xFFF4F4F4),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget(
                        width: width / 2.5, height: width / 9, radius: 20),
                    ShimmerWidget(
                        width: width / 2.5, height: width / 9, radius: 20),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget(
                        width: width / 2.3, height: width / 3, radius: 20),
                    ShimmerWidget(
                        width: width / 2.3, height: width / 3, radius: 20),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget(
                        width: width / 2.3, height: width / 3, radius: 20),
                    ShimmerWidget(
                        width: width / 2.3, height: width / 3, radius: 20),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget(
                        width: width / 2.3, height: width / 3, radius: 20),
                    ShimmerWidget(
                        width: width / 2.3, height: width / 3, radius: 20),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerWidget({
    required this.width,
    required this.height,
    required this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        height: height,
        width: width,
        child: Container(
            color: primary,
            child: const Icon(
              Ionicons.bulb,
              size: 50,
              color: Colors.white,
            )),
      ),
    );
  }
}
