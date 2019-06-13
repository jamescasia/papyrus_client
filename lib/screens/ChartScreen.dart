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
        fontSize: MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.normal,
        color: Colors.white);

    TextStyle headerStyleSelected = TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.05,
        fontWeight: FontWeight.bold,
        color: Colors.green[700]);
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
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
                            height: 50 * sizeMul,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: sizeMul * 230,
                            // color: Colors.red,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  // right: sizeMul*-28*sizeMul,
                                  // left: sizeMul * 250,
                                  // right:
                                  left:
                                      MediaQuery.of(context).size.width * 0.61,
                                  top: sizeMul * 30,
                                  // top:
                                  // bottom: sizeMul * -15,
                                  child: RotatedBox(
                                    quarterTurns: -1,
                                    child: SizedBox(
                                        // color: Colors.black,
                                        width: sizeMul * 185,
                                        height: sizeMul * 185,
                                        child: GaugeChart.withSampleData()),
                                  ),
                                ),
                                Positioned(
                                  left: sizeMul * 20,
                                  top: sizeMul * 114,
                                  child: GaugeChartLegendItem(
                                      "Food", Colors.green[600]),
                                ),
                                Positioned(
                                  left: sizeMul * 108,
                                  top: sizeMul * 118,
                                  child: GaugeChartLegendItem(
                                      "Leisure", Colors.green[500]),
                                ),
                                Positioned(
                                  left: sizeMul * 197,
                                  top: sizeMul * 108,
                                  child: GaugeChartLegendItem(
                                      "Fuel", Colors.green[400]),
                                ),
                                Positioned(
                                  left: sizeMul * 13,
                                  top: sizeMul * 154,
                                  child: GaugeChartLegendItem(
                                      "Transpo", Colors.green[300]),
                                ),
                                Positioned(
                                  left: sizeMul * 103,
                                  top: sizeMul * 156,
                                  child: GaugeChartLegendItem(
                                      "School", Colors.green[200]),
                                ),
                                Positioned(
                                  left: sizeMul * 193,
                                  top: sizeMul * 150,
                                  child: GaugeChartLegendItem(
                                      "Misc.", Colors.green[100]),
                                ),
                              ],
                            ),
                          ),
                          // Text(),

                          Container(
                              padding: EdgeInsets.all(sizeMul * 20),
                              width: MediaQuery.of(context).size.width,
                              height: sizeMul * 230,
                              child: GroupedBarChart.withSampleData()),
                          Container(
                              padding: EdgeInsets.all(sizeMul * 20),
                              width: MediaQuery.of(context).size.width,
                              height: sizeMul * 230,
                              child: SimpleTimeSeriesChart.withSampleData()),
                          Container(
                              padding: EdgeInsets.all(sizeMul * 20),
                              width: MediaQuery.of(context).size.width,
                              height: sizeMul * 230,
                              child: GroupedBarChart.withSampleData()),
                          Container(
                              padding: EdgeInsets.all(sizeMul * 20),
                              width: MediaQuery.of(context).size.width,
                              height: sizeMul * 230,
                              child: GroupedBarChart.withSampleData()),
                        ],
                      ),
                    ),
                    // The appbar
                    new Stack(
                      children: <Widget>[
                        ClipShadowPath(
                            shadow: Shadow(
                                blurRadius: 10 * sizeMul,
                                offset: Offset(0, sizeMul),
                                color: Colors.black38),
                            clipper: CustomShapeClipper(
                                sizeMul: sizeMul,
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
                                      left: 2,
                                      top: 24,
                                      child: InkWell(
                                        splashColor: Colors.white.withAlpha(0),
                                        highlightColor:
                                            Colors.black.withOpacity(0.1),
                                        // ,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: sizeMul * 40,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10 * sizeMul),
                                          // height: sizeMul*40,
                                          // color: Colors.red,
                                          child: Image.asset(
                                            'assets/icons/3x/back.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.075,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: sizeMul * 10,
                                      top: sizeMul * 33.5,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            InkWell(
                                              splashColor:
                                                  Colors.white.withAlpha(0),
                                              highlightColor:
                                                  Colors.black.withOpacity(0.1),
                                              onTap: () {
                                                model.viewing_period =
                                                    Period.MONTHLY;
                                              },
                                              child: Container(
                                                // color: Colors.white,
                                                padding: (model
                                                            .viewing_period ==
                                                        Period.MONTHLY)
                                                    ? EdgeInsets.symmetric(
                                                        vertical: sizeMul * 2,
                                                        horizontal: sizeMul * 8)
                                                    : null,
                                                decoration: (model
                                                            .viewing_period ==
                                                        Period.MONTHLY)
                                                    ? BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    sizeMul *
                                                                        300))
                                                    : null,

                                                child: Text("MONTHLY",
                                                    style:
                                                        (model.viewing_period ==
                                                                Period.MONTHLY)
                                                            ? headerStyleSelected
                                                            : headerStyle),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                model.viewing_period =
                                                    Period.MONTHLY;
                                              },
                                              splashColor:
                                                  Colors.white.withAlpha(0),
                                              highlightColor:
                                                  Colors.black.withOpacity(0.1),
                                              child: Container(
                                                padding: (model
                                                            .viewing_period ==
                                                        Period.WEEKLY)
                                                    ? EdgeInsets.symmetric(
                                                        vertical: sizeMul * 2,
                                                        horizontal: sizeMul * 8)
                                                    : null,
                                                decoration: (model
                                                            .viewing_period ==
                                                        Period.WEEKLY)
                                                    ? BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    sizeMul *
                                                                        300))
                                                    : null,
                                                child: InkWell(
                                                  onTap: () {
                                                    model.viewing_period =
                                                        Period.WEEKLY;
                                                  },
                                                  splashColor:
                                                      Colors.white.withAlpha(0),
                                                  highlightColor: Colors.black
                                                      .withOpacity(0.1),
                                                  child: Text(
                                                    "WEEKLY",
                                                    style:
                                                        (model.viewing_period ==
                                                                Period.WEEKLY)
                                                            ? headerStyleSelected
                                                            : headerStyle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                model.viewing_period =
                                                    Period.DAILY;
                                              },
                                              child: Container(
                                                padding: (model
                                                            .viewing_period ==
                                                        Period.DAILY)
                                                    ? EdgeInsets.symmetric(
                                                        vertical: sizeMul * 2,
                                                        horizontal: sizeMul * 8)
                                                    : null,
                                                decoration: (model
                                                            .viewing_period ==
                                                        Period.DAILY)
                                                    ? BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    sizeMul *
                                                                        300))
                                                    : null,
                                                child: Text(
                                                  "DAILY",
                                                  style:
                                                      (model.viewing_period ==
                                                              Period.DAILY)
                                                          ? headerStyleSelected
                                                          : headerStyle,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: sizeMul * 30,
                                      top: sizeMul * 79,
                                      child: Text("Charts",
                                          style: TextStyle(
                                            fontSize: sizeMul * 35,
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
