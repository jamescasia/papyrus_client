import 'package:flutter/material.dart';
import 'package:papyrus_client/helpers/CustomShowDialog.dart';
import 'HomeScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/CustomShapeReversed.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:papyrus_client/models/ChatModel.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:papyrus_client/helpers/MessageBox.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => new _ChatScreenState();
}

var h;
var w;

class _ChatScreenState extends State<ChatScreen> {
  FocusNode fn = FocusNode();
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height * 0.9;
    w = MediaQuery.of(context).size.width * 0.9;

    // return Container(
    //   width: w,
    //   height: h,
    //   color: Colors.green.withOpacity(0.3),
    //   child: Text("gamay otim"),
    // );

    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            // margin: EdgeInsets.symmetric(horizontal: sizeMulW*30, vertical: sizeMulH*30),
            width: w,
            height: h,
            // contentPadding: EdgeInsets.all(0),

            child: ScopedModelDescendant<AppModel>(
                builder: (context, child, appModel) {
              return ScopedModel<ChatModel>(
                  model: appModel.chatModel,
                  child: ScopedModelDescendant<ChatModel>(
                      builder: (context, child, cModel) {
                    return Material(
                      color: Colors.white.withAlpha(0),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(sizeMulW * 30)),
                        child: new Container(
                          width: w,
                          height: h,
                          // decoration: new BoxDecoration(
                          //   shape: BoxShape.rectangle,
                          //   color: const Color(0xFFFFFF),
                          // ),
                          child: new Stack(
                            children: <Widget>[
                              Positioned(
                                bottom: h * 0.05,
                                child: Container(
                                  width: w,
                                  height: h * 0.9,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    controller: cModel.scont,
                                    scrollDirection: Axis.vertical,
                                    padding: EdgeInsets.all(sizeMulW * 10),
                                    itemCount:
                                        appModel.allMessages.messages.length +
                                            1,
                                    itemBuilder: (BuildContext context, int i) {
                                      if (i == 0)
                                        return Container(
                                          width: w,
                                          height: h * 0.4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.robot,
                                                size: sizeMulW * 40,
                                              ),
                                              Text(
                                                "Hello I am Paypr!",
                                                style: TextStyle(
                                                    fontSize: sizeMulW * 23),
                                              )
                                            ],
                                          ),
                                        );
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: (i - 1 ==
                                                    appModel.allMessages
                                                            .messages.length -
                                                        1)
                                                ? sizeMulW * 30
                                                : 0),
                                        child: MessageBox(appModel
                                            .allMessages.messages[i - 1]),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  child: Container(
                                    width: w,
                                    height: 0.13 * h,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          // BorderRadius.all(Radius.circular(sizeMulW * 30)),
                                          BorderRadius.vertical(
                                              top: Radius.circular(
                                                  sizeMulW * 30)),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          bottom: 0,
                                          top: 0,
                                          left: sizeMulW * 23,
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(FontAwesomeIcons.robot,
                                                    color: Colors.white,
                                                    size: sizeMulW * 35),
                                                SizedBox(
                                                  width: sizeMulW * 25,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: sizeMulW * 7),
                                                  child: Text(
                                                    "Paypr",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: sizeMulW * 23,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                SizedBox(width: sizeMulW*20,),
                                                CollectionSlideTransition(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.all(
                                                          sizeMulW * 2),
                                                      width: sizeMulW * 8,
                                                      height: sizeMulW * 8,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      3000))),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.all(
                                                          sizeMulW * 2),
                                                      width: sizeMulW * 8,
                                                      height: sizeMulW * 8,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      3000))),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.all(
                                                          sizeMulW * 2),
                                                      width: sizeMulW * 8,
                                                      height: sizeMulW * 8,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      3000))),
                                                    )
                                                  ],
                                                  // color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: sizeMulW * 17,
                                          top: sizeMulW * 17,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3000))),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.green,
                                                size: sizeMulW * 25,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),

                              // Expanded(
                              //     child: Container(
                              //   width: double.infinity,
                              //   height: h * 0.05,
                              //   color: Colors.blue,
                              //   // child: ,
                              // )),
                              Positioned(
                                bottom: 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(sizeMulW * 30)),
                                  child: Container(
                                    height: h * 0.1,
                                    width: w,
                                    color: Colors.green,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 0.05 * h,
                                        ),
                                        Expanded(
                                          child: EditableText(
                                            backgroundCursorColor: Colors.red,
                                            style: TextStyle(
                                                fontSize: sizeMulW * 19),
                                            cursorColor: Colors.white,
                                            controller: cModel.cont,
                                            focusNode: fn,
                                          ),
                                        ),
                                        Container(
                                          width: 0.1 * h,
                                          height: 0.1 * h,
                                          decoration: BoxDecoration(
                                            color: Colors.green[700],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(sizeMulW * 30)),
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(sizeMulW * 30)),
                                            splashColor: Colors.yellow,
                                            highlightColor: Colors.lightGreen,
                                            onTap: () {
                                              cModel.sendMessage();
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.paperPlane,
                                              size: sizeMulW * 23,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            }),
          ),
        ],
      ),
    );
  }
}
