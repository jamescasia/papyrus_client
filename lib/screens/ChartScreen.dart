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
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/cupertino.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => new _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
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
  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white);

    TextStyle headerStyleSelected = TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700]);
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return ScopedModel<ChartsScreenModel>(
          model: appModel.chartsScreenModel,
          child: ScopedModelDescendant<ChartsScreenModel>(
              builder: (context, child, chartsModel) {
            return Container(
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
                                                child: GaugeChart(
                                                  chartsModel.generateChartData(
                                                      appModel.viewing_period),
                                                  animate: true,
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
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "TOTAL SPENT",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.042,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[800]),
                                      ),
                                      Material(
                                        color: Colors.white.withOpacity(0),
                                        child: InkWell(
                                          splashColor:
                                              Colors.white.withAlpha(0),
                                          highlightColor:
                                              Colors.black.withOpacity(0.1),
                                          onTap: () {
                                            // Navigator.push(
                                            //     context,
                                            //     CupertinoPageRoute(
                                            //         builder: (context) =>
                                            //             ShowQRScreen()));
                                          },
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3000)),
                                          child: Icon(
                                            chevronTicker(appModel),
                                            // FontAwesomeIcons.dollarSign,
                                            color:  Colors.grey[800],
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ConstrainedBox(
                                    constraints: new BoxConstraints(
                                      // minHeight: 100*sizeMulW,
                                      minWidth: 160 * sizeMulW,

                                      // maxHeight: 30.0,
                                      // maxWidth: 30.0,
                                    ),
                                    child: Material(
                                      // shape: CircleBorder(),
                                      color: Colors.white.withAlpha(0),
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15 * sizeMulW)),
                                        onTap: () {
                                          // print(result);
                                        },
                                        splashColor: Colors.greenAccent,
                                        highlightColor: Colors.green,
                                        child: Container(
                                          // height: sizeMulW * 80,
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.042),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              (appModel.loadedUserExpense)
                                                  ? Text(
                                                      ((appModel.viewing_period == Period.DAILY && appModel.loadedUserExpense) ? addCommas(int.parse(appModel.userExpense.lastDateTotalExpenseAmount.toStringAsFixed(2).split('.')[0])) : (appModel.viewing_period == Period.MONTHLY && appModel.loadedUserExpense) ? addCommas(int.parse(appModel.userExpense.lastMonthTotalExpenseAmount.toStringAsFixed(2).split('.')[0])) : (appModel.viewing_period == Period.WEEKLY && appModel.loadedUserExpense) ? addCommas(int.parse(appModel.userExpense.lastWeekTotalExpenseAmount.toStringAsFixed(2).split('.')[0])) : "0") +
                                                          ".",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.09,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey[700]))
                                                  : Text("0 ",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.09,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:Colors.grey[700])),

                                              (appModel.loadedUserExpense)
                                                  ? Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 4 * sizeMulW),
                                                      child: Text(
                                                          decimalDigits(
                                                              appModel),
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors.grey[700])),
                                                    )
                                                  : Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 4 * sizeMulW),
                                                      child: Text("00",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors.grey[700]
                                                                  )),
                                                    ),
                                              // ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      15 * sizeMulW)),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                                     

                                      
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.utensils,
                                            size: sizeMulW * 24,
                                            color: Color(0xfff4a735),
                                          ),

                                          Icon(FontAwesomeIcons.wineGlassAlt,
                                          size: sizeMulW*24,
                                          color:  Color(0xfffef09c), ),

                                          Icon(
                                            FontAwesomeIcons.campground,
                                            size: sizeMulW * 24,
                                            color:  Color(0xffee9698),
                                          ),

                                          Icon(FontAwesomeIcons.bus,
                                          size: sizeMulW*24,
                                          color: Color(0xff8ec8f8),  ),

                                          Icon(FontAwesomeIcons.toiletPaper,
                                          size: sizeMulW*24,
                                          color:  Color(0xffa1d2a6), 
                                          ), 
                                          // Icon(
                                          // if (receipt.category == "Transportation") iconColor = Color(0xff8ec8f8);
                                          // if (receipt.category == "Miscellaneous") iconColor = Color(0xffee9698);
                                          // if (receipt.category == "Utilities") iconColor = Color(0xffa1d2a6);
                                          // if (receipt.category == "Leisure") iconColor = Color(0xfffef09c);
                                          // if (receipt.category == "Food") iconColor = Color(0xfff4a735);
                                          //                       (receipt.category == "Leisure")
                                          //                           ? FontAwesomeIcons.wineGlassAlt
                                          //                           : (receipt.category == "Transportation")
                                          //                               ? FontAwesomeIcons.campground
                                          //                               : (receipt.category == "Food")
                                          //                                   ? FontAwesomeIcons.utensils
                                          //                                   : (receipt.category == "Utilities")
                                          //                                       ? FontAwesomeIcons.toiletPaper
                                          //                                       : (receipt.category == "Miscellaneous")
                                          //                                           ? FontAwesomeIcons.campground
                                          //                                           : FontAwesomeIcons.file,
                                          // size: sizeMulW * 26,
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                    padding: EdgeInsets.all(sizeMulW * 20),
                                    width: MediaQuery.of(context).size.width,
                                    height: sizeMulW * 230,
                                    child: GroupedBarChart.withSampleData()),
                                Container(
                                    padding: EdgeInsets.all(sizeMulW * 20),
                                    width: MediaQuery.of(context).size.width,
                                    height: sizeMulW * 230,
                                    child:
                                        SimpleTimeSeriesChart.withSampleData()),
                                Container(
                                    padding: EdgeInsets.all(sizeMulW * 20),
                                    width: MediaQuery.of(context).size.width,
                                    height: sizeMulW * 230,
                                    child: GroupedBarChart.withSampleData()),
                                Container(
                                    padding: EdgeInsets.all(sizeMulW * 20),
                                    width: MediaQuery.of(context).size.width,
                                    height: sizeMulW * 230,
                                    child: GroupedBarChart.withSampleData()),
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
                                      width: MediaQuery.of(context).size.width,
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
                                                color:
                                                    Colors.white.withOpacity(0),
                                                elevation: 0,
                                                splashColor:
                                                    Colors.white.withAlpha(0),
                                                highlightColor:
                                                    Colors.black.withOpacity(0),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  // width: sizeMulW * 50,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10 * sizeMulW),
                                                  // height: sizeMulW*40,
                                                  // color: Colors.red,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                  MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                // SizedBox(
                                                //   width: MediaQuery.of(context).size.width * 0.05,
                                                // ),
                                                // SizedBox(
                                                //   width: 20.57 * sizeMulW,
                                                // ),
                                                Container(
                                                  // width: sizeMulW * 130,
                                                  // height: sizeMulH * 30,
                                                  child: Center(
                                                    child: InkWell(
                                                      // highlightElevation: 0,
                                                      // color: Colors.white.withOpacity(0),
                                                      // elevation: 0,
                                                      splashColor: Colors.white
                                                          .withAlpha(0),
                                                      highlightColor: Colors
                                                          .black
                                                          .withOpacity(0),

                                                      onTap: () {
                                                        appModel.viewing_period =
                                                            Period.MONTHLY;
                                                      },
                                                      child: Container(
                                                        // margin: EdgeInsets.all((sizeMulH*15)),
                                                        // color: Colors.white,
                                                        // width: sizeMulW*20,
                                                        // height: sizeMulH*0.2,
                                                        padding: (appModel
                                                                    .viewing_period ==
                                                                Period.MONTHLY)
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
                                                                Period.MONTHLY)
                                                            ? BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        sizeMulW *
                                                                            300))
                                                            : null,

                                                        child: Text("MONTHLY",
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
                                                Container(
                                                  // width: sizeMulW * 130,
                                                  // height: sizeMulH * 30,
                                                  child: Center(
                                                    child: InkWell(
                                                      splashColor: Colors.white
                                                          .withAlpha(0),
                                                      // elevation: 0,
                                                      // color: Colors.white.withAlpha(0),
                                                      // highlightElevation: 0,
                                                      highlightColor: Colors
                                                          .black
                                                          .withOpacity(0),
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
                                                                Period.WEEKLY)
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
                                                                Period.WEEKLY)
                                                            ? BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        sizeMulW *
                                                                            300))
                                                            : null,
                                                        child: Text(
                                                          "WEEKLY",
                                                          style: (appModel
                                                                      .viewing_period ==
                                                                  Period.WEEKLY)
                                                              ? headerStyleSelected
                                                              : headerStyle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // width: sizeMulW * 110,
                                                  // height: sizeMulH * 30,
                                                  child: Center(
                                                    child: InkWell(
                                                      splashColor: Colors.white
                                                          .withAlpha(0),
                                                      // elevation: 0,
                                                      // highlightElevation: 0,
                                                      // color: Colors.white.withAlpha(0),
                                                      highlightColor: Colors
                                                          .black
                                                          .withOpacity(0),
                                                      onTap: () {
                                                        appModel.viewing_period =
                                                            Period.DAILY;
                                                      },
                                                      child: Container(
                                                        padding: (appModel
                                                                    .viewing_period ==
                                                                Period.DAILY)
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
                                                                Period.DAILY)
                                                            ? BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        sizeMulW *
                                                                            300))
                                                            : null,
                                                        child: Text(
                                                          "DAILY",
                                                          style: (appModel
                                                                      .viewing_period ==
                                                                  Period.DAILY)
                                                              ? headerStyleSelected
                                                              : headerStyle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
