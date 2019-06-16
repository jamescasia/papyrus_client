import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/LongButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:papyrus_client/helpers/LongButton.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => new _LogInScreenState();
}

// var sizeMulW;
class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    sizeMulW = MediaQuery.of(context).size.width / 411.4;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      // #61C350
    ));
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
          // decoration: BoxDecoration(

          //     // gradient: greeny,
          //     color: Colors.green

          //     ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icons/3x/papygreen.png",
                width: sizeMulW * 50,
              ),
              Text(
                "Sign in \nto Papyrus.",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: sizeMulW * 50,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w900),
              ),

              TextField(),
              LongButton(
                greeny.colors[1],
                300 * sizeMulW,
                60 * sizeMulW,
                sizeMulW * 3,
                Colors.green,
                greeny.colors[0],
                sizeMulW * 9,
                () {},
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "SIGN IN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: sizeMulW * 25),
                      ),
                      SizedBox(
                        width: sizeMulW * 5,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: sizeMulW * 35,
                      )
                    ],
                  ),
                ),
                // null
              ),

              Container(
                // margin: EdgeInsets.all(sizeMulW*10),
                width: sizeMulW * 360,
                height: sizeMulW * 60,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius:
                        BorderRadius.all(Radius.circular(sizeMulW * 10))),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: sizeMulW * 20,
                        child: Icon(
                          FontAwesomeIcons.user,
                          color: Colors.grey[500],
                        )),
                    Positioned(
                      left: sizeMulW * 55,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(sizeMulW * 18.0),
                        child: Center(
                          child: EditableText(
                            controller: email_controller,
                            focusNode: email_focus,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: sizeMulW * 30),
                            cursorColor: Colors.pinkAccent,
                            backgroundCursorColor: Colors.red,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
              // Container(
              //   height: sizeMulW * 300,
              //   width: MediaQuery.of(context).size.width,
              //   margin: EdgeInsets.symmetric(
              //       horizontal: sizeMulW * 30, vertical: sizeMulW * 30),
              //   child: Card(
              //     color: Colors.green,
              //     elevation: 0,
              //     shape: RoundedRectangleBorder(
              //         borderRadius:
              //             BorderRadius.all(Radius.circular(30 * sizeMulW))),
              //     child: Column(
              //       children: <Widget>[
              //         Container(
              //           width: sizeMulW * 300,
              //           height: sizeMulW * 60,
              //           decoration: BoxDecoration(
              //               color: Colors.grey[200],
              //               borderRadius: BorderRadius.all(
              //                   Radius.circular(sizeMulW * 10))),
              //           child: Stack(
              //             children: <Widget>[
              //               Positioned(
              //                   top: 0,
              //                   bottom: 0,
              //                   left: sizeMulW * 20,
              //                   child: Icon(
              //                     FontAwesomeIcons.user,
              //                     color: Colors.grey[500],
              //                   )),
              //               Positioned(
              //                 left: sizeMulW * 55,
              //                 top: 0,
              //                 bottom: 0,
              //                 child: Container(
              //                   padding:   EdgeInsets.all(sizeMulW*18.0),
              //                   child: Center(
              //                     child: EditableText(
              //                       controller: email_controller,
              //                       focusNode: email_focus,
              //                       style: TextStyle(
              //                           color: Colors.grey[700],
              //                           fontSize: sizeMulW * 30),
              //                       cursorColor: Colors.pinkAccent,
              //                       backgroundCursorColor: Colors.red,
              //                     ),
              //                   ),
              //                 ),
              //               )
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // )
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










