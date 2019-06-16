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
import 'package:papyrus_client/models/CameraCaptureModel.dart'; 
import 'ReceiveReceiptScreen.dart';


// CameraController globalController;

class CameraQRScanTab extends StatefulWidget {
  CameraCaptureModel ccModel;
  CameraQRScanTab(this.ccModel);
  @override
  _CameraQRScanTabState createState() => _CameraQRScanTabState(ccModel);
}

class _CameraQRScanTabState extends State<CameraQRScanTab> {
  CameraCaptureModel ccModel;
  // CameraScreenState cs = CameraScreenState();
  // CameraController controller;

  _CameraQRScanTabState(this.ccModel);

  @override
  void initState() {
    print(
        "HHHHHHHHHHHHHHHHHHHHHHHHHHHHAAAAAAAAAAAAAAwhen is initstate called?");
    ccModel.launchQRScan();
    // initializeCameras(cs, this);

    super.initState();
  }

  @override
  void dispose() {
    // ccModel.stopCapturingFrames();
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
                            color: Colors.green,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
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
                                        // globalController = ccModel
                                        //     .cameraScreenState.controller;
                                        return (ccModel.cameraScreenState
                                                .controllerInitSuccesful)
                                            ? ClipShadowPath(
                                                shadow: Shadow(
                                                    blurRadius: 10 * sizeMulW,
                                                    offset: Offset(0, sizeMulW),
                                                    color: Colors.black38
                                                        .withAlpha(0)),
                                                clipper: CustomShapeClipper(
                                                    sizeMulW: sizeMulW,
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            sizeMulW * 120),
                                                child: Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    decoration: BoxDecoration(
                                                        gradient: greeny),
                                                    child: CameraPreview(ccModel.cameraScreenState.controller)))
                                            : Center(
                                                child: Text(
                                                  "Camera cannot be accessed.\nDid you accept permissions?",
                                                  style: TextStyle(
                                                      fontSize: sizeMulW * 23,
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
                                                    blurRadius: 10 * sizeMulW,
                                                    offset: Offset(0, sizeMulW),
                                                    color: Colors.black38
                                                        .withAlpha(0)),
                                                clipper: CustomShapeClipper(
                                                    sizeMulW: sizeMulW,
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            sizeMulW * 120),
                                                child: Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    decoration: BoxDecoration(
                                                        gradient: greeny),
                                                    child: CameraPreview(ccModel.cameraScreenState.controller)))
                                            : Center(
                                                child: Text(
                                                  "Camera cannot be accessed.\nDid you accept permissions?",
                                                  style: TextStyle(
                                                      fontSize: sizeMulW * 23,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              );
                                      }
                                    }),
                                Positioned(
                                  bottom: (30 * sizeMulW),
                                  left: homeButtonDist + 18 * sizeMulW,
                                  child: Material(
                                    shape: CircleBorder(),
                                    child: InkWell(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3000)),
                                      splashColor: Colors.red,
                                      highlightColor: Colors.amber,
                                      onTap: () {
                                        // ccModel.connectToWifi();
                                        ccModel
                                            .captureQRPhoto()
                                            .then((successful) {
                                          print("Was it worth it in the end?" +
                                              successful.toString());
                                          if (!successful) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      content: Text(
                                                    "QR code is unreadable. Please scan again.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ));
                                                });
                                          }
                                          else {
                                            
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ReceiveReceiptScreen(appModel.receiveReceiptModel)));





                                          }
                                        });
                                      },
                                      child: Container(
                                          width: sizeMulW * 74.052,
                                          height: sizeMulW * 74.052,
                                          child: Icon(FontAwesomeIcons.expand,
                                              color: Colors.green,
                                              size: 35 * sizeMulW)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: (22 * sizeMulW),
                                  left: homeButtonDist - 45 * sizeMulW,
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
                                        width: 40 * sizeMulW,
                                        height: 40 * sizeMulW,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3000)),
                                            color: Colors.white),
                                        // color: Colors.white,
                                        child: Icon(FontAwesomeIcons.question,
                                            color: Colors.green,
                                            size: 35 * sizeMulW),
                                      ),
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   bottom: 0,
                                //   child: Container(
                                //     padding: EdgeInsets.all(sizeMulW * 8),
                                //     width: MediaQuery.of(context).size.width,
                                //     height: sizeMulW * 60,
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

                                Center(
                                  child: Icon(Icons.crop_free,
                                      size: sizeMulW * 400,
                                      color: Colors.black.withOpacity(0.1)),
                                )
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
        //   decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(sizeMulW*30)),

        //   color: Colors.white),

        //   child:  Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       Icon(FontAwesomeIcons.info, color: Colors.green,size: 30,),
        //       SizedBox(height: sizeMulW*8,),
        //       Text("Add new receipt by taking a photo of it.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600, fontSize: sizeMulW*18),),
        //       SizedBox(height: sizeMulW*5,)
        //     ],
        //   ),
        //  );

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Icon(
                FontAwesomeIcons.info,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Scan QR code shown on Papyrus dock to high-speed transfer through Wi-fi",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: sizeMulW * 18),
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
                height: sizeMulW * 15,
              )
            ],
          ),
        );
      });
}
