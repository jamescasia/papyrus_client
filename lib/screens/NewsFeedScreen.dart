import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/ReceiptCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:papyrus_client/models/ReceiptsScreenModel.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papyrus_client/helpers/NewsFeedCard.dart';
import 'package:papyrus_client/data_models/Receipt.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => new _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  _NewsFeedScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        // color: Colors.white,
        // child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NewsFeedScreenTopPart()
            // , NewsFeedScreenBottomPart()
          ],
          // ),
        ),
      ),
    );
  }
}

class NewsFeedScreenTopPart extends StatefulWidget {
  @override
  _NewsFeedScreenTopPartState createState() =>
      new _NewsFeedScreenTopPartState();
}

class _NewsFeedScreenTopPartState extends State<NewsFeedScreenTopPart> {
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: <Widget>[
          NewsFeedScreenBottomPart(),
          Container(
            height: MediaQuery.of(context).size.width * 0.414,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                ClipShadowPath(
                    shadow: Shadow(
                        blurRadius: 10 * sizeMulW,
                        offset: Offset(0, sizeMulW),
                        color: Colors.black38),
                    clipper: CustomShapeClipper(
                        sizeMulW: sizeMulW,
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.width * 0.38),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
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
                                  splashColor: Colors.white.withAlpha(0),
                                  highlightColor: Colors.black.withOpacity(0),
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
                              left: sizeMulW * 30,
                              top: MediaQuery.of(context).size.width *
                                  0.38 *
                                  0.45,
                              child: Text("News",
                                  style: TextStyle(
                                    fontSize: sizeMulW * 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ],
                        ))),
                Positioned(
                    // right: sizeMulW * sizeMulW * 12,

                    // right: MediaQuery.of(context).size.width * 0.035,
                    left: homeButtonDist,
                    bottom: 0,
                    // top:100,
                    child: RaisedButton(
                      splashColor: greeny.colors[0],
                      animationDuration: Duration(milliseconds: 100),
                      shape: CircleBorder(),
                      elevation: 5,
                      color: greeny.colors[1],
                      onPressed: () {
                        appModel.fetchNews(2);
                        // Navigator.push(context,
                        //     CupertinoPageRoute(builder: (context) {
                        //   return
                        //       // EditNewsFeedScreen(appModel.editNewsFeedScreenModel)
                        //       // CameraCaptureScreen()
                        //       GetNewsFeedScreen(appModel.cameraCaptureModel);
                        // }));
                      },
                      child: Container(
                  width:sizeMulW  * 74.052,
                  height: sizeMulW  * 74.052,
                        child: Icon(
                          FontAwesomeIcons.solidNewspaper,
                          size: MediaQuery.of(context).size.width * 0.07,
                          color: Colors.white,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ]),
      );
    });
  }
}

class NewsFeedScreenBottomPart extends StatefulWidget {
  @override
  _NewsFeedScreenBottomPartState createState() =>
      new _NewsFeedScreenBottomPartState();
}

class _NewsFeedScreenBottomPartState extends State<NewsFeedScreenBottomPart> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(rebuildOnChange: true,builder: (context, child, appModel) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(
          horizontal: sizeMulW * 37,
        ),
        child: (appModel.newsLoaded)
            ? ListView.builder(
                // reverse: true,
                itemCount: appModel.listOfNews.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.only(
                          top: sizeMulW * 160, bottom: sizeMulW * 9),
                      child: NewsFeedCard(
                          context, appModel.listOfNews[index], index),
                    );
                  }
                  if (index == appModel.listOfNews.length - 1) {
                    return Container(
                      margin: EdgeInsets.only(
                           bottom: sizeMulW * 50, top: sizeMulW * 9),
                      child: NewsFeedCard(
                          context, appModel.listOfNews[index], index),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: sizeMulW * 9),
                    child: NewsFeedCard(
                        context, appModel.listOfNews[index], index),
                  );
                  // return Text("hello${appModel.receipts[index].items[0].name}",style: TextStyle(fontSize: 50,));
                },
              )
            : Center(
                            child: Column(children: <Widget>[
                          HeartbeatProgressIndicator(
                            child: Icon(FontAwesomeIcons.newspaper,
                                color: Colors.grey[300], size: 30 * sizeMulW),
                          ),
                          SizedBox(height: sizeMulW*40),
                          Text(
                            "Fetching news",
                            style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600),
                            textScaleFactor: 1.1,
                          ),
                        ])),
      );
    });
  }
}
