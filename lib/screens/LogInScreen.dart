import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/LongButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:papyrus_client/helpers/LongButton.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

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
  bool isEmailValid = true;
  bool isPassValid = true;
  bool keyBoardUp = false;
ScrollController sc  = ScrollController();
  StreamSubscription sub;

  @override
  void initState() {
    // TODO: implement initState\
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      print(visible);

      setState(() {
        keyBoardUp = visible;
        if(keyBoardUp) {
          Future.delayed(Duration(milliseconds: 40)).then((_){


          sc.animateTo(sc.position.maxScrollExtent/2, duration: Duration(milliseconds: 100), curve:  Curves.easeOut);
          });
          
        }
      });
    });
    super.initState();
  }

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
        child: SingleChildScrollView(
          controller: sc,
          child: new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: greeny.scale(01),
              // color: Colors.green
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Log in\nto start saving",
                        style: TextStyle(
                            fontSize: sizeMulW * 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 275,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    boxShadow: [
                      new BoxShadow(
                        blurRadius: 20 * sizeMulW,
                        color: Colors.black12,
                        offset: new Offset(6 * sizeMulW, 6 * sizeMulW),
                      ),
                      new BoxShadow(
                        blurRadius: 20 * sizeMulW,
                        color: Colors.black12,
                        offset: new Offset(-6 * sizeMulW, -6 * sizeMulW),
                      ),
                    ],
                  ),
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 80,
                          margin: EdgeInsets.only(bottom: sizeMulW * 5),
                          child: TextField(
                            controller: email_controller,
                            style: TextStyle(fontSize: sizeMulW * 19),
                            onChanged: (String val) {
                              setState(() {
                                if (val.contains("@") && val.contains("."))
                                  isEmailValid = true;
                                else
                                  isEmailValid = false;
                              });
                            },
                            decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(),
                                // filled: isEmailValid,
                                fillColor: Color(0xffBFFF00),
                                labelText: "email",
                                errorText:
                                    isEmailValid ? null : "Input valid email",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 85,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          margin: EdgeInsets.only(bottom: sizeMulW * 5),
                          child: TextField(
                            controller: pass_controller,
                            style: TextStyle(fontSize: sizeMulW * 19),
                            onChanged: (String val) {
                              setState(() {
                                if (val.length <= 5)
                                  isPassValid = false;
                                else
                                  isPassValid = true;
                              });
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                labelText: "password",
                                errorText: isPassValid
                                    ? null
                                    : "Password must be at least 6 characters",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: LongButton(
                          (isEmailValid && isPassValid)
                              ? greeny.colors[1]
                              : Colors.red,
                          333 * sizeMulW,
                          69 * sizeMulW,
                          sizeMulW * 3,
                          (isEmailValid && isPassValid)
                              ? Colors.green
                              : Colors.amber,
                          (isEmailValid && isPassValid)
                              ? greeny.colors[0]
                              : Colors.red,
                          sizeMulW * 3000,
                          () {
                            if (isPassValid &&
                                isEmailValid &&
                                email_controller.text != "" &&
                                pass_controller.text != "") {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                sub = appModel
                                    .login(email_controller.text,
                                        pass_controller.text)
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
                            }
                          },
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "LOG IN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      //
                                      fontWeight: FontWeight.w900,
                                      fontSize: sizeMulW * 20),
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
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      height: sizeMulW * 100,
                      child: Material(
                        color: Colors.white.withAlpha(0),
                        child: InkWell(
                          highlightColor: Colors.white.withAlpha(0),
                          splashColor: Colors.white.withAlpha(0),
                          onTap: () {},
                          child: Container(
                            height: sizeMulW * 100,
                            margin:
                                EdgeInsets.symmetric(horizontal:  25),
                            padding: EdgeInsets.all(sizeMulW * 30),
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(30),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: InkWell(
                              child: Center(
                                child: Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: sizeMulW * 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            // child: Stack(
            //   children: <Widget>[
            //     Positioned(
            //       child: Text(
            //         "Log in\nto start saving",
            //         style: TextStyle(
            //             fontSize: sizeMulW * 40, fontWeight: FontWeight.w600, color: Colors.white),
            //       ),
            //     ),
            //     Positioned(
            //       top: sizeMulW * 226,
            //       left: homeButtonDist,
            //       child: Material(
            //         color: Colors.white.withAlpha(0),
            //         child: InkWell(
            //           onTap: () {
            //             appModel.logOut();
            //           },
            //           child: Image.asset(
            //             "assets/icons/3x/papygreen.png",
            //             width: 70 * sizeMulW,
            //           ),
            //         ),
            //       ),
            //     ),

            //     (isLoading)
            //         ? Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : SizedBox(width: 1)
            //   ],
            // ),
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
