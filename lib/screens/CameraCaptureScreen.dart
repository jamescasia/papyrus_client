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
                                            ? CameraPreview(ccModel
                                                .cameraScreenState.controller)
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
                                            ? CameraPreview(ccModel
                                                .cameraScreenState.controller)
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
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(sizeMul*8),
                                    width: MediaQuery.of(context).size.width,
                                    height: sizeMul * 60,
                                    color: Colors.green,
                                    // color: Colors.black.withOpacity(0.3),
                                    child: RaisedButton(
                                      
                                      onPressed: () {
                                        // cs.controller.
                                        ccModel.capturePhoto().then((_) {
                                          ccModel.cameraScreenState.controller
                                              .dispose();
                                          Navigator.push(context,
                                              CupertinoPageRoute(
                                                  builder: (context) {
                                            return EditReceiptScreen(appModel
                                                .editReceiptScreenModel);
                                          }));
                                          // }
                                        });
                                      },
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                )
                              ],
                            ));
                      }));
            }),
      ),
    );
  }
}
