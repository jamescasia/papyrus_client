import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/LongButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:scoped_model/scoped_model.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => new _LogInScreenState();
}

// var sizeMul;
class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    sizeMul = MediaQuery.of(context).size.width / 411.4;
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
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      // stream: null,
      builder: (context, child, appModel) {
        return new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(

              // gradient: greeny,
              color: Colors.green),
          child: Stack(
            children: <Widget>[
              ClipShadowPath(
                  shadow: Shadow(
                      blurRadius: 10 * sizeMul,
                      offset: Offset(0, sizeMul),
                      color: Colors.black38.withAlpha(0)),
                  clipper: CustomShapeClipper(
                      sizeMul: sizeMul,
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.width * 0.91),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                  )),

                  Positioned(
                    child: Text("Log in\nto start saving", style: TextStyle(fontSize: sizeMul*40, fontWeight: FontWeight.w900),

                    ),
                  ),
              Positioned(
                top: sizeMul * 226,
                right: MediaQuery.of(context).size.width * 0.073,
                child: Material(
                  color: Colors.white.withAlpha(0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: Image.asset(
                      "assets/icons/3x/papygreen.png",
                      width: 70 * sizeMul,
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
                  padding: EdgeInsets.all(sizeMul * 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: sizeMul * 30,
                      ),
                      Container(
                        width: sizeMul * 260,
                        height: sizeMul * 50,
                        padding: EdgeInsets.symmetric(horizontal: sizeMul * 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3000)),
                            border: Border.all(
                                color: Colors.white, width: sizeMul * 2)),
                        child: Center(
                          child: EditableText(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white, fontSize: sizeMul * 23),
                            backgroundCursorColor: Colors.red,
                            cursorColor: Colors.pinkAccent,
                            focusNode: email_focus,
                            controller: email_controller,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeMul * 30,
                      ),
                      Container(
                        width: sizeMul * 260,
                        height: sizeMul * 50,
                        padding: EdgeInsets.symmetric(horizontal: sizeMul * 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3000)),
                            border: Border.all(
                                color: Colors.white, width: sizeMul * 2)),
                        child: Center(
                          child: EditableText(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white, fontSize: sizeMul * 23),
                            backgroundCursorColor: Colors.red,
                            cursorColor: Colors.pinkAccent,
                            focusNode: pass_focus,
                            controller: pass_controller,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeMul * 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: sizeMul * 14),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(sizeMul * 35))),
                        child: OutlineButton(
                          highlightedBorderColor: Colors.white,
                          highlightColor: Colors.green,
                          textColor: Colors.white,
                          disabledBorderColor: Colors.white,
                          color: Colors.white,
                          borderSide:
                              BorderSide(color: Colors.white, width: sizeMul * 2),
                          child: Text(
                            "Log in",
                            style: TextStyle(fontSize: sizeMul * 19),
                          ),
                          splashColor: Colors.greenAccent,
                          highlightElevation: 5,
                          clipBehavior: Clip.none,
                          onPressed: () {

                            appModel.login("user@user.com", "useruser");

 
                            // Navigator.push(
                            //     context,
                            //     CupertinoPageRoute(
                            //         builder: (context) => HomeScreen()));
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}