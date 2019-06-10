import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'HomeScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/CameraCaptureModel.dart';
import 'package:flutter/cupertino.dart';
import 'EditReceiptScreen.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

CameraController globalController;

class CameraCaptureScreen extends StatefulWidget {
  @override
  _CameraCaptureScreenState createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  // CameraScreenState cs = CameraScreenState();
  // CameraController controller;

  @override
  void initState() {
    // initializeCameras(cs, this);

    super.initState();
  }

  @override
  void dispose() {
    // globalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!cs.controller.value.isInitialized) {
    //   return Container(width: MediaQuery.of(context).size.width,height: 1,);
    // }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ScopedModelDescendant<AppModel>(
            rebuildOnChange: false,
            builder: (context, child, appModel) {
              return ScopedModel<CameraCaptureModel>(
                  // stream: null,

                  model: appModel.cameraCaptureModel,
                  child: ScopedModelDescendant<CameraCaptureModel>(
                      // stream: null,
                      rebuildOnChange: true,
                      builder: (context, child, ccModel) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.green,
                            // aspectRatio:
                            //     snapshot.data.value.aspectRatio,
                            child: Stack(
                              children: <Widget>[
                                FutureBuilder(
                                    future: (!ccModel.cameraScreenState
                                            .controllerInitSuccesful)
                                        ? ccModel.getController()
                                        : null,
                                    builder: (context, snapshot) {
                                      // ccModel.setCameraScreenState(cs);
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        globalController = ccModel
                                            .cameraScreenState.controller;
                                        return (ccModel.cameraScreenState
                                                .controllerInitSuccesful)
                                            ? ClipShadowPath(
                                                shadow: Shadow(
                                                    blurRadius: 10 * sizeMul,
                                                    offset: Offset(0, sizeMul),
                                                    color: Colors.black38
                                                        .withAlpha(0)),
                                                clipper: CustomShapeClipper(
                                                    sizeMul: sizeMul,
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            sizeMul * 120),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  // decoration: BoxDecoration(
                                                  //     gradient: greeny

                                                  //     ),
                                                  child: CameraPreview(ccModel.cameraScreenState.controller)
                                                ))
                                            : Center(
                                                child: Text(
                                                  "Camera cannot be accessed.\nDid you accept permissions?",
                                                  style: TextStyle(
                                                      fontSize: sizeMul * 23,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              );
                                      } else if (snapshot.connectionState ==
                                              ConnectionState.active ||
                                          snapshot.connectionState ==
                                              ConnectionState.waiting)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      else {
                                        return (ccModel.cameraScreenState
                                                .controllerInitSuccesful)
                                            ? ClipShadowPath(
                                                shadow: Shadow(
                                                    blurRadius: 10 * sizeMul,
                                                    offset: Offset(0, sizeMul),
                                                    color: Colors.black38
                                                        .withAlpha(0)),
                                                clipper: CustomShapeClipper(
                                                    sizeMul: sizeMul,
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            sizeMul * 120),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  // decoration: BoxDecoration(
                                                  //     // gradient: greeny
                                                  //     // color: Colors.red
                                                      
                                                  //     ),
                                                  child:   CameraPreview(ccModel.cameraScreenState.controller)
                                                ))
                                            : Center(
                                                child: Text(
                                                  "Camera cannot be accessed.\nDid you accept permissions?",
                                                  style: TextStyle(
                                                      fontSize: sizeMul * 23,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              );
                                      }
                                    }),
                                Positioned(
                                  bottom: (30 * sizeMul),
                                  left: homeButtonDist + 18 * sizeMul,
                                  child: Material(
                                    shape: CircleBorder(),
                                    child: InkWell(
                                      borderRadius: BorderRadius.all(Radius.circular(3000)),
                                      splashColor: Colors.grey,
                                      highlightColor: Colors.amber,
                                      onTap: (){
                                         // cs.controller.
                                        ccModel.capturePhoto().then((_) {
                                          ccModel.cameraScreenState.controller
                                              .dispose();
                                          Navigator.pushReplacement(context,
                                              CupertinoPageRoute(
                                                  builder: (context) {
                                            return EditReceiptScreen(appModel
                                                .editReceiptScreenModel);
                                          }));
                                          // }
                                        });
                                      },
                                      child: Container(
                                          width: sizeMul * 74.052,
                                          height: sizeMul * 74.052,
                                          child: Icon(FontAwesomeIcons.camera,
                                              color: Colors.green,
                                              size: 30 * sizeMul)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: (22 * sizeMul),
                                  left: homeButtonDist - 45 * sizeMul,
                                  child: Material(
                                    color: Colors.white,
                                    shape: CircleBorder(),
                                    child: InkWell(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3000)),
                                      onTap: () {

                                        _showDialog(context);
                                      },
                                      child: Container(
                                        width: 40 * sizeMul,
                                        height: 40 * sizeMul,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3000)),
                                            color: Colors.white),
                                        // color: Colors.white,
                                        child: Icon(FontAwesomeIcons.question,
                                            color: Colors.green,
                                            size: 35 * sizeMul),
                                      ),
                                    ),
                                  ),
                                ),

                                // Positioned(
                                //   bottom: 0,
                                //   child: Container(
                                //     padding: EdgeInsets.all(sizeMul * 8),
                                //     width: MediaQuery.of(context).size.width,
                                //     height: sizeMul * 60,
                                //     color: Colors.green,
                                //     // color: Colors.black.withOpacity(0.3),
                                //     child: RaisedButton(
                                //       onPressed: () {
                                //         // cs.controller.
                                //         ccModel.capturePhoto().then((_) {
                                //           ccModel.cameraScreenState.controller
                                //               .dispose();
                                //           Navigator.push(context,
                                //               CupertinoPageRoute(
                                //                   builder: (context) {
                                //             return EditReceiptScreen(appModel
                                //                 .editReceiptScreenModel);
                                //           }));
                                //           // }
                                //         });
                                //       },
                                //       shape: CircleBorder(),
                                //     ),
                                //   ),
                                // )
                              ],
                            ));
                      }));
            }),
      ),
    );
  }
}

_showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return Container(
        //   // color: Colors.white,
        //   // width: ,
        //   decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(sizeMul*30)),

        //   color: Colors.white),

        //   child:  Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       Icon(FontAwesomeIcons.info, color: Colors.green,size: 30,),
        //       SizedBox(height: sizeMul*8,),
        //       Text("Add new receipt by taking a photo of it.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600, fontSize: sizeMul*18),),
        //       SizedBox(height: sizeMul*5,)
        //     ],
        //   ),
        //  );

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height:   15,
              ),
              Icon(
                FontAwesomeIcons.info,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(
                height:  15,
              ),
              Text(
                "Add a new receipt by taking a photo of it and filling out relevant details.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: sizeMul * 18),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Never show again"),
                  Checkbox(
                    onChanged: (val) {},
                    value: false,
                  )
                ],
              ),
              SizedBox(
                height: sizeMul * 15,
              )
            ],
          ),
        );
      });
}
