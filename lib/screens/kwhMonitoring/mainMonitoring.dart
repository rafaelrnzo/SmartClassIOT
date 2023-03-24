import 'package:google_fonts/google_fonts.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/widget/widgetAppbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

void main() {
  return runApp(ChartApp());
}

class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MonitoringPage(),
    );
  }
}

class _MonitoringPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MonitoringPage({Key? key}) : super(key: key);

  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<_MonitoringPage>
    with SingleTickerProviderStateMixin {
  List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40),
    SalesData('June', 230),
    SalesData('July', 310),
    SalesData('August', 310),
  ];

  late TabController _tabController;

  final _selectedColor = highlight;
  final _unselectedColor = secondary;
  final _tabs = const [
    Tab(text: 'Week'),
    Tab(text: 'Month'),
    Tab(text: 'Year'),
  ];

  final _iconTabs = const [
    Tab(icon: Icon(Icons.home)),
    Tab(icon: Icon(Icons.search)),
    Tab(icon: Icon(Icons.settings)),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: kwhAppbar(),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: kToolbarHeight - 8.0,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: _selectedColor),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              tabs: _tabs,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: height * 0.28,
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                title: AxisTitle(
                                  text: 'Days',
                                  textStyle: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                majorGridLines: MajorGridLines(
                                  width: 0,
                                ),
                                axisLine: AxisLine(
                                  width: 0,
                                ),
                              ),
                              primaryYAxis: NumericAxis(
                                isVisible: true,
                                majorGridLines: MajorGridLines(
                                  width: 0,
                                ),
                                axisLine: AxisLine(
                                  width: 0,
                                ),
                              ),
                              plotAreaBorderWidth: 0,
                              selectionType: SelectionType.cluster,
                              margin: EdgeInsets.only(top: 0),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<SalesData, String>>[
                                ColumnSeries<SalesData, String>(
                                  dataSource: data,
                                  color: highlight,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales,
                                  name: 'kWh',
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: false),
                                  selectionBehavior: SelectionBehavior(
                                    enable: true,
                                    selectedColor: highlight,
                                  ),
                                ),
                              ],
                              zoomPanBehavior: ZoomPanBehavior(
                                enableSelectionZooming: true,
                                selectionRectBorderColor: Colors.red,
                                selectionRectBorderWidth: 1,
                                selectionRectColor: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Kwh",
                                style: bold16Prim(),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CardMonitoring(
                                    iconData: Ionicons.flash,
                                    width: width,
                                    desc: 'Total Per Day',
                                    kwh: '100',
                                    height: width / 5,
                                  ),
                                  CardMonitoring(
                                    iconData: Ionicons.flash,
                                    width: width,
                                    desc: 'Total Per Day',
                                    kwh: '100',
                                    height: width / 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
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
                                    height: width / 5.2,
                                  ),
                                  CardMonitoring(
                                    iconData: Ionicons.snow,
                                    width: width,
                                    kwh: '20',
                                    desc: 'AC',
                                    height: width / 5.2,
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
                                    height: width / 5.1,
                                  ),
                                  CardMonitoring(
                                    iconData: Ionicons.snow,
                                    width: width,
                                    desc: 'Total Per Day',
                                    kwh: '8',
                                    height: width / 5.1,
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
                                    height: width / 5.2,
                                  ),
                                  CardMonitoring(
                                    iconData: Ionicons.snow,
                                    width: width,
                                    desc: 'Total Per Day',
                                    kwh: '100',
                                    height: width / 5.2,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ),
        ]));
  }
}

class SalesData {
  final String year;
  final double sales;

  SalesData(this.year, this.sales);
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

class MaterialDesignIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  const MaterialDesignIndicator({
    required this.indicatorHeight,
    required this.indicatorColor,
  });

  @override
  createBoxPainter([VoidCallback? onChanged]) {
    return _MaterialDesignPainter(this, onChanged);
  }
}

class _MaterialDesignPainter extends BoxPainter {
  final MaterialDesignIndicator decoration;

  _MaterialDesignPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Rect rect = Offset(
          offset.dx,
          configuration.size!.height - decoration.indicatorHeight,
        ) &
        Size(configuration.size!.width, decoration.indicatorHeight);

    final Paint paint = Paint()
      ..color = decoration.indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topRight: const Radius.circular(8),
        topLeft: const Radius.circular(8),
      ),
      paint,
    );
  }
}
