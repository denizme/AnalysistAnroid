import 'package:analysist/ui/home/home_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/boxes.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:intl/intl.dart';

import '../../../models/Followers.dart';
import '../../landing/user_controller.dart';

class NewFollowingsGraph extends StatefulWidget {
  const NewFollowingsGraph({Key? key}) : super(key: key);

  @override
  _NewFollowingsGraphState createState() => _NewFollowingsGraphState();
}

class _NewFollowingsGraphState extends State<NewFollowingsGraph> {
  List<Color> gradientColors = [
    ColorManager.accentColor,
    Color.fromARGB(255, 97, 10, 218)
  ];

  bool showAvg = false;
  bool day = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Icon(
                    Icons.favorite,
                    color: ColorManager.primary,
                    size: 20,
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      size: 8,
                      color: ColorManager.primary,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: getHorizontalSize(10),
              ),
              Text(
                translate('New Followings'),
                style:
                    getMediumStyle(color: ColorManager.primary, fontSize: 15),
              ),
              Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        day = true;
                      });
                    },
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: Container(
                      width: 55,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: !day
                              ? ColorManager.primary.withOpacity(0.1)
                              : ColorManager.primary),
                      child: Center(
                          child: Text(
                        translate("Day"),
                        style: getMediumStyle(
                            color: !day ? ColorManager.primary : Colors.white),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        day = false;
                      });
                    },
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: Container(
                      width: 55,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: day
                              ? ColorManager.primary.withOpacity(0.1)
                              : ColorManager.primary),
                      child: Center(
                          child: Text(
                        translate("Week"),
                        style: getMediumStyle(
                            color: day
                                ? ColorManager.primary
                                : ColorManager.secondary),
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 10.0, left: 10.0, top: 10, bottom: 12),
              child: LineChart(
                !day ? weekData() : dayData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgetsForWeek(double value, TitleMeta meta) {
    var dayFormatter = DateFormat.E();
    var style = getMediumStyle(
      color: ColorManager.primary,
      fontSize: 9,
    );
    Widget text;
    switch (value.toInt()) {
      case 7:
        text = Text('Today', style: style);
        break;
      case 6:
        text = Text(
            dayFormatter.format(DateTime.now().subtract(Duration(days: 1))),
            style: style);
        break;
      case 5:
        text = Text(
            dayFormatter.format(DateTime.now().subtract(Duration(days: 2))),
            style: style);
        break;
      case 4:
        text = Text(
            dayFormatter.format(DateTime.now().subtract(Duration(days: 3))),
            style: style);
        break;
      case 3:
        text = Text(
            dayFormatter.format(DateTime.now().subtract(Duration(days: 4))),
            style: style);
        break;
      case 2:
        text = Text(
            dayFormatter.format(DateTime.now().subtract(Duration(days: 5))),
            style: style);
        break;
      case 1:
        text = Text(
            dayFormatter.format(DateTime.now().subtract(Duration(days: 6))),
            style: style);
        break;

      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget bottomTitleWidgetsForDay(double value, TitleMeta meta) {
    var hmFormatter = DateFormat.Hm();
    var style = getMediumStyle(
      color: ColorManager.primary,
      fontSize: 9,
    );
    Widget text;
    switch (value.toInt()) {
      case 4:
        text = Text(hmFormatter.format(DateTime.now()), style: style);
        break;
      case 3:
        text = Text(
            hmFormatter.format(DateTime.now().subtract(Duration(minutes: 360))),
            style: style);
        break;
      case 2:
        text = Text(
            hmFormatter.format(DateTime.now().subtract(Duration(minutes: 720))),
            style: style);
        break;
      case 1:
        text = Text(
            hmFormatter
                .format(DateTime.now().subtract(Duration(minutes: 1080))),
            style: style);
        break;
      case 4:
        text = Text(
            hmFormatter
                .format(DateTime.now().subtract(Duration(minutes: 1440))),
            style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = getMediumStyle(
      color: ColorManager.primary,
      fontSize: 9,
    );
    String text;
    if (value == getMaxy()) {
      text = getMaxy().toStringAsFixed(0);
    } else if (value == 0) {
      text = "0";
    } else if (value == 0) {
      text = "0";
    } else if (value == 0) {
      text = "0";
    } else if (value == 0) {
      text = "0";
    } else if (value == 0) {
      text = "0";
    } else if (value == 0) {
      text = "0";
    } else {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  double getFollowerCount(int day) {
    var controller = Get.find<UserController>();
    double count = Boxes.getFollowings()
        .values
        .toList()
        .where((element) =>
            element.userIdForAccount != null &&
            element.userIdForAccount == controller.choosenAccount!.userId &&
            DateTime.now().subtract(Duration(days: day)).day ==
                element.timestamp.day &&
            !controller.firstFollowingIds.contains(element.pk.toString()))
        .toList()
        .length
        .toDouble();

    return count;
  }

  double getMaxy() {
    double maxy = getFollowerCount(0);
    if (getFollowerCount(1) > maxy) {
      maxy = getFollowerCount(1);
    } else if (getFollowerCount(2) > maxy) {
      maxy = getFollowerCount(2);
    } else if (getFollowerCount(3) > maxy) {
      maxy = getFollowerCount(3);
    } else if (getFollowerCount(4) > maxy) {
      maxy = getFollowerCount(4);
    } else if (getFollowerCount(5) > maxy) {
      maxy = getFollowerCount(5);
    } else if (getFollowerCount(6) > maxy) {
      maxy = getFollowerCount(6);
    }
    return maxy;
  }

  LineChartData weekData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 7,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgetsForWeek,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          )),
      minX: 0,
      maxX: 7,
      minY: -0.18,
      maxY: getMaxy(),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, getFollowerCount(7)),
            FlSpot(1, getFollowerCount(6)),
            FlSpot(2, getFollowerCount(5)),
            FlSpot(3, getFollowerCount(4)),
            FlSpot(4, getFollowerCount(3)),
            FlSpot(5, getFollowerCount(2)),
            FlSpot(6, getFollowerCount(1)),
            FlSpot(7, getFollowerCount(0))
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.5))
                  .toList(),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  double getFollowerCountDay(int startMinute, int endMinute) {
    double count = Boxes.getFollowings()
        .values
        .toList()
        .where((element) {
          if (DateTime.now().difference(element.timestamp).inMinutes >
                  startMinute &&
              DateTime.now().difference(element.timestamp).inMinutes <
                  endMinute &&
              !Get.find<UserController>()
                  .firstFollowingIds
                  .contains(element.pk.toString())) {
            return true;
          } else {
            return false;
          }
        })
        .toList()
        .length
        .toDouble();

    return count;
  }

  LineChartData dayData() {
    List<FollowerUsers> dailyFollowers = Boxes.getFollowers()
        .values
        .toList()
        .where((element) =>
            DateTime.now().subtract(Duration(days: 0)).day ==
            element.timestamp.day)
        .toList();
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 7,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ColorManager.primary,
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgetsForDay,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.white, width: 0.25)),
      minX: 0,
      maxX: 4,
      minY: -0.18,
      maxY: getMaxy(),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(4, getFollowerCountDay(0, 360)),
            FlSpot(3, getFollowerCountDay(360, 720)),
            FlSpot(2, getFollowerCountDay(720, 1080)),
            FlSpot(1, getFollowerCountDay(1080, 1440)),
            FlSpot(0, getFollowerCountDay(1080, 1440)),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.5))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
