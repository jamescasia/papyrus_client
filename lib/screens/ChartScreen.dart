import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/GaugeChart.dart';
import 'package:papyrus_client/helpers/TimeSeriesChart.dart';
import 'package:papyrus_client/helpers/GroupBarChart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:papyrus_client/data_models/UserExpense.dart';
import 'package:papyrus_client/models/ChartsScreenModel.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/cupertino.dart';

class ChartScreen extends StatefulWidget {
  ChartsScreenModel chartsModel;

  ChartScreen(this.chartsModel);
  @override
  _ChartScreenState createState() => new _ChartScreenState(chartsModel);
}

class _ChartScreenState extends State<ChartScreen> {
  ChartsScreenModel chartsModel;

  _ChartScreenState(this.chartsModel);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chartsModel.launch();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: ChartScreenStack());
  }
}

class ChartScreenStack extends StatefulWidget {
  @override
  _ChartScreenStackState createState() => new _ChartScreenStackState();
}

class _ChartScreenStackState extends State<ChartScreenStack> {
  int viewingState = 2;
  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = TextStyle(
        fontSize: 17.4, fontWeight: FontWeight.w500, color: Colors.white);

    TextStyle headerStyleSelected = TextStyle(
        fontSize: 18.4, fontWeight: FontWeight.bold, color: Colors.green[700]);
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return ScopedModel<ChartsScreenModel>(
          model: appModel.chartsScreenModel,
          child: ScopedModelDescendant<ChartsScreenModel>(
              builder: (context, child, chartsModel) {
            return SimpleGestureDetector(
              onHorizontalSwipe: (dir) {
                print("dragged");

                if (dir == SwipeDirection.left) {
                  print("swipedrr");
                  if (appModel.viewing_period == Period.MONTHLY)
                    appModel.viewing_period = Period.WEEKLY;
                  else if (appModel.viewing_period == Period.WEEKLY)
                    appModel.viewing_period = Period.DAILY;
                } else if (dir == SwipeDirection.right) {
                  print("swipedrr");
                  if (appModel.viewing_period == Period.DAILY)
                    appModel.viewing_period = Period.WEEKLY;
                  else if (appModel.viewing_period == Period.WEEKLY)
                    appModel.viewing_period = Period.MONTHLY;
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 50 * sizeMulW,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: sizeMulW * 230,
                                    // color: Colors.red,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                            // right: sizeMulW*-28*sizeMulW,
                                            // left: sizeMulW * 250,
                                            // right:
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.61,
                                            top: sizeMulW * 30,
                                            // top:
                                            // bottom: sizeMulW * -15,
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: SizedBox(
                                                  // color: Colors.black,
                                                  width: sizeMulW * 185,
                                                  height: sizeMulW * 185,
                                                  child: (appModel
                                                                      .dayExpense
                                                                      .totalSpent >
                                                                  0 &&
                                                              appModel.viewing_period ==
                                                                  Period
                                                                      .DAILY ||
                                                          appModel.weekExpense
                                                                      .totalSpent >
                                                                  0 &&
                                                              appModel.viewing_period ==
                                                                  Period
                                                                      .WEEKLY ||
                                                          appModel.monthExpense
                                                                      .totalSpent >
                                                                  0 &&
                                                              appModel.viewing_period ==
                                                                  Period
                                                                      .MONTHLY)
                                                      ? GaugeChart(
                                                          chartsModel
                                                              .generateGaugeChartData(
                                                                  appModel
                                                                      .viewing_period),
                                                          animate: true,
                                                        )
                                                      : Stack(
                                                          children: <Widget>[
                                                            GaugeChart
                                                                .withSampleData(),
                                                            RotatedBox(
                                                              quarterTurns: 1,
                                                              child: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .sadCry,
                                                                      size:
                                                                          sizeMulW *
                                                                              33,
                                                                      color: Colors
                                                                              .grey[
                                                                          700],
                                                                    ),
                                                                    Text(
                                                                      "NO DATA",
                                                                      textScaleFactor:
                                                                          1.3,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Colors.grey[700]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                            )),
                                        Positioned(
                                          left: sizeMulW * 20,
                                          top: sizeMulW * 114,
                                          child: GaugeChartLegendItem(
                                              "Food", Color(0xfff4a735)),
                                        ),
                                        // new DataSegment("totalSpentOnFood",
                                        //           appModel.dayExpense.totalSpentOnFood, "#f4a735"),
                                        //       new DataSegment("totalSpentOnLeisure",
                                        //           appModel.dayExpense.totalSpentOnLeisure, "#fef09c"),
                                        //       new DataSegment("totalSpentOnTransportation",
                                        //           appModel.dayExpense.totalSpentOnTransportation, "#8ec8f8"),
                                        //       new DataSegment("totalSpentOnUtilities",
                                        //           appModel.dayExpense.totalSpentOnUtilities, "#a1d2a6"),
                                        //       new DataSegment("totalSpentOnMiscellaneous",
                                        //           appModel.dayExpense.totalSpentOnMiscellaneous, "#ee9698"),

                                        Positioned(
                                          left: sizeMulW * 108,
                                          top: sizeMulW * 118,
                                          child: GaugeChartLegendItem(
                                              "Leisure", Color(0xfffef09c)),
                                        ),
                                        Positioned(
                                          left: sizeMulW * 197,
                                          top: sizeMulW * 108,
                                          child: GaugeChartLegendItem(
                                              "Misc.", Color(0xffee9698)),
                                        ),
                                        Positioned(
                                          left: sizeMulW * 13,
                                          top: sizeMulW * 154,
                                          child: GaugeChartLegendItem(
                                              "Transpo.", Color(0xff8ec8f8)),
                                        ),
                                        // Positioned(
                                        //   left: sizeMulW * 103,
                                        //   top: sizeMulW * 156,
                                        //   child: GaugeChartLegendItem(
                                        //       "School", Colors.green[200]),
                                        // ),
                                        Positioned(
                                          left: sizeMulW * 112,
                                          top: sizeMulW * 160,
                                          child: GaugeChartLegendItem(
                                              "Utilities", Color(0xffa1d2a6)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // AnimatedCircularChart(
                                  //   holeRadius: sizeMulW*30,
                                  //   holeLabel: "hey",
                                  //   size: const Size(300.0, 300.0),
                                  //   startAngle: 3.1415/2,

                                  //   initialChartData: chartsModel.data,
                                  //   chartType: CircularChartType.Radial,
                                  // ),
                                  // // // Text(),

                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              ConstrainedBox(
                                                constraints: new BoxConstraints(
                                                  // minHeight: 100*sizeMulW,
                                                  minWidth: 160 * sizeMulW,

                                                  // maxHeight: 30.0,
                                                  // maxWidth: 30.0,
                                                ),
                                                child: Material(
                                                  // shape: CircleBorder(),
                                                  color:
                                                      Colors.white.withAlpha(0),
                                                  child: InkWell(
                                                    // on
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15 * sizeMulW)),
                                                    onTap: () {
                                                      // print(result);
                                                    },
                                                    splashColor: Colors
                                                        .greenAccent
                                                        .withAlpha(0),
                                                    highlightColor: Colors.green
                                                        .withAlpha(0),
                                                    child: Container(
                                                      // height: sizeMulW * 80,
                                                      // padding: EdgeInsets.all(
                                                      //     MediaQuery.of(context)
                                                      //             .size
                                                      //             .width *
                                                      //         0.042),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          (appModel.loadedUserExpense)
                                                              ? Text(((appModel.viewing_period == Period.DAILY && appModel.loadedUserExpense) ? addCommas(int.parse(appModel.userExpense.lastDateTotalExpenseAmount.toStringAsFixed(2).split('.')[0])) : (appModel.viewing_period == Period.MONTHLY && appModel.loadedUserExpense) ? addCommas(int.parse(appModel.userExpense.lastMonthTotalExpenseAmount.toStringAsFixed(2).split('.')[0])) : (appModel.viewing_period == Period.WEEKLY && appModel.loadedUserExpense) ? addCommas(int.parse(appModel.userExpense.lastWeekTotalExpenseAmount.toStringAsFixed(2).split('.')[0])) : "0") + ".",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.09,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors.grey[
                                                                          700]))
                                                              : Text("0 ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          MediaQuery.of(context).size.width *
                                                                              0.09,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .grey[700])),

                                                          (appModel
                                                                  .loadedUserExpense)
                                                              ? Container(
                                                                  padding: EdgeInsets.only(
                                                                      bottom: 4 *
                                                                          sizeMulW),
                                                                  child: Text(
                                                                      decimalDigits(
                                                                          appModel),
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.05,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.grey[700])),
                                                                )
                                                              : Container(
                                                                  padding: EdgeInsets.only(
                                                                      bottom: 4 *
                                                                          sizeMulW),
                                                                  child: Text(
                                                                      "00",
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.05,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.grey[700])),
                                                                ),

                                                          // ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .all(Radius
                                                                .circular(15 *
                                                                    sizeMulW)),
                                                        // border: Border.all(
                                                        //     color:
                                                        //         Colors.white,
                                                        //     width: MediaQuery.of(
                                                        //                 context)
                                                        //             .size
                                                        //             .width *
                                                        //         0.005)
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "TOTAL SPENT",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.042,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Colors.grey[800]),
                                                  ),
                                                  Material(
                                                    color: Colors.white
                                                        .withOpacity(0),
                                                    child: InkWell(
                                                      splashColor: Colors.white
                                                          .withAlpha(0),
                                                      highlightColor: Colors
                                                          .black
                                                          .withOpacity(0.1),
                                                      onTap: () {
                                                        // chartsModel.readFile();
                                                        // Navigator.push(
                                                        //     context,
                                                        //     CupertinoPageRoute(
                                                        //         builder: (context) =>
                                                        //             ShowQRScreen()));
                                                      },
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  3000)),
                                                      child: Icon(
                                                        chevronTicker(appModel),
                                                        // FontAwesomeIcons.dollarSign,
                                                        color: Colors.grey[800],
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: sizeMulW * 24,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Tooltip(
                                              message: "Food",
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.utensils,
                                                    size: sizeMulW * 34,
                                                    color: Color(0xfff4a735),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 3,
                                                  ),
                                                  Text(
                                                    ((appModel.viewing_period ==
                                                                Period.DAILY)
                                                            ? addCommas(appModel
                                                                    .dayExpense
                                                                    .totalSpentOnFood
                                                                    .toInt()) +
                                                                "${(appModel.dayExpense.totalSpentOnUtilities % 1).toStringAsFixed(2)}"
                                                            : (appModel.viewing_period ==
                                                                    Period
                                                                        .MONTHLY)
                                                                ? addCommas(appModel
                                                                        .monthExpense
                                                                        .totalSpentOnFood
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnUtilities % 1).toStringAsFixed(2)}"
                                                                : addCommas(appModel
                                                                        .weekExpense
                                                                        .totalSpentOnFood
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnUtilities % 1).toStringAsFixed(2)}")
                                                        .toString(),
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 1,
                                                  ),
                                                  Text(
                                                    (100 *
                                                                ((appModel.viewing_period ==
                                                                        Period
                                                                            .DAILY)
                                                                    ? appModel
                                                                            .dayExpense
                                                                            .totalSpentOnFood /
                                                                        appModel
                                                                            .dayExpense
                                                                            .totalSpent
                                                                    : (appModel
                                                                                .viewing_period ==
                                                                            Period
                                                                                .MONTHLY)
                                                                        ? appModel.monthExpense.totalSpentOnFood /
                                                                            appModel
                                                                                .monthExpense.totalSpent
                                                                        : appModel.weekExpense.totalSpentOnFood /
                                                                            appModel
                                                                                .weekExpense.totalSpent))
                                                            .toStringAsFixed(
                                                                0) +
                                                        "%",
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[500]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Tooltip(
                                              message: "Leisure",
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .wineGlassAlt,
                                                    size: sizeMulW * 34,
                                                    color: Color(0xfffef09c),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 3,
                                                  ),
                                                  Text(
                                                    ((appModel.viewing_period ==
                                                                Period.DAILY)
                                                            ? addCommas(appModel
                                                                    .dayExpense
                                                                    .totalSpentOnLeisure
                                                                    .toInt()) +
                                                                "${(appModel.dayExpense.totalSpentOnUtilities % 1).toStringAsFixed(2)}"
                                                            : (appModel.viewing_period ==
                                                                    Period
                                                                        .MONTHLY)
                                                                ? addCommas(appModel
                                                                        .monthExpense
                                                                        .totalSpentOnLeisure
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnUtilities % 1).toStringAsFixed(2)}"
                                                                : addCommas(appModel
                                                                        .weekExpense
                                                                        .totalSpentOnLeisure
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnUtilities % 1).toStringAsFixed(2)}")
                                                        .toString(),
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 1,
                                                  ),
                                                  Text(
                                                    (100 *
                                                                ((appModel.viewing_period ==
                                                                        Period
                                                                            .DAILY)
                                                                    ? appModel
                                                                            .dayExpense
                                                                            .totalSpentOnLeisure /
                                                                        appModel
                                                                            .dayExpense
                                                                            .totalSpent
                                                                    : (appModel
                                                                                .viewing_period ==
                                                                            Period
                                                                                .MONTHLY)
                                                                        ? appModel.monthExpense.totalSpentOnLeisure /
                                                                            appModel
                                                                                .monthExpense.totalSpent
                                                                        : appModel.weekExpense.totalSpentOnLeisure /
                                                                            appModel
                                                                                .weekExpense.totalSpent))
                                                            .toStringAsFixed(
                                                                0) +
                                                        "%",
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[500]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20 * sizeMulW,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Tooltip(
                                              message: "Miscellaneous",
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.campground,
                                                    size: sizeMulW * 34,
                                                    color: Color(0xffee9698),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 3,
                                                  ),
                                                  Text(
                                                    ((appModel.viewing_period ==
                                                                Period.DAILY)
                                                            ? addCommas(appModel
                                                                    .dayExpense
                                                                    .totalSpentOnMiscellaneous
                                                                    .toInt()) +
                                                                "${(appModel.dayExpense.totalSpentOnMiscellaneous % 1).toStringAsFixed(2)}"
                                                            : (appModel.viewing_period ==
                                                                    Period
                                                                        .MONTHLY)
                                                                ? addCommas(appModel
                                                                        .monthExpense
                                                                        .totalSpentOnMiscellaneous
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnMiscellaneous % 1).toStringAsFixed(2)}"
                                                                : addCommas(appModel
                                                                        .weekExpense
                                                                        .totalSpentOnMiscellaneous
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnMiscellaneous % 1).toStringAsFixed(2)}")
                                                        .toString(),
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 1,
                                                  ),
                                                  Text(
                                                    (100 *
                                                                ((appModel.viewing_period ==
                                                                        Period
                                                                            .DAILY)
                                                                    ? appModel
                                                                            .dayExpense
                                                                            .totalSpentOnMiscellaneous /
                                                                        appModel
                                                                            .dayExpense
                                                                            .totalSpent
                                                                    : (appModel
                                                                                .viewing_period ==
                                                                            Period
                                                                                .MONTHLY)
                                                                        ? appModel.monthExpense.totalSpentOnMiscellaneous /
                                                                            appModel
                                                                                .monthExpense.totalSpent
                                                                        : appModel.weekExpense.totalSpentOnMiscellaneous /
                                                                            appModel
                                                                                .weekExpense.totalSpent))
                                                            .toStringAsFixed(
                                                                0) +
                                                        "%",
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[500]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Tooltip(
                                              message: "Transportation",
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.bus,
                                                    size: sizeMulW * 34,
                                                    color: Color(0xff8ec8f8),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 3,
                                                  ),
                                                  Text(
                                                    ((appModel.viewing_period ==
                                                                Period.DAILY)
                                                            ? addCommas(appModel
                                                                    .dayExpense
                                                                    .totalSpentOnTransportation
                                                                    .toInt()) +
                                                                "${(appModel.dayExpense.totalSpentOnTransportation % 1).toStringAsFixed(2)}"
                                                            : (appModel.viewing_period ==
                                                                    Period
                                                                        .MONTHLY)
                                                                ? addCommas(appModel
                                                                        .monthExpense
                                                                        .totalSpentOnTransportation
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnTransportation % 1).toStringAsFixed(2)}"
                                                                : addCommas(appModel
                                                                        .weekExpense
                                                                        .totalSpentOnTransportation
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnTransportation % 1).toStringAsFixed(2)}")
                                                        .toString(),
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 1,
                                                  ),
                                                  Text(
                                                    (100 *
                                                                ((appModel.viewing_period ==
                                                                        Period
                                                                            .DAILY)
                                                                    ? appModel
                                                                            .dayExpense
                                                                            .totalSpentOnTransportation /
                                                                        appModel
                                                                            .dayExpense
                                                                            .totalSpent
                                                                    : (appModel
                                                                                .viewing_period ==
                                                                            Period
                                                                                .MONTHLY)
                                                                        ? appModel.monthExpense.totalSpentOnTransportation /
                                                                            appModel
                                                                                .monthExpense.totalSpent
                                                                        : appModel.weekExpense.totalSpentOnTransportation /
                                                                            appModel
                                                                                .weekExpense.totalSpent))
                                                            .toStringAsFixed(
                                                                0) +
                                                        "%",
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[500]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Tooltip(
                                              message: "Utilities",
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .toiletPaper,
                                                    size: sizeMulW * 34,
                                                    color: Color(0xffa1d2a6),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 3,
                                                  ),
                                                  Text(
                                                    ((appModel.viewing_period ==
                                                                Period.DAILY)
                                                            ? addCommas(appModel
                                                                    .dayExpense
                                                                    .totalSpentOnUtilities
                                                                    .toInt()) +
                                                                "${(appModel.dayExpense.totalSpentOnUtilities % 1).toStringAsFixed(2)}"
                                                            : (appModel.viewing_period ==
                                                                    Period
                                                                        .MONTHLY)
                                                                ? addCommas(appModel
                                                                        .monthExpense
                                                                        .totalSpentOnUtilities
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnUtilities % 1).toStringAsFixed(2)}"
                                                                : addCommas(appModel
                                                                        .weekExpense
                                                                        .totalSpentOnUtilities
                                                                        .toInt()) +
                                                                    "${(appModel.dayExpense.totalSpentOnUtilities % 1).toStringAsFixed(2)}")
                                                        .toString(),
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  SizedBox(
                                                    height: sizeMulW * 1,
                                                  ),
                                                  Text(
                                                    (100 *
                                                                ((appModel.viewing_period ==
                                                                        Period
                                                                            .DAILY)
                                                                    ? appModel
                                                                            .dayExpense
                                                                            .totalSpentOnUtilities /
                                                                        appModel
                                                                            .dayExpense
                                                                            .totalSpent
                                                                    : (appModel
                                                                                .viewing_period ==
                                                                            Period
                                                                                .MONTHLY)
                                                                        ? appModel.monthExpense.totalSpentOnUtilities /
                                                                            appModel
                                                                                .monthExpense.totalSpent
                                                                        : appModel.weekExpense.totalSpentOnUtilities /
                                                                            appModel
                                                                                .weekExpense.totalSpent))
                                                            .toStringAsFixed(
                                                                0) +
                                                        "%",
                                                    textScaleFactor: 1.1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // fontSize: 16 * sizeMulW,
                                                        color:
                                                            Colors.grey[500]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: sizeMulW * 14),
                                    child: Text(
                                      (appModel.viewing_period == Period.DAILY)
                                          ? "Previous Days"
                                          : (appModel.viewing_period ==
                                                  Period.WEEKLY)
                                              ? "Previous Weeks"
                                              : "Previous Months",
                                      textScaleFactor: 1.6,
                                      style: TextStyle(
                                          // fontSize: sizeMulW * 23,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800]),
                                    ),
                                  ),

                                  Container(
                                      padding: EdgeInsets.all(sizeMulW * 20),
                                      width: MediaQuery.of(context).size.width,
                                      height: sizeMulW * 230,
                                      child:
                                          //  (chartsModel.barChartDataLoaded)?

                                          FutureBuilder(
                                              future: chartsModel
                                                  .generateGroupedBarChartData(
                                                      appModel.viewing_period),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  // print(snapshot.data[0].toString()_)
                                                  if (chartsModel.dayExpenses
                                                                  .length ==
                                                              0 &&
                                                          appModel.viewing_period ==
                                                              Period.DAILY ||
                                                      chartsModel.weekExpenses
                                                                  .length ==
                                                              0 &&
                                                          appModel.viewing_period ==
                                                              Period.WEEKLY ||
                                                      chartsModel.monthExpenses
                                                                  .length ==
                                                              0 &&
                                                          appModel.viewing_period ==
                                                              Period.MONTHLY)
                                                    return Stack(
                                                      children: <Widget>[
                                                        GroupedBarChart
                                                            .withSampleData(),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .sadCry,
                                                              size:
                                                                  sizeMulW * 33,
                                                              color: Colors
                                                                  .grey[700],
                                                            ),
                                                            Text(
                                                              "NO DATA",
                                                              textScaleFactor:
                                                                  1.3,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  return GroupedBarChart(
                                                      snapshot.data);
                                                } else
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                              })

                                      //         :SizedBox(width: MediaQuery.of(context).size.width,
                                      // height: sizeMulW * 230,)

                                      ),

                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: sizeMulW * 14),
                                    child: Text(
                                      (appModel.viewing_period == Period.DAILY)
                                          ? "Lifetime Daily Totals"
                                          : (appModel.viewing_period ==
                                                  Period.WEEKLY)
                                              ? "Lifetime Weekly Totals"
                                              : "Lifetime Monthly Totals",
                                      textScaleFactor: 1.6,
                                      style: TextStyle(
                                          // fontSize: sizeMulW * 23,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800]),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(sizeMulW * 20),
                                      width: MediaQuery.of(context).size.width,
                                      height: sizeMulW * 230,
                                      child: FutureBuilder(
                                          future: chartsModel
                                              .generateTimeSeriesChartData(
                                                  appModel.viewing_period),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              print(snapshot.data.length
                                                      .toString() +
                                                  "ADFAFAFA");

                                              if (chartsModel.dayExpenses
                                                              .length ==
                                                          0 &&
                                                      appModel.viewing_period ==
                                                          Period.DAILY ||
                                                  chartsModel.weekExpenses
                                                              .length ==
                                                          0 &&
                                                      appModel.viewing_period ==
                                                          Period.WEEKLY ||
                                                  chartsModel.monthExpenses
                                                              .length ==
                                                          0 &&
                                                      appModel.viewing_period ==
                                                          Period.MONTHLY) {
                                                return Stack(
                                                  children: <Widget>[
                                                    SimpleTimeSeriesChart
                                                        .withSampleData(),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .sadCry,
                                                          size: sizeMulW * 33,
                                                          color:
                                                              Colors.grey[700],
                                                        ),
                                                        Text(
                                                          "NO DATA",
                                                          textScaleFactor: 1.3,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .grey[700]),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }
                                              return SimpleTimeSeriesChart(
                                                  snapshot.data);
                                            } else
                                              return SizedBox(
                                                width: 1,
                                              );
                                          })),
                                ],
                              ),
                            ),
                            // The appbar
                            new Stack(
                              children: <Widget>[
                                ClipShadowPath(
                                    shadow: Shadow(
                                        blurRadius: 10 * sizeMulW,
                                        offset: Offset(0, sizeMulW),
                                        color: Colors.black38),
                                    clipper: CustomShapeClipper(
                                        sizeMulW: sizeMulW,
                                        maxWidth:
                                            MediaQuery.of(context).size.width,
                                        maxHeight:
                                            MediaQuery.of(context).size.width *
                                                0.4),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.434,
                                        decoration:
                                            BoxDecoration(gradient: greeny),
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                              left: 0,
                                              top: 24,
                                              child: Container(
                                                width: sizeMulW * 60,
                                                child: RaisedButton(
                                                  highlightElevation: 0,
                                                  color: Colors.white
                                                      .withOpacity(0),
                                                  elevation: 0,
                                                  splashColor:
                                                      Colors.white.withAlpha(0),
                                                  highlightColor: Colors.black
                                                      .withOpacity(0),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    // width: sizeMulW * 50,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                10 * sizeMulW),
                                                    // height: sizeMulW*40,
                                                    // color: Colors.red,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Image.asset(
                                                          'assets/icons/3x/back.png',
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.075,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 34,
                                              right: 0,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.91 *
                                                  0.09,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context).size.width * 0.05,
                                                  // ),
                                                  // SizedBox(
                                                  //   width: 20.57 * sizeMulW,
                                                  // ),
                                                  Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        // width: sizeMulW * 130,
                                                        // height: sizeMulH * 30,
                                                        child: Center(
                                                          child: InkWell(
                                                            // highlightElevation: 0,
                                                            // color: Colors.white.withOpacity(0),
                                                            // elevation: 0,
                                                            splashColor: Colors
                                                                .white
                                                                .withAlpha(0),
                                                            highlightColor:
                                                                Colors.black
                                                                    .withOpacity(
                                                                        0),

                                                            onTap: () {
                                                              // appModel.viewing_period = Period.MONTHLY;
                                                            },
                                                            child: Container(
                                                              // margin: EdgeInsets.all((sizeMulH*15)),
                                                              // color: Colors.white,
                                                              // width: sizeMulW*20,
                                                              // height: sizeMulH*0.2,
                                                              padding: (appModel
                                                                          .viewing_period ==
                                                                      Period
                                                                          .MONTHLY)
                                                                  ? EdgeInsets.symmetric(
                                                                      vertical:
                                                                          sizeMulW *
                                                                              2,
                                                                      horizontal:
                                                                          sizeMulW *
                                                                              8)
                                                                  : null,
                                                              decoration: (appModel
                                                                          .viewing_period ==
                                                                      Period
                                                                          .MONTHLY)
                                                                  ? BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(sizeMulW *
                                                                              300))
                                                                  : null,

                                                              child: Text(
                                                                  "MONTHLY",
                                                                  style: (appModel
                                                                              .viewing_period ==
                                                                          Period
                                                                              .MONTHLY)
                                                                      ? headerStyleSelected
                                                                      : headerStyle),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      RaisedButton(
                                                        child: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontSize: 40),
                                                        ),
                                                        color: Colors.white
                                                            .withAlpha(0),
                                                        elevation: 0,
                                                        disabledColor: Colors
                                                            .white
                                                            .withAlpha(0),
                                                        highlightColor: Colors
                                                            .white
                                                            .withAlpha(0),
                                                        disabledElevation: 0,
                                                        highlightElevation: 0,
                                                        splashColor: Colors
                                                            .white
                                                            .withAlpha(0),
                                                        onPressed: () {
                                                          appModel.viewing_period =
                                                              Period.MONTHLY;
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        // width: sizeMulW * 130,
                                                        // height: sizeMulH * 30,
                                                        child: Center(
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .white
                                                                .withAlpha(0),
                                                            // elevation: 0,
                                                            // color: Colors.white.withAlpha(0),
                                                            // highlightElevation: 0,
                                                            highlightColor:
                                                                Colors.black
                                                                    .withOpacity(
                                                                        0),
                                                            onTap: () {
                                                              appModel.viewing_period =
                                                                  Period.WEEKLY;

                                                              // Navigator.push(
                                                              //     context,
                                                              //     CupertinoPageRoute(
                                                              //         builder: (context) =>
                                                              //             ReceiveReceiptScreen(
                                                              //                 appModel.receiveReceiptModel)));
                                                            },
                                                            child: Container(
                                                              padding: (appModel
                                                                          .viewing_period ==
                                                                      Period
                                                                          .WEEKLY)
                                                                  ? EdgeInsets.symmetric(
                                                                      vertical:
                                                                          sizeMulW *
                                                                              2,
                                                                      horizontal:
                                                                          sizeMulW *
                                                                              8)
                                                                  : null,
                                                              decoration: (appModel
                                                                          .viewing_period ==
                                                                      Period
                                                                          .WEEKLY)
                                                                  ? BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(sizeMulW *
                                                                              300))
                                                                  : null,
                                                              child: Text(
                                                                "WEEKLY",
                                                                style: (appModel
                                                                            .viewing_period ==
                                                                        Period
                                                                            .WEEKLY)
                                                                    ? headerStyleSelected
                                                                    : headerStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      RaisedButton(
                                                        child: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontSize: 40),
                                                        ),
                                                        color: Colors.white
                                                            .withAlpha(0),
                                                        elevation: 0,
                                                        disabledColor: Colors
                                                            .white
                                                            .withAlpha(0),
                                                        highlightColor: Colors
                                                            .white
                                                            .withAlpha(0),
                                                        disabledElevation: 0,
                                                        highlightElevation: 0,
                                                        splashColor: Colors
                                                            .white
                                                            .withAlpha(0),
                                                        onPressed: () {
                                                          appModel.viewing_period =
                                                              Period.WEEKLY;
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        // width: sizeMulW * 110,
                                                        // height: sizeMulH * 30,
                                                        child: Center(
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .white
                                                                .withAlpha(0),
                                                            // elevation: 0,
                                                            // highlightElevation: 0,
                                                            // color: Colors.white.withAlpha(0),
                                                            highlightColor:
                                                                Colors.black
                                                                    .withOpacity(
                                                                        0),
                                                            onTap: () {
                                                              appModel.viewing_period =
                                                                  Period.DAILY;
                                                            },
                                                            child: Container(
                                                              padding: (appModel
                                                                          .viewing_period ==
                                                                      Period
                                                                          .DAILY)
                                                                  ? EdgeInsets.symmetric(
                                                                      vertical:
                                                                          sizeMulW *
                                                                              2,
                                                                      horizontal:
                                                                          sizeMulW *
                                                                              8)
                                                                  : null,
                                                              decoration: (appModel
                                                                          .viewing_period ==
                                                                      Period
                                                                          .DAILY)
                                                                  ? BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(sizeMulW *
                                                                              300))
                                                                  : null,
                                                              child: Text(
                                                                "DAILY",
                                                                style: (appModel
                                                                            .viewing_period ==
                                                                        Period
                                                                            .DAILY)
                                                                    ? headerStyleSelected
                                                                    : headerStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      RaisedButton(
                                                        child: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontSize: 40),
                                                        ),
                                                        color: Colors.white
                                                            .withAlpha(0),
                                                        elevation: 0,
                                                        disabledColor: Colors
                                                            .white
                                                            .withAlpha(0),
                                                        highlightColor: Colors
                                                            .white
                                                            .withAlpha(0),
                                                        disabledElevation: 0,
                                                        highlightElevation: 0,
                                                        splashColor: Colors
                                                            .white
                                                            .withAlpha(0),
                                                        onPressed: () {
                                                          appModel.viewing_period =
                                                              Period.DAILY;
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context).size.width * 0.05,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              left: sizeMulW * 30,
                                              top: sizeMulW * 79,
                                              child: Text("Charts",
                                                  style: TextStyle(
                                                    fontSize: sizeMulW * 35,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            )
                                          ],
                                        ))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }));
    });
  }
}
// class ChartScreenTopPart extends StatefulWidget {
//   @override
//   _ChartScreenTopPartState createState() => new _ChartScreenTopPartState();
// }

// class _ChartScreenTopPartState extends State<ChartScreenTopPart> {
//   @override
//   Widget build(BuildContext context) {
//     return new Container();
//   }
// }

// class ChartScreenBottomPart extends StatefulWidget {
//   @override
//   _ChartScreenBottomPartState createState() => new _ChartScreenBottomPartState();
// }

// class _ChartScreenBottomPartState extends State<ChartScreenBottomPart> {
//   @override
//   Widget build(BuildContext context) {
//     return new Container();
//   }
// }
