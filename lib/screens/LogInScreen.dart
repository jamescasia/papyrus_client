



import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/LongButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => new _LogInScreenState();
}

// var sizeMulW;
class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    sizeMulW = MediaQuery.of(context).size.width / 411.4;
    return Scaffold(
      body: LogInScreenStack(),
    );
  }
}

class LogInScreenStack extends StatefulWidget {
  @override
  _LogInScreenStackState createState() => new _LogInScreenStackState();
}

class _LogInScreenStackState extends State<LogInScreenStack> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  FocusNode email_focus = FocusNode();
  FocusNode pass_focus = FocusNode();
  bool isLoading = false;
  StreamSubscription sub;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        // stream: null,
        builder: (context, child, appModel) {
      return WillPopScope(
        onWillPop: () {
          if (isLoading) {
            sub.cancel();
            setState(() {
              isLoading = false;
            });
          } else
            _showDialog(context);
        },
        child: new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(

              // gradient: greeny,
              color: Colors.green),
          child: Stack(
            children: <Widget>[
              ClipShadowPath(
                  shadow: Shadow(
                      blurRadius: 10 * sizeMulW,
                      offset: Offset(0, sizeMulW),
                      color: Colors.black38.withAlpha(0)),
                  clipper: CustomShapeClipper(
                      sizeMulW: sizeMulW,
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.width * 0.91),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                  )),
              Positioned(
                child: Text(
                  "Log in\nto start saving",
                  style: TextStyle(
                      fontSize: sizeMulW * 40, fontWeight: FontWeight.w900),
                ),
              ),
              Positioned(
                top: sizeMulW * 226,
                // right: MediaQuery.of(context).size.width * 0.073,
                left: homeButtonDist,
                child: Material(
                  color: Colors.white.withAlpha(0),
                  child: InkWell(
                    onTap: () {
                      appModel.logOut();
                      // appModel.logOut().then(() => Navigator.push(
                      //     context,
                      //     CupertinoPageRoute(
                      //         builder: (context) => HomeScreen())));
                    },
                    child: Image.asset(
                      "assets/icons/3x/papygreen.png",
                      width: 70 * sizeMulW,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  padding: EdgeInsets.all(sizeMulW * 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: sizeMulW * 30,
                      ),
                      Container(
                        width: sizeMulW * 260,
                        height: sizeMulW * 50,
                        padding: EdgeInsets.symmetric(horizontal: sizeMulW * 15),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3000)),
                            border: Border.all(
                                color: Colors.white, width: sizeMulW * 2)),
                        child: Center(
                          child: EditableText(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white, fontSize: sizeMulW * 23),
                            backgroundCursorColor: Colors.red,
                            cursorColor: Colors.pinkAccent,
                            focusNode: email_focus,
                            controller: email_controller,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeMulW * 30,
                      ),
                      Container(
                        width: sizeMulW * 260,
                        height: sizeMulW * 50,
                        padding: EdgeInsets.symmetric(horizontal: sizeMulW * 15),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3000)),
                            border: Border.all(
                                color: Colors.white, width: sizeMulW * 2)),
                        child: Center(
                          child: EditableText(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white, fontSize: sizeMulW * 23),
                            backgroundCursorColor: Colors.red,
                            cursorColor: Colors.pinkAccent,
                            focusNode: pass_focus,
                            controller: pass_controller,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeMulW * 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: sizeMulW * 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(sizeMulW * 35))),
                        child: OutlineButton(
                          highlightedBorderColor: Colors.white,
                          highlightColor: Colors.green,
                          textColor: Colors.white,
                          disabledBorderColor: Colors.white,
                          color: Colors.white,
                          borderSide: BorderSide(
                              color: Colors.white, width: sizeMulW * 2),
                          child: Text(
                            "Log in",
                            style: TextStyle(fontSize: sizeMulW * 19),
                          ),
                          splashColor: Colors.greenAccent,
                          highlightElevation: 5,
                          clipBehavior: Clip.none,
                          onPressed: () { 
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              sub = appModel
                                  .login("user@user.com", "useruser")
                                  .asStream()
                                  .listen((data) {
                                if (data.email != null) {
                                  Navigator.pushReplacement(context,
                                      CupertinoPageRoute(builder: (context) {
                                    isLoading = false;
                                    return HomeScreen();
                                  }));
                                }
                              });
                            } catch (a) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Failed to login ${a.toString()}"),
                              ));
                            }

                            //     .then((user) {
                            //   if (user.uid != null) {
                            //     // Navigator.
                            //     Navigator.push(
                            //         context,
                            //         CupertinoPageRoute(
                            //             builder: (context) => HomeScreen()));
                            //   }
                            // });

                            // Navigator.push(
                            //     context,
                            //     CupertinoPageRoute(
                            //         builder: (context) => FutureBuilder(
                            //             future: appModel.login(
                            //                 "user@user.com", "useruser"),
                            //             builder: (context, snapshot) {
                            //               if (snapshot.connectionState ==
                            //                   ConnectionState.done) {
                            //                 if (snapshot.data != null)
                            //                   return HomeScreen();
                            //                 else
                            //                   return LogInScreen();
                            //               }
                            //               // else {
                            //               //   setState(() {
                            //               //     isLoading = true;
                            //               //   });
                            //               //   return null;
                            //               // }
                            //             })));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (isLoading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(width: 1)
            ],
          ),
        ),
      );
    });
  }
}

void _showDialog(BuildContext context) {
  // flutter defined function
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // elevation: 0,
        // backgroundColor: Colors.green.withAlpha(0),

        // title: new Text("Alert Dialog title"),
        content: Text("Really want to close ?"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Yes"),
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
