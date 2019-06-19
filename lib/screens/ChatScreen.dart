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
import 'package:keyboard_visibility/keyboard_visibility.dart';

class ChatScreen extends StatefulWidget {
  ChatModel cModel;

  ChatScreen(this.cModel);
  @override
  _ChatScreenState createState() => new _ChatScreenState(cModel);
}

var h;
var w;

class _ChatScreenState extends State<ChatScreen> {
  ChatModel cModel;
  _ChatScreenState(this.cModel);
  FocusNode fn = FocusNode();

  double slidePanelChoicesHeight = 0;
  bool keyBoardUp = false;

  double chatHeight = h;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cModel.init();

    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      print(visible);

      setState(() {
        keyBoardUp = visible;
      });
    });
  }

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
      child: Container(
        width: w,
        height: h,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                // margin: EdgeInsets.symmetric(horizontal: sizeMulW*30, vertical: sizeMulH*30),
                width: w,
                height: (!keyBoardUp) ? h : 0.55 * h,
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(sizeMulW * 30)),
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
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: sizeMulW * 25,
                                            top: sizeMulW * 50),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          reverse: true,
                                          controller: cModel.scont,
                                          scrollDirection: Axis.vertical,
                                          padding:
                                              EdgeInsets.all(sizeMulW * 10),
                                          itemCount: appModel
                                              .allMessages.messages.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            if (i ==
                                                appModel.allMessages.messages
                                                        .length )
                                              // return SizedBox(
                                              //   width: 1,
                                              // );
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
                                                          fontSize:
                                                              sizeMulW * 23),
                                                    )
                                                  ],
                                                ),
                                              );
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: (i ==
                                                          appModel
                                                                  .allMessages
                                                                  .messages
                                                                  .length -
                                                              1)
                                                      ? sizeMulW * 0
                                                      : 0),
                                              child: MessageBox(appModel
                                                  .allMessages.messages[i]),
                                            );
                                          },
                                        ),
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
                                                            fontSize:
                                                                sizeMulW * 23,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: sizeMulW * 20,
                                                    ),
                                                    (cModel.payprIsTyping)
                                                        ? CollectionSlideTransition(
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .all(
                                                                        sizeMulW *
                                                                            2),
                                                                width:
                                                                    sizeMulW *
                                                                        8,
                                                                height:
                                                                    sizeMulW *
                                                                        8,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(3000))),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .all(
                                                                        sizeMulW *
                                                                            2),
                                                                width:
                                                                    sizeMulW *
                                                                        8,
                                                                height:
                                                                    sizeMulW *
                                                                        8,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(3000))),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .all(
                                                                        sizeMulW *
                                                                            2),
                                                                width:
                                                                    sizeMulW *
                                                                        8,
                                                                height:
                                                                    sizeMulW *
                                                                        8,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(3000))),
                                                              )
                                                            ],
                                                            // color: Colors.white,
                                                          )
                                                        : SizedBox(width: 0.01),
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                3000))),
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
                                    left: 0,
                                    right: 0,
                                    bottom: 0.05*h,
                                    child: AnimatedContainer(
                                      curve: Curves.bounceIn,
                                      duration: Duration(milliseconds: 100),
                                      width: w,
                                      height: slidePanelChoicesHeight,
                                      child: Container(
                                        // height: h * 0.3,
                                        width: w,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              // margin: EdgeInsets.only(
                                              //     top: sizeMulW * 4),
                                              // height: sizeMulW * 35,
                                              child: OutlineButton(
                                                color: Colors.white,
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                                onPressed: () {
                                                  setState(() {
                                                    if (slidePanelChoicesHeight ==
                                                        0)
                                                      slidePanelChoicesHeight =
                                                          h*0.45;
                                                    else
                                                      slidePanelChoicesHeight =
                                                          0;
                                                  });
                                                  cModel.cont.text =
                                                      cModel.choiceMessages[0];
                                                  cModel.sendMessage();
                                                },
                                                child: Text(
                                                  cModel.choiceMessages[0],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              sizeMulW * 30)),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // margin: EdgeInsets.only(
                                              //     top: sizeMulW * 4),
                                              // height: sizeMulW * 35,
                                              child: OutlineButton(
                                                color: Colors.white,
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                                onPressed: () {
                                                  setState(() {
                                                    if (slidePanelChoicesHeight ==
                                                        0)
                                                      slidePanelChoicesHeight =
                                                          h*0.45;
                                                    else
                                                      slidePanelChoicesHeight =
                                                          0;
                                                  });
                                                  cModel.cont.text =
                                                      cModel.choiceMessages[1];
                                                  cModel.sendMessage();
                                                },
                                                child: Text(
                                                  cModel.choiceMessages[1],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              sizeMulW * 30)),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // margin: EdgeInsets.only(
                                              //     top: sizeMulW * 4),
                                              // height: sizeMulW * 35,
                                              child: OutlineButton(
                                                color: Colors.white,
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                                onPressed: () {
                                                  setState(() {
                                                    if (slidePanelChoicesHeight ==
                                                        0)
                                                      slidePanelChoicesHeight =
                                                          h*0.45;
                                                    else
                                                      slidePanelChoicesHeight =
                                                          0;
                                                  });
                                                  cModel.cont.text =
                                                      cModel.choiceMessages[2];
                                                  cModel.sendMessage();
                                                },
                                                child: Text(
                                                  cModel.choiceMessages[2],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              sizeMulW * 30)),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // margin: EdgeInsets.only(
                                              //     top: sizeMulW * 4),
                                              // height: sizeMulW * 35,
                                              child: OutlineButton(
                                                color: Colors.white,
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                                onPressed: () {
                                                  setState(() {
                                                    if (slidePanelChoicesHeight ==
                                                        0)
                                                      slidePanelChoicesHeight =
                                                          h*0.45;
                                                    else
                                                      slidePanelChoicesHeight =
                                                          0;
                                                  });
                                                  cModel.cont.text =
                                                      cModel.choiceMessages[3];
                                                  cModel.sendMessage();
                                                },
                                                child: Text(
                                                  cModel.choiceMessages[3],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              sizeMulW * 30)),
                                                ),
                                              ),
                                            ), Container(
                                              // margin: EdgeInsets.only(
                                              //     top: sizeMulW * 4),
                                              // height: sizeMulW * 35,
                                              child: OutlineButton(
                                                color: Colors.white,
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                                onPressed: () {
                                                  setState(() {
                                                    if (slidePanelChoicesHeight ==
                                                        0)
                                                      slidePanelChoicesHeight =
                                                          h*0.45;
                                                    else
                                                      slidePanelChoicesHeight =
                                                          0;
                                                  });
                                                  cModel.cont.text =
                                                      cModel.choiceMessages[4];
                                                  cModel.sendMessage();
                                                },
                                                child: Text(
                                                  cModel.choiceMessages[4],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              sizeMulW * 30)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20*sizeMulW,)
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.4)),
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.vertical(
                                            top:
                                                Radius.circular(sizeMulW * 30)),
                                      ),

                                      // child: ,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Stack(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(sizeMulW * 3000)),
                                          child: Container(
                                            height: h * 0.1,
                                            width: w,
                                            color: Colors.green,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Container(
                                                    width: h * 0.1,
                                                    height: h * 0.1,
                                                    decoration: BoxDecoration(
                                                      // color: Colors.green[700],
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              sizeMulW * 3000)),
                                                    ),
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  3000)),
                                                      onTap: () {
                                                        setState(() {
                                                          if (slidePanelChoicesHeight ==
                                                              0) {
                                                            slidePanelChoicesHeight =
                                                                h*0.45;
                                                          } else {
                                                            slidePanelChoicesHeight =
                                                                0;
                                                          }
                                                        });
                                                      },
                                                      child: Icon(
                                                        (slidePanelChoicesHeight ==
                                                                0)
                                                            ? FontAwesomeIcons
                                                                .chevronCircleUp
                                                            : FontAwesomeIcons
                                                                .chevronCircleDown,
                                                        color: Colors.white,
                                                        size: sizeMulW * 30,
                                                      ),
                                                    )),
                                                Expanded(
                                                  child: EditableText(
                                                    backgroundCursorColor:
                                                        Colors.red,
                                                    style: TextStyle(
                                                        fontSize:
                                                            sizeMulW * 19),
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                sizeMulW * 30)),
                                                  ),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                sizeMulW * 3000)),
                                                    splashColor: Colors.yellow,
                                                    highlightColor:
                                                        Colors.lightGreen,
                                                    onTap: () {
                                                      cModel.sendMessage();
                                                    },
                                                    child: Icon(
                                                      FontAwesomeIcons
                                                          .paperPlane,
                                                      size: sizeMulW * 23,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Positioned(
                                        //     top: 0,
                                        //     bottom: 0,
                                        //     left: 0,
                                        //     child:

                                        //      Container(
                                        //         width: h * 0.1,
                                        //         height: h * 0.1,
                                        //         decoration: BoxDecoration(
                                        //           // color: Colors.green[700],
                                        //           borderRadius: BorderRadius.all(
                                        //               Radius.circular(
                                        //                   sizeMulW * 30)),
                                        //         ),
                                        //         child: InkWell(
                                        //           onTap: () {
                                        //             setState(() {
                                        //               if (slidePanelChoicesHeight ==
                                        //                   0)
                                        //                 slidePanelChoicesHeight =
                                        //                     h * 0.4;
                                        //               else
                                        //                 slidePanelChoicesHeight = 0;
                                        //             });
                                        //           },
                                        //           child: Icon(
                                        //             (slidePanelChoicesHeight == 0)
                                        //                 ? FontAwesomeIcons
                                        //                     .chevronCircleUp
                                        //                 : FontAwesomeIcons
                                        //                     .chevronCircleDown,
                                        //             color: Colors.white,
                                        //             size: sizeMulW * 30,
                                        //           ),
                                        //         ))),
                                      ],
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
            ),
          ],
        ),
      ),
    );
  }
}
