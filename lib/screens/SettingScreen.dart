import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/LongButton.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'LogInScreen.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: Column(
          children: <Widget>[
            SettingScreenTopPart()
            // , SettingScreenBottomPart()
          ],
          // ),
        ),
      ),
    );
  }
}

class SettingScreenTopPart extends StatefulWidget {
  @override
  _SettingScreenTopPartState createState() => new _SettingScreenTopPartState();
}

class _SettingScreenTopPartState extends State<SettingScreenTopPart> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) { 
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SettingScreenBottomPart(),
              ],
            ),
          ),
          Positioned(
            bottom: sizeMulW * 35,
            left: 0,
            // right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LongButton(
                    Colors.red, 333 * sizeMulW, 69 * sizeMulW, sizeMulW * 3,
                    Colors.redAccent,
                    Colors.red[800],
                    sizeMulW * 9,
                    () {
                      setState(() {
                        isLoading = true;
                      });
                      appModel.mAuth.signOut().then((a) {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => LogInScreen()));
                      });
                    },
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "SIGN OUT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: sizeMulW * 20
                                
                                ),
                          ),
                          SizedBox(
                            width: sizeMulW * 10,
                          ),
                          Icon(
                              // Icons.chevron_right,
                              FontAwesomeIcons.doorOpen,
                              color: Colors.white,
                              size: sizeMulW * 23
                              // size: sizeMulW * 35,
                              )
                        ],
                      ),
                    ),
                    // null
                  ),
                ],
              ),
            ),
          ),
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
                              child: Text("Settings",
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
                    child: Tooltip(
                      message: "View Papyrus stores nationwide",
                      child: RaisedButton(
                          splashColor: greeny.colors[0],
                          animationDuration: Duration(milliseconds: 100),
                          shape: CircleBorder(),
                          elevation: 5,
                          color: greeny.colors[1],
                          onPressed: () {},
                          child: Container(
                            width: sizeMulW * 74.052,
                            height: sizeMulW * 74.052,
                            padding: EdgeInsets.all(sizeMulW * 22),
                            child: Image.asset(
                              'assets/icons/3x/papyrus.png',
                              height: sizeMulW * 3,
                              width: sizeMulW * 3,
                            ),

                            //     Icon(
                            //   Icons.refresh,
                            //   size: MediaQuery.of(context).size.width * 0.1,
                            //   color: Colors.white,
                            // ),
                          )),
                    ))
              ],
            ),
          ),
          (isLoading)
              ? Center(
                  child: 
                  SizedBox(width: 0.0001,)
                  
                  
                  // CircularProgressIndicator(
                  //   backgroundColor: Colors.red,
                  // ),
                )
              : SizedBox(width: 1)
        ]),
      );
    });
  }
}

class SettingScreenBottomPart extends StatefulWidget {
  @override
  _SettingScreenBottomPartState createState() =>
      new _SettingScreenBottomPartState();
}

class _SettingScreenBottomPartState extends State<SettingScreenBottomPart> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Container(
        width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.symmetric(horizontal: sizeMulW*20),
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: sizeMulW * 200,
                ),
                Container(
                  color: Colors.grey[200],
                  height: sizeMulW * 65,
                  child: Padding(
                    padding: EdgeInsets.all(18.0 * sizeMulW),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Get notified of unique promos",
                          textScaleFactor: 1,
                          style: TextStyle(
                              // fontSize: sizeMulW * 17,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          width: sizeMulW * 60,
                          height: sizeMulW * 60,
                          child: Switch(
                            value: true,
                            onChanged: (bool value) {
                              appModel.receiveUniquePromos = value;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  // color: Colors.grey[200],
                  height: sizeMulW * 65,
                  child: Padding(
                    padding: EdgeInsets.all(18.0 * sizeMulW),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Get notified of open-to-all promos",
                          overflow: TextOverflow.fade,
                          textScaleFactor: 1,
                          style: TextStyle(
                              // fontSize: sizeMulW * 17,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: sizeMulW * 60,
                          width: sizeMulW * 60,
                          child: Switch(
                            value: true,
                            onChanged: (bool value) {
                              appModel.receiveOpenToAllPromos = value;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  height: sizeMulW * 65,
                  child: Padding(
                    padding: EdgeInsets.all(18.0 * sizeMulW),
                    child: Material(
                      color: Colors.white.withAlpha(0),
                      child: InkWell(
                        splashColor: Colors.white.withAlpha(0),
                        highlightColor: Colors.white.withAlpha(0),
                        onTap: () {
                          appModel.reset();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Delete Account",
                              textScaleFactor:1 ,
                              style: TextStyle(
                                  color: Colors.red,
                                  // fontSize: sizeMulW * 17,

                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30 * sizeMulW,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
