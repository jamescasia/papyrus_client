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

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => new _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(body: ChartScreenStack() );
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
        fontSize: MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.normal,
        color: Colors.white);

    TextStyle headerStyleSelected = TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.05,
        fontWeight: FontWeight.bold,
        color: Colors.green[700]);
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
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
                                  left:
                                      MediaQuery.of(context).size.width * 0.61,
                                  top: sizeMulW * 30,
                                  // top:
                                  // bottom: sizeMulW * -15,
                                  child: RotatedBox(
                                    quarterTurns: -1,
                                    child: SizedBox(
                                        // color: Colors.black,
                                        width: sizeMulW * 185,
                                        height: sizeMulW * 185,
                                        child: GaugeChart.withSampleData()),
                                  ),
                                ),
                                Positioned(
                                  left: sizeMulW * 20,
                                  top: sizeMulW * 114,
                                  child: GaugeChartLegendItem(
                                      "Food", Colors.green[600]),
                                ),
                                Positioned(
                                  left: sizeMulW * 108,
                                  top: sizeMulW * 118,
                                  child: GaugeChartLegendItem(
                                      "Leisure", Colors.green[500]),
                                ),
                                Positioned(
                                  left: sizeMulW * 197,
                                  top: sizeMulW * 108,
                                  child: GaugeChartLegendItem(
                                      "Misc.", Colors.green[400]),
                                ),
                                Positioned(
                                  left: sizeMulW * 13,
                                  top: sizeMulW * 154,
                                  child: GaugeChartLegendItem(
                                      "Transportation", Colors.green[300]),
                                ),
                                // Positioned(
                                //   left: sizeMulW * 103,
                                //   top: sizeMulW * 156,
                                //   child: GaugeChartLegendItem(
                                //       "School", Colors.green[200]),
                                // ),
                                Positioned(
                                  left: sizeMulW * 180,
                                  top: sizeMulW * 150,
                                  child: GaugeChartLegendItem(
                                      "Necessities", Colors.green[100]),
                                ),
                              ],
                            ),
                          ),
                          // Text(),

                          Container(
                              padding: EdgeInsets.all(sizeMulW * 20),
                              width: MediaQuery.of(context).size.width,
                              height: sizeMulW * 230,
                              child: GroupedBarChart.withSampleData()),
                          Container(
                              padding: EdgeInsets.all(sizeMulW * 20),
                              width: MediaQuery.of(context).size.width,
                              height: sizeMulW * 230,
                              child: SimpleTimeSeriesChart.withSampleData()),
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
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight:
                                    MediaQuery.of(context).size.width * 0.4),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.434,
                                decoration: BoxDecoration(gradient: greeny),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: 0,
                                      top: 24,
                                      child: Container(
                                        width: sizeMulW * 60,
                                        child: RaisedButton(
                                          highlightElevation: 0,
                                          color: Colors.white.withOpacity(0),
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
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/icons/3x/back.png',
                                                  height: MediaQuery.of(context)
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
                        left: 20*sizeMulW,
                        right: 0,
                        top: MediaQuery.of(context).size.width * 0.91 * 0.09,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.05,
                            // ),
                            // SizedBox(
                            //   width: 20.57 * sizeMulW,
                            // ),
                            Container(
                              width: sizeMulW * 130,
                              height: sizeMulH * 30,
                              child: Center(
                                child: InkWell(
                                  // highlightElevation: 0,
                                  // color: Colors.white.withOpacity(0),
                                  // elevation: 0,
                                  splashColor: Colors.white.withAlpha(0),
                                  highlightColor: Colors.black.withOpacity(0),

                                  onTap: () {
                                    appModel.viewing_period = Period.MONTHLY;
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.all((sizeMulH*15)),
                                    // color: Colors.white,
                                    // width: sizeMulW*20,
                                    // height: sizeMulH*0.2,
                                    padding: (appModel.viewing_period ==
                                            Period.MONTHLY)
                                        ? EdgeInsets.symmetric(
                                            vertical: sizeMulW * 2,
                                            horizontal: sizeMulW * 8)
                                        : null,
                                    decoration: (appModel.viewing_period ==
                                            Period.MONTHLY)
                                        ? BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                sizeMulW * 300))
                                        : null,

                                    child: Text("MONTHLY",
                                        style: (appModel.viewing_period ==
                                                Period.MONTHLY)
                                            ? headerStyleSelected
                                            : headerStyle),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: sizeMulW * 130,
                              height: sizeMulH * 30,
                              child: Center(
                                child: InkWell(
                                  splashColor: Colors.white.withAlpha(0),
                                  // elevation: 0,
                                  // color: Colors.white.withAlpha(0),
                                  // highlightElevation: 0,
                                  highlightColor: Colors.black.withOpacity(0),
                                  onTap: () {
                                    appModel.viewing_period = Period.WEEKLY;

                                    // Navigator.push(
                                    //     context,
                                    //     CupertinoPageRoute(
                                    //         builder: (context) =>
                                    //             ReceiveReceiptScreen(
                                    //                 appModel.receiveReceiptModel)));
                                  },
                                  child: Container(
                                    padding: (appModel.viewing_period ==
                                            Period.WEEKLY)
                                        ? EdgeInsets.symmetric(
                                            vertical: sizeMulW * 2,
                                            horizontal: sizeMulW * 8)
                                        : null,
                                    decoration: (appModel.viewing_period ==
                                            Period.WEEKLY)
                                        ? BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                sizeMulW * 300))
                                        : null,
                                    child: Text(
                                      "WEEKLY",
                                      style: (appModel.viewing_period ==
                                              Period.WEEKLY)
                                          ? headerStyleSelected
                                          : headerStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: sizeMulW * 110,
                              height: sizeMulH * 30,
                              child: Center(
                                child: InkWell(
                                  splashColor: Colors.white.withAlpha(0),
                                  // elevation: 0,
                                  // highlightElevation: 0,
                                  // color: Colors.white.withAlpha(0),
                                  highlightColor: Colors.black.withOpacity(0),
                                  onTap: () {
                                    appModel.viewing_period = Period.DAILY;
                                  },
                                  child: Container(
                                    padding: (appModel.viewing_period ==
                                            Period.DAILY)
                                        ? EdgeInsets.symmetric(
                                            vertical: sizeMulW * 2,
                                            horizontal: sizeMulW * 8)
                                        : null,
                                    decoration: (appModel.viewing_period ==
                                            Period.DAILY)
                                        ? BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                sizeMulW * 300))
                                        : null,
                                    child: Text(
                                      "DAILY",
                                      style: (appModel.viewing_period ==
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
                                    // Positioned(
                                    //   left: sizeMulW * 10,
                                    //   top: sizeMulW * 33.5,
                                    //   child: Container(
                                    //     width:
                                    //         MediaQuery.of(context).size.width,
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //       // mainAxisSize: MainAxisSize.max,
                                    //       children: <Widget>[
                                    //         SizedBox(
                                    //           width: MediaQuery.of(context)
                                    //                   .size
                                    //                   .width *
                                    //               0.05,
                                    //         ),
                                    //         InkWell(
                                    //           splashColor:
                                    //               Colors.white.withAlpha(0),
                                    //           highlightColor:
                                    //               Colors.black.withOpacity(0.1),
                                    //           onTap: () {
                                    //             model.viewing_period =
                                    //                 Period.MONTHLY;
                                    //           },
                                    //           child: Container(
                                    //             // color: Colors.white,
                                    //             padding: (model
                                    //                         .viewing_period ==
                                    //                     Period.MONTHLY)
                                    //                 ? EdgeInsets.symmetric(
                                    //                     vertical: sizeMulW * 2,
                                    //                     horizontal:
                                    //                         sizeMulW * 8)
                                    //                 : null,
                                    //             decoration: (model
                                    //                         .viewing_period ==
                                    //                     Period.MONTHLY)
                                    //                 ? BoxDecoration(
                                    //                     color: Colors.white,
                                    //                     borderRadius:
                                    //                         BorderRadius
                                    //                             .circular(
                                    //                                 sizeMulW *
                                    //                                     300))
                                    //                 : null,

                                    //             child: Text("MONTHLY",
                                    //                 style:
                                    //                     (model.viewing_period ==
                                    //                             Period.MONTHLY)
                                    //                         ? headerStyleSelected
                                    //                         : headerStyle),
                                    //           ),
                                    //         ),
                                    //         InkWell(
                                    //           onTap: () {
                                    //             model.viewing_period =
                                    //                 Period.MONTHLY;
                                    //           },
                                    //           splashColor:
                                    //               Colors.white.withAlpha(0),
                                    //           highlightColor:
                                    //               Colors.black.withOpacity(0.1),
                                    //           child: Container(
                                    //             padding: (model
                                    //                         .viewing_period ==
                                    //                     Period.WEEKLY)
                                    //                 ? EdgeInsets.symmetric(
                                    //                     vertical: sizeMulW * 2,
                                    //                     horizontal:
                                    //                         sizeMulW * 8)
                                    //                 : null,
                                    //             decoration: (model
                                    //                         .viewing_period ==
                                    //                     Period.WEEKLY)
                                    //                 ? BoxDecoration(
                                    //                     color: Colors.white,
                                    //                     borderRadius:
                                    //                         BorderRadius
                                    //                             .circular(
                                    //                                 sizeMulW *
                                    //                                     300))
                                    //                 : null,
                                    //             child: InkWell(
                                    //               onTap: () {
                                    //                 model.viewing_period =
                                    //                     Period.WEEKLY;
                                    //               },
                                    //               splashColor:
                                    //                   Colors.white.withAlpha(0),
                                    //               highlightColor: Colors.black
                                    //                   .withOpacity(0.1),
                                    //               child: Text(
                                    //                 "WEEKLY",
                                    //                 style:
                                    //                     (model.viewing_period ==
                                    //                             Period.WEEKLY)
                                    //                         ? headerStyleSelected
                                    //                         : headerStyle,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         InkWell(
                                    //           onTap: () {
                                    //             model.viewing_period =
                                    //                 Period.DAILY;
                                    //           },
                                    //           child: Container(
                                    //             padding: (model
                                    //                         .viewing_period ==
                                    //                     Period.DAILY)
                                    //                 ? EdgeInsets.symmetric(
                                    //                     vertical: sizeMulW * 2,
                                    //                     horizontal:
                                    //                         sizeMulW * 8)
                                    //                 : null,
                                    //             decoration: (model
                                    //                         .viewing_period ==
                                    //                     Period.DAILY)
                                    //                 ? BoxDecoration(
                                    //                     color: Colors.white,
                                    //                     borderRadius:
                                    //                         BorderRadius
                                    //                             .circular(
                                    //                                 sizeMulW *
                                    //                                     300))
                                    //                 : null,
                                    //             child: Text(
                                    //               "DAILY",
                                    //               style:
                                    //                   (model.viewing_period ==
                                    //                           Period.DAILY)
                                    //                       ? headerStyleSelected
                                    //                       : headerStyle,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         SizedBox(
                                    //           width: MediaQuery.of(context)
                                    //                   .size
                                    //                   .width *
                                    //               0.05,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
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
