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
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SettingScreenBottomPart(),
              ],
            ),
          ),
          Positioned(
            bottom: sizeMul * 35,
            left: 0,
            // right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LongButton(
                    Colors.red, 333 * sizeMul, 69 * sizeMul, sizeMul * 3,
                    Colors.redAccent,
                    Colors.red[800],
                    sizeMul * 9,
                    () {
                      setState(() {
                        isLoading = true;
                      });
                      appModel.mAuth.signOut().then((a) {
                        Navigator.push(
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
                                fontSize: sizeMul * 20),
                          ),
                          SizedBox(
                            width: sizeMul * 10,
                          ),
                          Icon(
                            // Icons.chevron_right,
                            FontAwesomeIcons.doorOpen,
                            color: Colors.white,
                            size:sizeMul*23
                            // size: sizeMul * 35,
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
                        blurRadius: 10 * sizeMul,
                        offset: Offset(0, sizeMul),
                        color: Colors.black38),
                    clipper: CustomShapeClipper(
                        sizeMul: sizeMul,
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.width * 0.38),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(gradient: greeny),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 2,
                              top:   24,
                              child: InkWell(
                                splashColor: Colors.white.withAlpha(0),
                                highlightColor: Colors.black.withOpacity(0.1),
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
                                    height: MediaQuery.of(context).size.width *
                                        0.075,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: sizeMul * 30,
                              top: sizeMul * 70,
                              child: Text("Settings",
                                  style: TextStyle(
                                    fontSize: sizeMul * 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ],
                        ))),
                Positioned(
                    // right: sizeMul * sizeMul * 12,

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
                            width: sizeMul * 74.052,
                            height: sizeMul * 74.052,
                            padding: EdgeInsets.all(sizeMul * 22),
                            child: Image.asset(
                              'assets/icons/3x/papyrus.png',
                              height: sizeMul * 3,
                              width: sizeMul * 3,
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
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
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
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return Container(
        width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.symmetric(horizontal: sizeMul*20),
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: sizeMul * 200,
                ),
                Container(
                  color: Colors.grey[200],
                  height: sizeMul * 65,
                  child: Padding(
                    padding: EdgeInsets.all(18.0 * sizeMul),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Get notified of unique promos",
                          style: TextStyle(
                              fontSize: sizeMul * 17,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: sizeMul * 60,
                          height: sizeMul * 60,
                          child: Switch(
                            value: true,
                            onChanged: (bool value) {
                              model.receiveUniquePromos = value;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  // color: Colors.grey[200],
                  height: sizeMul * 65,
                  child: Padding(
                    padding: EdgeInsets.all(18.0 * sizeMul),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Get notified of open-to-all promos",
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: sizeMul * 17,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          height: sizeMul * 60,
                          width: sizeMul * 60,
                          child: Switch(
                            value: true,
                            onChanged: (bool value) {
                              model.receiveOpenToAllPromos = value;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  height: sizeMul * 65,
                  child: Padding(
                    padding: EdgeInsets.all(18.0 * sizeMul),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Delete Account",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: sizeMul * 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30 * sizeMul,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
